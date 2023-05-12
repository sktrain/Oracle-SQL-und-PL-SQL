/* Erstellen Sie eine Funktion, die für eine gegebene Mitarbeiterkennung das
 * jährliche Gesamtgehalt des Mitarbeiters liefert.
 * Dieses berechnet sich wie folgt:
 * (salary*12) + (commission_pct*salary*12)
 * Die Funktion soll auch für eventuelle Null-Werte beim Gehalt oder der
 * Provision einen entsprechenden numerischen Wert liefern.
 */
CREATE OR REPLACE FUNCTION get_annual_sal(empid employees.employee_id%TYPE)
 RETURN NUMBER 
IS
  sal employees.salary%TYPE;
  com employees.commission_pct%TYPE;
BEGIN
  SELECT nvl(salary, 0), nvl(commission_pct, 0) INTO sal, com
    FROM employees WHERE employee_id = empid;
  RETURN (sal + sal * com)*12;
END;
/
 
/* Nutzen Sie die Funktion get_annual_sal in einer SELECT-Anweisung, die für 
 * alle Mitarbeiter der Abteilungen 50 und 80 eine entsprechende Spalte mit dem 
 * jährlichen Gesamtgehalt ausgibt.
 */ 
SELECT employee_id, last_name, salary, commission_pct, 
         get_annual_sal(employee_id) FROM employees
          WHERE department_id in (50, 80);
          
          
          


/* Erstellen Sie eine Prozedur get_emp, die das Gehalt und die Jobkennung zu 
 * einer gegebenen Mitarbeiterkennung zurückliefert.
 */
CREATE OR REPLACE PROCEDURE get_emp
    (empid IN  employees.employee_id%TYPE,
     sal   OUT employees.salary%TYPE,
     job   OUT employees.job_id%TYPE) IS
BEGIN
  SELECT  salary, job_id
  INTO    sal, job
  FROM    employees
  WHERE   employee_id = empid;
END ;
/

/* Testen Sie die Prozedur */

-- Test mittels BIND-Variablen
VARIABLE sal NUMBER
VARIABLE job VARCHAR2(15)
EXECUTE get_emp(120, :sal, :job)
PRINT sal job



/* Erstellen Sie eine Prozedur add_emp, um einen neuen Mitarbeiter in die 
 * employees-Tabelle aufzunehmen. Folgende Parameter sollen verwendet werden:
 * - first_name
 * - last_name
 * - email
 * - job: ‘SA_REP’ als default
 * - mgr: 145 als default
 * - sal: 3000 als default
 * - comm: NULL als default
 * - dept: 30 als default
 * - Für die employee_id kann die Sequenz EMPLOYEES_SEQ benutzt werden
 * - hire_date: TRUNC(SYSDATE)
 *
 * Dabei soll eine ebenfalls zu erstellende Hilfsfunktion valid_dep verwendet 
 * werden. Diese prüft, ob die angegebene Abteilungsnummer auch in der 
 * departments-Tabelle exisiert und lifert einen entsprechenden Wahrheitswert
 * zurück. 
 * Falls die Validierung nicht erfolgreich ist, soll das Hinzufügen 
 * unterbleiben und stattdessen ein Fehler an den Aufrufer signalisiert werden.
 */
CREATE OR REPLACE FUNCTION valid_dep( deptid departments.department_id%TYPE )
  RETURN BOOLEAN IS
  test  PLS_INTEGER;
BEGIN
  SELECT  1 INTO test FROM departments
    WHERE   department_id = deptid;
  RETURN  TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END;
/ 

CREATE OR REPLACE PROCEDURE add_emp(
   firstname employees.first_name%TYPE,
   lastname  employees.last_name%TYPE,
   mail      employees.email%TYPE,
   job       employees.job_id%TYPE   DEFAULT 'SA_REP',
   mgr       employees.manager_id%TYPE  DEFAULT 145,
   sal       employees.salary%TYPE     DEFAULT 3000,
   comm      employees.commission_pct%TYPE  DEFAULT NULL,
   deptid    employees.department_id%TYPE  DEFAULT 30) 
IS
BEGIN
 IF valid_dep(deptid) THEN
   INSERT INTO employees(employee_id, first_name, last_name, email,
     job_id, manager_id, hire_date, salary, commission_pct, department_id)
   VALUES (employees_seq.NEXTVAL, firstname, lastname, mail, 
     job, mgr, TRUNC(SYSDATE), sal, comm, deptid);
 ELSE
   RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.');
 END IF;
END;
/ 

/* Testen Sie die Prozedur für Ella Fitz in Abteilung 15, wobei andere 
 * Parameter soweit möglich mit ihren default-Werten benutzt werden.
 * Machen Sie einen weiteren Test mit Max Mustermann in Abteilung 80.
 */
EXECUTE add_emp('Ella', 'Fitz', 'ELFITZ', deptid=> 15);

EXECUTE add_emp('Max', 'Mustermann', 'MAXMUSTER', deptid=> 80);

/* Zum Test */
SELECT last_name FROM employees WHERE department_id = 80;
ROLLBACK;
