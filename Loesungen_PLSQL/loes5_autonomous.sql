/* Wenn die Prozedur add_emp aus dem Package emp_pkg ausgeführt wird, soll das
 * in einer Log-Tabelle protokolliert werden.
 * Dazu wird zuerst die Log-Tabelle und eine Sequenz für die Protokolleinträge
 * mit Hilfe folgender Anweisungen erstellt:
 */

CREATE SEQUENCE  log_seq  MINVALUE 1 MAXVALUE 99999999999999999999999
INCREMENT BY 1 START WITH 1 NOCACHE  NOCYCLE ;

CREATE TABLE LOG_EMP (  log_id NUMBER PRIMARY KEY,
                        user_name VARCHAR2(30),
                        c_date DATE,
                        e_lastname  VARCHAR2(25 BYTE)
                      );

/* Ergänzen Sie die Prozedur add_emp im Package emp_pkg mit einer lokalen 
 * Prozedur (innerhalb von add_emp), die nach erfolgreicher Prüfung der 
 * Abteilungsnummer und Einfügen des neuen Mitarbeiters einen Eintrag in
 * der Log-Tabelle erstellt, der unabhängig von einen eventuellen Rollback 
 * existieren soll, d.h. es ist eine autonome Transaktion zu verwenden.
 * Folgende Werte sollen protokolliert werden:
 * - Name des Benutzers (SQL-Funktion USER)
 * - Zeitpunkt
 * - Nachname des neu hinzugefügten Mitarbeiters
 */

/*  Es muss nur der Body, und da nur add_emp verändert werden */
CREATE OR REPLACE PACKAGE BODY emp_pkg IS

  FUNCTION valid_dep( deptid departments.department_id%TYPE ) RETURN BOOLEAN 
  IS
    test  PLS_INTEGER;
  BEGIN
    SELECT  1 INTO test FROM departments
      WHERE   department_id = deptid;
    RETURN  TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END;
  
  /* Veränderte Prozedur add_emp */
  PROCEDURE add_emp(
    firstname employees.first_name%TYPE,
    lastname  employees.last_name%TYPE,
    mail      employees.email%TYPE,
    job       employees.job_id%TYPE   DEFAULT 'SA_REP',
    mgr       employees.manager_id%TYPE  DEFAULT 145,
    sal       employees.salary%TYPE     DEFAULT 3000,
    comm      employees.commission_pct%TYPE  DEFAULT NULL,
    deptid    employees.department_id%TYPE  DEFAULT 30) 
  IS
    /* Neue lokale Prozedur innerhalb add_emp*/
    PROCEDURE log_newemp IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      username VARCHAR2(30) := USER;
    BEGIN
      INSERT INTO log_emp (log_id, user_name, c_date, e_lastname)
      VALUES (log_seq.NEXTVAL, username, sysdate, lastname);
      COMMIT;
    END;
    
  BEGIN
    IF valid_dep(deptid) THEN
      log_newemp;
      INSERT INTO employees(employee_id, first_name, last_name, email,
          job_id, manager_id, hire_date, salary, commission_pct, department_id)
        VALUES (employees_seq.NEXTVAL, firstname, lastname, mail, 
                job, mgr, TRUNC(SYSDATE), sal, comm, deptid);
    ELSE
      RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.');
    END IF;
  END;
  
  /* Überladene Variante */
  PROCEDURE add_emp( 
    firstname employees.first_name%TYPE, 
    lastname employees.last_name%TYPE, 
    deptid employees.department_id%TYPE) 
  IS
    mail employees.email%type;
  BEGIN
    mail := UPPER(SUBSTR(firstname, 1, 1)||SUBSTR(lastname, 1, 7));
    add_emp(firstname, lastname, mail, deptid => deptid);
  END;

  FUNCTION get_annual_sal(empid employees.employee_id%TYPE)
      RETURN NUMBER 
  IS
    sal employees.salary%TYPE;
    com employees.commission_pct%TYPE;
  BEGIN
    SELECT nvl(salary, 0), nvl(commission_pct, 0) INTO sal, com
      FROM employees WHERE employee_id = empid;
    RETURN (sal + sal * com)*12;
  END;
  
  /* neue Funktionen noch ohne Exception-Behandlung */
  FUNCTION get_emp(empid employees.employee_id%TYPE)
    return employees%ROWTYPE 
  IS
    rec_emp employees%ROWTYPE;
  BEGIN
    SELECT * INTO rec_emp
    FROM employees
    WHERE employee_id = empid;
    RETURN rec_emp;
  END;

  FUNCTION get_emp(lastname employees.last_name%TYPE)
    return employees%ROWTYPE 
  IS
    rec_emp employees%ROWTYPE;
  BEGIN
    SELECT * INTO rec_emp
    FROM employees
    WHERE last_name = lastname;
    RETURN rec_emp;
  END;
  
  PROCEDURE to_char(emprec employees%ROWTYPE) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(emprec.department_id ||':'|| 
                         emprec.employee_id||':'||
                         emprec.first_name||':'||
                         emprec.last_name||':'||
                         emprec.job_id||':'||
                         emprec.salary);
  END;
  
END;
/ 


/* Testen Sie die Protokollierung durch das Hinzufügen neuer Mitarbeiter, 
 * führen Sie einen Rollback durch und vergewissen Sie sich, dass die 
 * Log-Einträge trotzdem noch vorhanden sind.
 */
EXECUTE emp_pkg.add_emp('Max', 'Smart', 20);
EXECUTE emp_pkg.add_emp('Clark', 'Kent', 10);

SELECT * FROM LOG_EMP;
ROLLBACK;
SELECT * FROM LOG_EMP;

