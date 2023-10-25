-- ohne Pivot
SELECT job_id, department_id, sum(salary)
    FROM employees 
    WHERE department_id IN (10, 20, 30, 40, 50)
    GROUP BY job_id, department_id
    ORDER BY job_id;

-- Pivot - 1: entspricht aber nicht der obigen Variante, da hier alle job_id
SELECT * FROM
    (SELECT job_id, department_id, salary FROM employees )
 PIVOT 
    ( sum(salary) for department_id IN (10, 20, 30, 40, 50))
 ORDER BY job_id ;
    
-- Pivot - 2: mit Entsprechung "ohne Pivot"
SELECT * FROM
    (SELECT job_id, department_id, salary FROM employees
          WHERE department_id IN (10, 20, 30, 40, 50))
 PIVOT 
    ( sum(salary) for department_id IN (10, 20, 30, 40, 50))
 ORDER BY job_id ;
  
 -- Pivot - 1  entspricht folgender Variante ohne Pivot bis auf NULL-Values
 -- in der department_id und ohne Einschränkung der Departments!
SELECT * FROM 
    (SELECT job_id, department_id, sum(salary)
    FROM employees 
    GROUP BY job_id, department_id)
    WHERE department_id IN (10, 20, 30, 40, 50)
    ORDER BY job_id;
 
 


