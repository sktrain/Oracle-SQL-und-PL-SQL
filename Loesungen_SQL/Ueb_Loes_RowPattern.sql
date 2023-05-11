-- Loesungen: Row Pattern Matching

/* Gibt es bei den Coronazahlen nach Geschlecht (CorZahlenFuldaMitGeschlecht)
je Geschlecht Phasen mit gleichbleibenden Fallzahlen und wie lange war der
Zeitraum.
Zeigen Sie je Geschlecht den Zeitraum (Start, Ende) und die Fallzahl an.
*/

SELECT * FROM CORZAHLENFULDAGESCHLECHT MATCH_RECOGNIZE (
    PARTITION BY geschlecht
    ORDER BY MELDEDATUM
    MEASURES STRT.meldedatum AS start_day,
             KONSTANT.meldedatum AS last_day, -- ist LAST
             STRT.fallzahl AS start_zahl             
    ONE ROW PER MATCH
    AFTER MATCH SKIP PAST LAST ROW --default
    PATTERN (STRT KONSTANT+)
    DEFINE KONSTANT AS KONSTANT.fallzahl = PREV(KONSTANT.fallzahl)
    ) m ORDER BY m.geschlecht, m.start_day;
    
    
/*
Wir suchen bei den Angestellten bzgl. der Reihenfolge ihres Einstellungsdatums
nach den Fällen, bei denen 3-mal in Folge das Gehalt niedriger als das 
das Vorgängergehalt ist.
Ausgegeben soll jeweils eine Zeile per getroffenem Muster mit der Id, Nachnamen, 
Einstellungsdatum, Gehalt der Startzeile und mit der Id, Nachnamen, 
Einstellungsdatum und Gehalt der Endzeile
*/

SELECT * FROM employees
    MATCH_RECOGNIZE (
        ORDER BY hire_date
        MEASURES MATCH_NUMBER() as matchno
            ,    FIRST(employee_id) as firstempid
            ,    FIRST(last_name) as firstlastname           
            ,    FIRST(hire_date) as firstdate
            ,    FIRST(salary) as startsalary
            ,    LAST(employee_id) as lastempid
            ,    LAST(last_name) as lastlastname
            ,    LAST(hire_date) as lastdate
            ,    LAST(salary) as lastsal
        PATTERN (BEG DOWN{3})
        DEFINE  DOWN AS salary < PREV(salary)  );



/* Zeigen Sie die Mitarbeiter an, die mindestens zweimal den Job bzw.
die Abteilung gewechselt haben (mind. 2 Einträge in der "Job_History").
Listen Sie Nachnamen, erste Jobkennung, erste Abteilung sowie aktuelle 
Jobkennung und Abteilung auf.
(Geht auch einfacher ohne Row Pattern)
*/

SELECT * FROM job_history
ORDER BY employee_id;

SELECT last_name, actualjob, actualdep
       , firstjob, firstdep
  FROM JOB_History
    MATCH_RECOGNIZE (
        ORDER BY employee_id
        MEASURES 
            FIRST(A.employee_id) as mrempid
           ,FIRST(A.job_id) as firstjob
           ,FIRST(A.department_id) as firstdep
        PATTERN ( S A{1,})  -- S für Start
        DEFINE A AS A.employee_id = PREV(A.employee_id)
    ) --mr
    JOIN (SELECT employee_id as empid
                 , last_name
                 , job_id as actualjob
                 , department_id as actualdep
            FROM employees) --actual
    ON mrempid = empid;





/* In einer Tabelle mit fortlaufenden Zahlen, die aber Lücken enthalten, suchen
wir nach den Abschnitten ohne Lücken und wollen je Abschnitt eine Zeile haben.
Die Zeile soll den Start- und Endwert zeigen.
Die folgende CREATE TABLE Anweisung erzeugt eine simple Ausgangstabelle, die
anschließend mit fortlaufenden Zahlen inklusive Lücken gefüllt wird.
*/
        
CREATE TABLE T_GAPS (id Number(3,0));

DECLARE 
  n NUMBER :=1;
BEGIN
  while (n < 200)
  loop
    INSERT INTO T_GAPS VALUES(n);
    IF mod(n, 10) = 0
        THEN n := n + 4;
        ELSE n := n + 1;
    END IF;
  END LOOP;
END;

SELECT * FROM T_GAPS
    MATCH_RECOGNIZE (
        ORDER BY id
        MEASURES 
            FIRST(id) "start_of_range"
            , LAST(id) "end_of_range"
            --ONE ROW PER MATCH  -- default
            PATTERN (STRT CONT+)
            DEFINE CONT AS id = PREV(id) + 1
    );
    
    
-- eine herkömmliche Variante 
-- ist in der Regel auch Performance-technisch schlechter
-- Überlegung: 
-- Lücken markieren (Subquery sub1)
-- Identifizierte Bereiche aggregieren um auf eine Ergebniszeile zu kommen
-- (Subquery sub2)
-- Hauptquery wertet aus

