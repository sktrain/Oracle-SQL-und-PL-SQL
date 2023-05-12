/* Erweiterung des Package EMP_PKG:
 * Statt bei der Validierung der Abteilungskennung die Tabelle DEPARTMENTS
 * zu nutzen, soll die Liste der Abteilungen einmal in den Speicher geladen
 * werden und diese Liste benutzt werden. Sofern sich die Abteilungsdaten 
 * selten �ndern und damit die Liste selten aktualisiert werden muss, 
 * verspricht dieser Ansatz eine bessere Performanz.
 * Daf�r sollten folgende Schritte ausgef�hrt werden:
 * 1) Erstellen Sie eine �ffentliche Hilfsprozedur im Package, die eine
 * private Index-By-Table-Struktur mit BOOLEAN-Werten initialisiert, wobei 
 * die Abteilungsnummer aus der Tabelle DEPARTMENTS die Indizes bilden,
 * unter denen TRUE abgespeichert ist (das signalisiert eine g�ltige 
 * Abteilungsnummer). 
 * 2) Im Package Body wird in einem Initalisierungsblock die Specher-Tabelle
 * mit Hilfe der Prozedur erstmalig gef�llt.
 * 3) Die Validierungsfunktion f�r die Abteilungsnummern wird modifiziert,
 * um jetzt anhand der Speichertabelle zu pr�fen.
 */
 
 
 /* Erg�nzung der Package Spezifikation um die Initialisierungsprozedur */
 CREATE OR REPLACE PACKAGE emp_pkg IS
 
  /* Neue Prozedur */
  PROCEDURE init_departments;
  
  PROCEDURE add_emp(
    firstname employees.first_name%TYPE,
    lastname  employees.last_name%TYPE,
    mail      employees.email%TYPE,
    job       employees.job_id%TYPE   DEFAULT 'SA_REP',
    mgr       employees.manager_id%TYPE  DEFAULT 145,
    sal       employees.salary%TYPE     DEFAULT 3000,
    comm      employees.commission_pct%TYPE  DEFAULT NULL,
    deptid    employees.department_id%TYPE  DEFAULT 30);
  
  PROCEDURE add_emp( 
    firstname employees.first_name%TYPE, 
    lastname employees.last_name%TYPE, 
    deptid employees.department_id%TYPE);
    
  FUNCTION get_annual_sal(empid employees.employee_id%TYPE)
    RETURN NUMBER; 
    
  FUNCTION get_emp(empid employees.employee_id%TYPE)
    return employees%rowtype;
  
  FUNCTION get_emp(lastname employees.last_name%TYPE)
    return employees%rowtype;
    
  PROCEDURE to_char(emprec employees%ROWTYPE);  
  
END;
/




/*  Entsprechende Anpassung des Package Body */
CREATE OR REPLACE PACKAGE BODY emp_pkg IS

  /* Deklaration f�r die Speichertabelle */
  TYPE bool_tab_typ IS TABLE OF BOOLEAN 
		  INDEX BY BINARY_INTEGER;
  valid_departments bool_tab_typ;
  
  /* Implementierung der Initialisierunsprozedur */
  PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id FROM departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;
 

  FUNCTION valid_dep( deptid departments.department_id%TYPE ) RETURN BOOLEAN 
  IS
    test  PLS_INTEGER;
  BEGIN
    RETURN valid_departments.exists(deptid);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END;
  
  
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
    /* Lokale Prozedur innerhalb add_emp*/
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
  
  /* �berladene Variante */
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
  
/* Initialisierungsblock */
BEGIN
    init_departments;

END;
/ 




/* Testen Sie die neue Funktionalit�t:
 * - F�gen Sie mit Hilfe der Prozedur add_emp Max Mustermann in Abteilung 
 *   15 hinzu.
 * - F�gen Sie eine neue Abteilung mit der Kennung 15 und dem Namen Security
 *   in der Tabelle DEPARTMENTS ein.
 * - Initialisieren Sie die Hauptspeichertabelle neu und versuchen Sie jetzt
 *   das Hinzuf�gen von Max Mustermann
*/

-- sollte fehlschlagen
EXECUTE emp_pkg.add_emp('Max', 'Mustermann', 15);

-- einf�gen der Abteilung
INSERT INTO departments (department_id, department_name)
  VALUES (15, 'Security');

-- solange wir die Hauptspeichertabelle nicht aktualisieren: Fehlschlag  
EXECUTE emp_pkg.add_emp('Max', 'Mustermann', 15);

-- Aktualisierung der Hauptspeichertabelle
EXECUTE emp_pkg.init_departments;

-- jetzt sollte es klappen  
EXECUTE emp_pkg.add_emp('Max', 'Mustermann', 15);

-- Aufr�umen
ROLLBACK;



COMMIT;