-- Ubungen: Analytische Funktionen

-- 1a. Zeigen Sie auf herkömmliche Weise folgendes je Mitarbeiter an:
-- Abteilungsnummer, Vornamen, Nachname, Gehalt und 
-- die Gehaltssumme der Abteilung (für jeden Mitarbeiter in einer Zeile)

-- Folgendes ist nicht ganz korrekt, da Mitarbeiter ohne Abteilung nicht 
-- berücksichtigt werden:
SELECT E1.DEPARTMENT_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.salary, E2.SUM_SAL
FROM EMPLOYEES E1 JOIN (SELECT DEPARTMENT_ID, SUM(SALARY) SUM_SAL
                          FROM EMPLOYEES
                          GROUP BY DEPARTMENT_ID) E2
                          ON E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
ORDER BY E1.DEPARTMENT_ID, E1.SALARY;

-- besser:
SELECT E1.DEPARTMENT_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.salary, E2.SUM_SAL
FROM EMPLOYEES E1 LEFT OUTER JOIN (SELECT DEPARTMENT_ID, SUM(SALARY) SUM_SAL
                          FROM EMPLOYEES
                          GROUP BY DEPARTMENT_ID) E2
                          ON E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
ORDER BY E1.DEPARTMENT_ID NULLS FIRST, E1.SALARY;

-- oder
SELECT E1.DEPARTMENT_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.SALARY, SUM(E2.SALARY)
FROM EMPLOYEES E1 LEFT OUTER JOIN EMPLOYEES E2
          ON E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
GROUP BY E1.DEPARTMENT_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.SALARY
ORDER BY E1.DEPARTMENT_ID NULLS FIRST, E1.SALARY;

-- oder 
SELECT E1.DEPARTMENT_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.SALARY
       , (SELECT SUM(SALARY) FROM EMPLOYEES E2
                    WHERE E1.DEPARTMENT_ID = E2.DEPARTMENT_ID) SUM_SAL
FROM EMPLOYEES E1 
ORDER BY E1.DEPARTMENT_ID NULLS FIRST, E1.SALARY;

-- 1b. Lösen Sie die gleiche Aufgabemittels Partitionierung
SELECT DEPARTMENT_ID
, LAST_NAME
, SALARY
, SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID) SUM_SAL
-- Vorsicht: SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID ORDER BY last_name)
-- ist etwas anderes (kumulatives Fenster)!!
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID NULLS FIRST, SALARY;

-- 2 Erweitern Sie die Lösung von 1b um eine fortlaufende Nummerierung 
-- innerhalb der jeweiligen Abteilungsgruppe
SELECT DEPARTMENT_ID
, LAST_NAME
, SALARY
, SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID) SUM_SAL
, ROW_NUMBER() OVER (PARTITION BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID) 
                             ZEILENUMMER
FROM EMPLOYEES;


-- 3. Listen Sie je Mitarbeiter die Abteilungskennung, den Nachnamen und das 
-- Gehalt, sowie den jeweils niedrigsten und höchsten Gehaltswert in der 
-- Abteilung auf
SELECT DEPARTMENT_ID, LAST_NAME, SALARY
, min(salary) OVER (PARTITION BY department_id) MIN_VALUE
, max(SALARY) OVER (PARTITION BY department_id) MAX_VALUE
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID, SALARY;


-- 4. Zeigen Sie das Ranking in der Variante dicht und normal der Mitarbeiter 
-- bzgl. ihres Gehalts unternehmensweit.
SELECT DEPARTMENT_ID, LAST_NAME, SALARY
, RANK() OVER (ORDER BY SALARY DESC) RANK
, DENSE_RANK() OVER (ORDER BY SALARY DESC) DENSE_RANK
FROM EMPLOYEES;


-- 5. Ergänzen Sie die Lösung von Aufgabe 4, so dass zusätzlich das Ranking 
-- der Mitarbeiter bzgl.ihres Gehalts in der Abteilung angezeigt wird.
SELECT DEPARTMENT_ID
, LAST_NAME
, SALARY
, RANK() OVER (ORDER BY SALARY DESC) RANK_SALARY_TOTAL
, RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) 
                            RANK_SALARY_DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;


-- 6. Ergänzen Sie Lösung 5, so dass nur die Top Ten, d.h. die teuersten 
-- 10 Mitarbeiter angezeigt werden.

-- nicht ganz korrekt, da ohne potentielle Ties
SELECT * FROM (
    SELECT DEPARTMENT_ID
    , LAST_NAME
    , SALARY
    , RANK() OVER (ORDER BY SALARY DESC) RANK_SALARY_TOTAL
    , RANK() OVER (PARTITION BY DEPARTMENT_ID
                    ORDER BY SALARY DESC) RANK_SALARY_DEPARTMENT_ID
    FROM EMPLOYEES
    ORDER BY RANK_SALARY_TOTAL)
WHERE ROWNUM < 11
;

-- besser
SELECT DEPARTMENT_ID
, LAST_NAME
, SALARY
, RANK() OVER (ORDER BY SALARY DESC) RANK_SALARY_TOTAL
, RANK() OVER (PARTITION BY DEPARTMENT_ID
ORDER BY SALARY DESC) RANK_SALARY_DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY RANK_SALARY_TOTAL FETCH FIRST 10 ROWS WITH TIES
;


-- 7. Teilen Sie die Mitarbeiter bzgl. ihres jeweiligen Gehalts in 5 Gruppen 
-- auf (benutzen Sie NTILE) und zeigen Sie Gruppe, Nachname  und Gehalt je 
-- Mitarbeiter an.
SELECT   NTILE(5) OVER (ORDER BY salary DESC) AS GRUPPE
       , LAST_NAME
       , salary       
