SELECT *
    FROM employees 
    JOIN LATERAL 
        (SELECT * FROM departments
                  WHERE departments.department_id = employees.department_id
        ) derived_table
    ON 1=1;
    
SELECT *
    FROM employees 
    CROSS JOIN LATERAL 
        (SELECT * FROM departments
                  WHERE departments.department_id = employees.department_id
        ) derived_table
   ;
   
SELECT *
    FROM (SELECT last_name, department_id FROM employees) e
    CROSS JOIN LATERAL 
        (SELECT * FROM departments
                  WHERE departments.department_id = e.department_id
        ) derived_table
   ;


SELECT * 
    FROM departments
    CROSS JOIN LATERAL
         (SELECT employee_id, last_name, salary FROM employees
             WHERE departments.department_id = employees.department_id
             ORDER BY salary DESC FETCH FIRST 3 ROWS ONLY
         ) derived_table;       