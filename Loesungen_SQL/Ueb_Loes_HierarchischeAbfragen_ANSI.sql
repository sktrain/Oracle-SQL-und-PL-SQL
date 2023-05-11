-- Übungen: Hierarchische Queries

-- 1a. Schreiben Sie eine hierarchische Abfrage für die Mitarbeiter des Managers 
-- Mourgos, beginnend mit diesem. Es sollen die Nachnamen, Gehälter und 
-- Abteilungsnummern der Mitarbeiter, sowie die Hierarchie-Ebene angezeigt 
-- werden.
WITH rek_topdown( lname, sal, depid, level1, eid  ) AS  --eid wird für Join benötigt
    (   SELECT last_name, salary, department_id, 1, employee_id
        FROM employees WHERE last_name = 'Mourgos'
      UNION ALL
        SELECT e.last_name, e.salary, e.department_id, r.level1+1, e.employee_id
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT lname, sal, depid, level1
FROM rek_topdown;



-- 1b. Erweitern Sie die vorherige Ausgabe um Pfadangaben, die die
-- Hierarchie verdeutlichen.
WITH rek_topdown( lname, sal, depid, level1, eid, path  ) AS  --eid wird für Join benötigt
    (   SELECT last_name, salary, department_id, 1, employee_id
        , last_name
        FROM employees WHERE last_name = 'Mourgos'
      UNION ALL
        SELECT e.last_name, e.salary, e.department_id, r.level1+1, e.employee_id
        , r.path || '/' || e.last_name
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT lname, sal, depid, level1, path
FROM rek_topdown;





-- 2 Zeigen Sie die Managerhierarchie für den Mitarbeiter Lorentz an, 
-- beginnend mit dem direkten Vorgesetzten.
WITH rek_bottomup( eid, lname, mgrid, path ) AS
    (   SELECT employee_id, last_name, manager_id, last_name 
        FROM employees WHERE last_name = 'Lorentz'
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id
        , e.last_name || '/' || r.path
        FROM employees e JOIN rek_bottomup r ON e.employee_id = r.mgrid
    )
SELECT eid, lname, mgrid, path
FROM rek_bottomup;





-- 3. Erzeugen Sie eine fortlaufende tagesweise Liste von Datumswerten,
-- beginnend mit dem Datum '2021-01-01' bis zum '2021-12-31'.
-- Bei Oracle können Sie zum Datum die Anzahl Tage mit dem +-Operator 
-- hinzufügen.
WITH  my_dates(dt) AS 
    (
        SELECT DATE '2021-01-01' FROM DUAL
      UNION ALL 
        SELECT dt + 1   FROM my_dates   
            WHERE dt < DATE '2021-12-31')
SELECT * FROM my_dates;

/*
DT      
--------
01.01.21
02.01.21
03.01.21
04.01.21
05.01.21
06.01.21
...
*/




-- 4. Zeigen Sie die Mitarbeiterkennung, die Managerkennung, den Nachnamen, 
-- sowie die Ebene der Mitarbeiter an, die sich 2 Ebenen unter dem Mitarbeiter
-- De Haan befinden.
WITH rek_topdown( eid, lname, mgrid, level1 ) AS  
    (   SELECT employee_id, last_name, manager_id, 1 
        FROM employees WHERE last_name = 'De Haan'                            
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, r.level1+1
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid 
    )
SELECT eid, lname, mgrid, level1
FROM rek_topdown 
WHERE level1 = 3;




-- 5. Zeigen Sie die Managementhierarchie beginnend mit dem Mitarbeiter Kochhar
-- an (top-down). Geben Sie jeweils Nachname, Managerkennung und Abteilungs_
-- nummer der Mitarbeiter aus. Dabei sollen die Zeilen je Hierarchiestufe um 5
-- Positionen eingerückt werden und die Einrückung mit "_"-Zeichen verdeutlicht
-- werden (Hinweis: Verwenden Sie die LPAD-Funktion)
WITH rek_topdown( lname, mgrid, depid, level1, eid  ) AS  --eid wird für Join benötigt
    (   SELECT last_name, manager_id, department_id, 1, employee_id
        FROM employees WHERE last_name = 'Kochhar'
      UNION ALL
        SELECT e.last_name, e.manager_id, e.department_id, r.level1+1, e.employee_id
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT LPAD(lname, LENGTH(lname)+(level1 * 2) -2, '_') "Lastname" , mgrid, depid, level1
FROM rek_topdown;








-- 6. Zeigen Sie die Managementhierarchie unter dem Mitarbeiter De Haan an,
-- verwenden Sie dabei aber dessen Mitarbeiterkennung. 
-- Geben Sie jeweils Nachname, Mitarbeiter-, Manager- und Jobkennung aus.
-- Ordnen Sie die Ausgabe in den Zweigen nach den Nachnamen.
-- Hinweis: Verwenden Sie die Oracle-spezifische Erweiterung
-- SEARCH DEPTH FIRST 
WITH rek_topdown( eid, lname, mgrid, jobid, level1 ) AS  
    (   SELECT employee_id, last_name, manager_id, job_id, 1 
        FROM employees WHERE employee_id IN (SELECT employee_id FROM employees
                               WHERE last_name = 'De Haan')                            
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, e.job_id, r.level1+1
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid                                 
    )
    SEARCH DEPTH FIRST BY lname SET order1
SELECT eid, lname, mgrid, jobid, level1, order1
FROM rek_topdown;

 -- nur zur Gegenprobe: Oracle spezifisch
SELECT last_name, employee_id, manager_id, job_id,
        SYS_CONNECT_BY_PATH(last_name, '/') "Pfad"
FROM employees
START WITH employee_id = (SELECT employee_id FROM employees
                               WHERE last_name = 'De Haan')
  CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;







-- 7.Zeigen Sie die gesamte Managementhierarchie ohne Indianer topdown mit 
-- Mitarbeiterkennung, Managerkennung, Nachnamen, Ebene an 
-- und zusätzlich je Manager die Gesamtanzahl ihm unterstellter Mitarbeiter
-- (d.h. akkumuliert: Steven King hat bei 107 Mitarbeitern 106 unter sich)
WITH
  emp_count (eid, emp_last, mgr_id, mgrLevel, salary, cnt_employees) AS
  (
    SELECT employee_id, last_name, manager_id, 0 mgrLevel, salary, 0 cnt_employees
    FROM employees
  UNION ALL
    SELECT e.employee_id, e.last_name, e.manager_id,
           r.mgrLevel+1 mgrLevel, e.salary, 1 cnt_employees
    FROM emp_count r, employees e
    WHERE e.employee_id = r.mgr_id
  )
SELECT emp_last, eid, mgr_id, salary, sum(cnt_employees), max(mgrLevel) mgrLevel
FROM emp_count
GROUP BY emp_last, eid, mgr_id, salary
HAVING max(mgrLevel) > 0
ORDER BY mgr_id NULLS FIRST, emp_last;

/*
EMP_LAST                  EID     MGR_ID     SALARY SUM(CNT_EMPLOYEES)   MGRLEVEL
------------------ ---------- ---------- ---------- ------------------ ----------
King                      100                 24000                106          3
Cambrault                 148        100      11000                  7          2
De Haan                   102        100      17000                  5          2
Errazuriz                 147        100      12000                  6          1
Fripp                     121        100       8200                  8          1
Hartstein                 201        100      13000                  1          1
Kaufling                  122        100       7900                  8          1
. . .  
*/





-- 8. Zeigen Sie die Managementhierarchie beginnend mit der Person auf der
-- obersten Ebene (eventuell gibt es mehrere) an (top-down). 
-- Geben Sie jeweils Nachname, Mitarbeiter-, Manager- und Jobkennung aus.
-- Alle Mitarbeiter mit der Jobkennung IT_PROG sowie der Mitarbeiter De Haan 
-- und alle ihm unterstellten Mitarbeiter sollen ausgeschlossen werden.
-- Ordnen Sie die Ausgabe in den Zweigen nach den Nachnamen.
-- Hinweis: Verwenden Sie die Oracle-spezifische Erweiterung
-- SEARCH DEPTH FIRST 
WITH rek_topdown( eid, lname, mgrid, jobid, level1 ) AS  
    (   SELECT employee_id, last_name, manager_id, job_id, 1 
        FROM employees WHERE manager_id is null                            
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, e.job_id, r.level1+1
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid 
                AND e.last_name != 'De Haan'        
        WHERE e.job_id != 'IT_PROG' OR r.lname != 'De Haan'                                     
    )
    SEARCH DEPTH FIRST BY lname SET order1
SELECT eid, lname, mgrid, jobid, level1
FROM rek_topdown;



-- nur zur Gegenprobe: Oracle-Variante
SELECT last_name, employee_id, manager_id, job_id, level 
FROM employees
WHERE job_id != 'IT_PROG'
START WITH manager_id is null
  CONNECT BY PRIOR employee_id = manager_id
            AND last_name != 'De Haan'
ORDER SIBLINGS BY last_name;