FROM EMPLOYEES;


-- 8. Erweitern Sie vorherige Aufgabe so, dass je Mitarbeiter zusätzlich die 
-- Gehaltsumme je Gruppe angezeigt wird.
SELECT g.GRUPPE, g.LAST_NAME, g.SALARY, 
        SUM(g.SALARY) OVER (PARTITION BY g.GRUPPE) AS GESAMT
FROM (SELECT   NTILE(5) OVER (ORDER BY salary DESC) GRUPPE
              , LAST_NAME
              , SALARY      
      FROM EMPLOYEES) g;
      


-- 9. Listen Sie die Mitarbeiter mit ihrem Nachnamen, Einstellungsdatum und 
-- Gehalt, sowie jeweils das Gehalt des Mitarbeiters, der davor bzw. danach 
-- eingestellt wurde.
SELECT LAST_NAME, HIRE_DATE, SALARY
, LAG(SALARY) OVER (ORDER BY HIRE_DATE) LAG_SAL    
, LEAD(SALARY) OVER (ORDER BY HIRE_DATE) LEAD_SAL
FROM EMPLOYEES
ORDER BY HIRE_DATE;



-- 10. Ändern Sie Lösung 9 so, dass die Auflistung je Abteilung erfolgt und der 
-- jeweils vorletzte bzw. übernächste Wert angezeigt wird.
SELECT DEPARTMENT_ID, LAST_NAME, HIRE_DATE, SALARY
, LAG(SALARY, 2) OVER (PARTITION BY department_id ORDER BY HIRE_DATE) LAG_SAL
, LEAD(SALARY, 2) OVER (PARTITION BY department_id ORDER BY HIRE_DATE) LEAD_SAL
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID, HIRE_DATE;


-- 11. Listen Sie je Abteilung die Mitarbeiter mit ihrem Nachnamen, 
-- Einstellungsdatum sowie jeweils das Einstellungsdatum und Gehalt des 
-- Mitarbeiters, der als erster in der Abteilung und des Mitarbeiters, der 
-- als letzter in der Abteilung eingestellt wurde.  
SELECT DEPARTMENT_ID, LAST_NAME, HIRE_DATE, salary
, FIRST_VALUE(HIRE_DATE) OVER (PARTITION BY department_id 
                               ORDER BY HIRE_DATE
                          -- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                            ) fh
, FIRST_VALUE(salary) OVER (PARTITION BY department_id 
                               ORDER BY HIRE_DATE
                          -- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                            ) fs                         
, LAST_VALUE(HIRE_DATE) OVER (PARTITION BY department_id 
                               ORDER BY HIRE_DATE
                               ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
                            ) lh
, LAST_VALUE(salary) OVER (PARTITION BY department_id 
                               ORDER BY HIRE_DATE
                               ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
                            ) ls
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID 
--, HIRE_DATE
;



-- 12. Listen Sie je Mitarbeiter die Abteilungskennung, den Nachnamen, das 
-- Einstellungsdatum und das Gehalt, sowie die fortlaufende Summe der Gehälter 
-- einschließlich des aktuellen Mitarbeiters bzgl. des Einstellungsdatums in 
-- der Abteilung auf.
SELECT DEPARTMENT_ID, LAST_NAME, HIRE_DATE, SALARY
, sum(salary) OVER (PARTITION BY department_id ORDER BY HIRE_DATE) CUM_SUM
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID, HIRE_DATE;


-- 13. Listen Sie für jede Abteilung die Mitarbeiter (Abteilungsnummer, Name, 
-- Gehalt) auf, sowie die Anzahl der Mitarbeiter die bis zu 500 mehr bekommen.
SELECT DEPARTMENT_ID
, LAST_NAME
, SALARY
, COUNT(*) OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY
		RANGE BETWEEN 0 PRECEDING AND 500 FOLLOWING) 
    -1 COUNT_SAL   -- -1 weil der aktuelle Wert mitgezählt wird
FROM EMPLOYEES;



-- 14. Zeigen Sie je Kalenderjahr, beginnend mit 2001, die Anzahl der 
-- Mitarbeiter, die in einem Monat, und die Anzahl der Mitarbeiter, die bis zu
-- diesem Monat im jeweiligen Jahr eingestellt wurden, an.
SELECT TO_CHAR(HIRE_DATE, 'YYYY') YEAR
, TO_CHAR(HIRE_DATE, 'MM') MONTH
, COUNT(TO_CHAR(HIRE_DATE, 'MM')) AS AMOUNT
, SUM(COUNT(TO_CHAR(HIRE_DATE, 'MM')))
     OVER (PARTITION BY TO_CHAR(HIRE_DATE, 'YYYY')
     ORDER BY TO_CHAR(HIRE_DATE, 'MM')) AMOUNTUNTIL
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'MM');

-- oder klassisch
SELECT s.YEAR
       , s.MONTH
       , s.AMOUNT
       , SUM(AMOUNT) OVER (PARTITION BY s.YEAR ORDER BY s.MONTH) AMOUNTUNTIL
FROM
    (SELECT TO_CHAR(HIRE_DATE, 'YYYY') YEAR
        , TO_CHAR(HIRE_DATE, 'MM') MONTH
        , COUNT(TO_CHAR(HIRE_DATE, 'MM')) AS AMOUNT
     FROM EMPLOYEES
     GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'MM')
    ) s;