SELECT MIN(id) "start_of_range", MAX(id) "end_of_range"
    FROM (
    SELECT id, SUM(marker) OVER (ORDER BY id) msum
        FROM (
        SELECT  id
            , CASE 
                 WHEN id != LAG(id, 1, id) OVER (ORDER BY id) +1 
                 THEN 1
                    ELSE 0
              END AS marker
        FROM T_GAPS
        ) sub1
    ) sub2
    GROUP BY msum
    ORDER BY msum;
    
-- oder wer es lieber mit WITH-Klausel mag
WITH sub1 AS (
    SELECT  id
            , CASE 
                 WHEN id != LAG(id, 1, id) OVER (ORDER BY id) +1 
                 THEN 1
                    ELSE 0
              END AS marker
        FROM T_GAPS )
  , sub2 AS (
    SELECT id, SUM(marker) OVER (ORDER BY id) msum
        FROM sub1
    )
SELECT MIN(id) "start_of_range", MAX(id) "end_of_range"
    FROM sub2
    GROUP BY msum
    ORDER BY msum;
     

/* Hierarchical child count:
Ausgangspunkt ist die Employees-Tabelle. Wir wollen zu jedem Angestellten
wissen, wie viele andere sind ihm direkt und indirekt unterstellt (auch die
tieferen Ebenen).
Folgender Query liefert die gesamte Hierarchie (depth-first) beginnend bei 
dem obersten Chef (siehe auch hierarchische Queries) und bildet die Basis 
zur Ermittlung der Zahlen.
Zur besseren Nachvollziehbarkeit kann man sich ja erstmal alle Zeilen je 
getroffenen Muster anzeigen lassen.
*/
select level as lvl, employee_id, last_name, manager_id, rownum as rn
        from employees
       start with manager_id is null
       connect by manager_id = prior employee_id
       order siblings by employee_id;

/* Lösungsansatz:
Wenn wir nach der Hierarchie (depth-first)ordnen, sind die folgenden 
Angestellten mit einem höheren Level die Unterstellten.
Wenn wir einen Angestellten erreichen mit einem gleichen oder niedrigeren
Level ist die Suche beendet. Wir müssen die getroffenen Zeilen nur zählen.
Allerdings müssen wir mit dem nächsten Angestellten weiter machen und nicht mit 
der Zeile hinter unserem Treffer, wir wollen ja alle Angestellten 
berücksichtigen.
*/

with hierarchy as (
   select lvl, employee_id, last_name, rownum as rn
   from (
      select level as lvl, employee_id, last_name
        from employees
       start with manager_id is null
       connect by manager_id = prior employee_id
       order siblings by employee_id
   )
)
select match_no, rn
     , employee_id, lpad(' ', (lvl-1)*2) || last_name as ename
     , rolling_cnt, subs, class
     , strt_no, strt_name, high_no, high_name
  from hierarchy
match_recognize (
   order by rn
   measures
      match_number() as match_no
    , classifier() as class
    , strt.employee_id as strt_no
    , strt.last_name as strt_name
    , higher.employee_id as high_no
    , higher.last_name as high_name
    , count(higher.lvl) as rolling_cnt
    , final count(higher.lvl) as subs
   all rows per match
   after match skip to next row
   pattern ( strt higher* )
   define
      higher as higher.lvl > strt.lvl
)
 order by match_no, rn;
 
-- jetzt nur eine Zeile je Treffer

with hierarchy as (
   select lvl, employee_id, last_name, rownum as rn
   from (
      select level as lvl, employee_id, last_name
        from employees
       start with manager_id is null
       connect by manager_id = prior employee_id
       order siblings by employee_id
   )
)
select *
  from hierarchy
match_recognize (
   order by rn
   measures
      match_number() as match_no
    --, classifier() as class
    , strt.employee_id as strt_no
    , strt.last_name as strt_name
    --, higher.employee_id as high_no
    --, higher.last_name as high_name
    --, count(higher.lvl) as rolling_cnt
    , final count(higher.lvl) as subs
   -- all rows per match
   after match skip to next row
   pattern ( strt higher* )
   define
      higher as higher.lvl > strt.lvl
)
 order by match_no;
 
-- Wollen wir die "Indianer" weglassen, genügt es das Pattern
-- auf ( str higher+ ) zu setzen!
-- Ebenso, wäre es möglich weitere Aggregate. z.B. max bzgl des Levels zu
-- berechnen.


-- Eine klassische Alternative ohne Row Pattern Matching
-- allerdings mit schlechter Performance, da vielfacher Tabellenzugriff.

select employee_id
     , lpad(' ', (level-1)*2) || last_name as ename
     , (
         select count(*)
           from employees sub
          start with sub.manager_id = employees.employee_id
          connect by sub.manager_id = prior sub.employee_id
       ) subs
  from employees
 start with manager_id is null
 connect by manager_id = prior employee_id
 order siblings by employee_id;
