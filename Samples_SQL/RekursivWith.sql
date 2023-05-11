/* Hierarchische Queries mit der rekursiven With-Klausel 
    - ANSI -Standard
    - Oracle, SQL Server, DB2:  WITH
    - PostgreSQL, MySQL:        WITH RECURSIVE
*/

-- top-down
WITH rek_topdown( eid, lname, mgrid ) AS  --Spaltenaliase sind Pflicht
    (   SELECT employee_id, last_name, manager_id  -- Anker
        FROM employees WHERE manager_id is null
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id   --Rekursion via Join
        FROM employees e, rek_topdown r WHERE e.manager_id = r.eid
    )
SELECT eid, lname, mgrid
FROM rek_topdown;



-- top-down with level (level ist Schlüsselwort bei Oracle -> step)
WITH rek_topdown( eid, lname, mgrid, step ) AS
    (   SELECT employee_id, last_name, manager_id, 1
        FROM employees WHERE manager_id is null
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, r.step+1
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT eid, lname, mgrid, step
FROM rek_topdown;



-- top-down with level and parentname
WITH rek_topdown( eid, lname, mgrid, mgrname, step ) AS
    (   SELECT employee_id, last_name, manager_id, '', 1
        FROM employees WHERE manager_id is null
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, r.lname, r.step+1
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT eid, lname, mgrid, mgrname, step
FROM rek_topdown;




-- top-down aufgeruescht
WITH rek_topdown( eid, lname, mgrid, path, step ) AS
    (   SELECT employee_id, last_name, manager_id, last_name as path, 1
        FROM employees WHERE manager_id is null
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id
              , r.path || '/' || e.last_name, r.step+1       
        FROM employees e JOIN rek_topdown r ON e.manager_id = r.eid
    )
SELECT eid, lname, mgrid, path, step
FROM rek_topdown;



--bottom-up
WITH rek_bottomup( eid, lname, mgrid, step ) AS
    (   SELECT employee_id, last_name, manager_id, 0 
        FROM employees WHERE employee_id = 107
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, r.step - 1
        FROM employees e, rek_bottomup r WHERE e.employee_id = r.mgrid
    )
SELECT eid, lname, mgrid, step
FROM rek_bottomup;




-- Oracle spezifisch: depth-first
WITH rek_topdown( eid, lname, mgrid, step ) AS
    (   SELECT employee_id, last_name, manager_id, 1
        FROM employees WHERE manager_id is null
      UNION ALL
        SELECT e.employee_id, e.last_name, e.manager_id, r.step+1
        FROM employees e, rek_topdown r WHERE e.manager_id = r.eid
    )
    SEARCH DEPTH FIRST BY lname SET order1
SELECT eid, lname, mgrid, step, order1
FROM rek_topdown
--ORDER BY order1 DESC
;


-- Oracle spezifisch: Cyclus-Erkennung
WITH
  dup_hiredate (eid, emp_last, mgr_id, reportLevel, hire_date, job_id) AS
  (
    SELECT employee_id, last_name, manager_id, 0 reportLevel, hire_date, job_id
    FROM employees
    WHERE manager_id is null
  UNION ALL
    SELECT e.employee_id, e.last_name, e.manager_id,
           r.reportLevel+1 reportLevel, e.hire_date, e.job_id
    FROM dup_hiredate r, employees e
    WHERE r.eid = e.manager_id
  )
  --SEARCH DEPTH FIRST BY hire_date SET order1
  CYCLE hire_date SET is_cycle TO 'Y' DEFAULT 'N'
SELECT emp_last emp_name, eid, mgr_id,
       hire_date, job_id, is_cycle
FROM dup_hiredate
--ORDER BY order1
;
