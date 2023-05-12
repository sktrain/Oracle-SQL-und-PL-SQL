/* Erg�nzen Sie das Package emp_pkg um eine Prozedur to_char, die f�r einen 
 * gegebenen Record vom Typ  EMPLOYEES%ROWTYPE eine Zeichenkettendarstellung 
 * via DBMS_OUTPUT-Package liefert.
 */
CREATE OR REPLACE PACKAGE emp_pkg IS
  
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
    
  /* Neue Funktionen */
  FUNCTION get_emp(empid employees.employee_id%TYPE)
    return employees%rowtype;
  
  FUNCTION get_emp(lastname employees.last_name%TYPE)
    return employees%rowtype;
    
  PROCEDURE to_char(emprec employees%ROWTYPE);  
    
END;
/

/*  Body  */
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

/* Test via PL/SQL-Block */
BEGIN
  emp_pkg.to_char(emp_pkg.get_emp(100));
END;


  