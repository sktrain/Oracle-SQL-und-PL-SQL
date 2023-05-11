/* Erstellen Sie mittels Unterabfrage auf die HR.EMPLOYEES-Tabelle
3 Tabellen "emp_salary", "emp_low_salary", "emp_high_salary" 
mit jeweils 3 Spalten, wobei Sie folgende Spalten
"employee_id, last_name, salary" aus der HR.EMPLOYEES-Tabelle
�bernehmen.
Versuchen Sie keine Datens�tze mit zu �bernehmen. */

CREATE TABLE emp_salary
 AS (SELECT employee_id, last_name, salary FROM employees
         WHERE employee_id = 0);
         
CREATE TABLE emp_low_salary
 AS (SELECT employee_id, last_name, salary FROM employees
         WHERE employee_id = 0);
         
CREATE TABLE emp_high_salary
 AS (SELECT employee_id, last_name, salary FROM employees
         WHERE employee_id = 0);
         
/* F�gen Sie alle Datens�tze aus der EMPLOYEES-Tabelle
der Abteilung 50 in die 3 neu erstellten Tabellen */

INSERT ALL 
 INTO emp_salary VALUES (employee_id, last_name, salary)
 INTO emp_low_salary VALUES (employee_id, last_name, salary)
 INTO emp_high_salary VALUES (employee_id, last_name, salary)
 SELECT employee_id, last_name, salary FROM employees
    WHERE department_id = 50;

/* F�gen Sie alle Datens�tze aus der EMPLOYEES-Tabelle
der Abteilung 100 in die 3 neu erstellten Tabellen,
wobei Zeilen mit einem Gehalt < 5000 in die emp_low_salary
- Tabelle, Zeilen mit einem Gehalt < 10000 
in die emp_salary-Tabelle und Zeilen mit einem h�heren 
Gehalt in die emp_high_salary-Tabelle wandern sollen. */

INSERT ALL
 WHEN salary < 5000 THEN
  INTO emp_low_salary VALUES (employee_id, last_name, salary)
 WHEN salary < 10000 THEN
  INTO emp_salary VALUES (employee_id, last_name, salary)
 WHEN salary >= 10000 THEN
  INTO emp_high_salary VALUES (employee_id, last_name, salary)
SELECT employee_id, last_name, salary FROM employees
      WHERE department_id = 100;
      
/* F�gen Sie alle Datens�tze aus der EMPLOYEES-Tabelle
der Abteilung 90 in die 3 neu erstellten Tabellen,
wobei Zeilen mit einem Gehalt < 5000 nur in die emp_low_salary
- Tabelle, Zeilen mit einem Gehalt >= 5000 und < 10000 
in die emp_salary-Tabelle und Zeilen mit einem h�heren 
Gehalt in die emp_high_salary-Tabelle wandern sollen. */
      
INSERT FIRST
 WHEN salary < 5000 THEN
  INTO emp_low_salary VALUES (employee_id, last_name, salary)
 WHEN salary < 10000 THEN
  INTO emp_salary VALUES (employee_id, last_name, salary)
 ELSE
  INTO emp_high_salary VALUES (employee_id, last_name, salary)
SELECT employee_id, last_name, salary FROM employees
      WHERE department_id = 90;

/* Mischen Sie in die Zieltabelle emp_salary alle Datens�tze
der EMPLOYEES-Tabelle, wobei auf Basis der employee_id ein
UPDATE in der Zieltabelle erfolgt, der den Nachnamen auf 
'Mustermann' setzt, und ansonsten die Zeilen in die Zieltabelle
�bernimmt. */

MERGE INTO emp_salary
  USING employees 
    ON (emp_salary.employee_id = employees.employee_id)
  WHEN MATCHED THEN 
      UPDATE SET emp_salary.last_name = 'Mustermann'
  WHEN NOT MATCHED THEN
      INSERT VALUES (employees.employee_id,
                     employees.last_name,
                     employees.salary)
                     ;
  
    
