/* Erstellen Sie eine Package JOB_PKG mit Spezifikation und Body, das Ihre 
 * bisher erstellten Prozeduren und Funktionen zur Job-Verwaltung zusammenfasst.
 * (soweit vorhanden: add_job, upd_job, del_job, get_jobtitle)
 * Die Funktionen und Prozeduren sollen als öffentliche Konstrukte angeboten
 * werden.
 * Testen Sie anschließend das Package.
 */
CREATE OR REPLACE PACKAGE job_pkg IS
  PROCEDURE add_job(jobid  jobs.job_id%TYPE, jobtitle jobs.job_title%TYPE );
  PROCEDURE del_job(jobid  jobs.job_id%TYPE);
  PROCEDURE upd_job(jobid jobs.job_id%TYPE, minsal jobs.min_salary%TYPE,
                    maxsal jobs.max_salary%TYPE);
  FUNCTION get_jobtitle (jobid jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
END;
/

CREATE OR REPLACE PACKAGE BODY job_pkg IS
  PROCEDURE add_job ( jobid  jobs.job_id%TYPE,
                                       jobtitle jobs.job_title%TYPE )
  IS
  BEGIN
    INSERT INTO jobs (job_id, job_title)
      VALUES (jobid, jobtitle);
  END;
  
  PROCEDURE del_job (jobid  jobs.job_id%TYPE)
  IS
  BEGIN
    DELETE FROM jobs WHERE job_id = jobid;
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20203, 'No job deleted');
    END IF;
  END;

  PROCEDURE upd_job( jobid jobs.job_id%TYPE, minsal jobs.min_salary%TYPE,
                      maxsal jobs.max_salary%TYPE )
  IS
    act_minsal jobs.min_salary%TYPE;
    act_maxsal jobs.max_salary%TYPE;
  BEGIN
    SELECT min(min_salary) INTO act_minsal FROM jobs;
    SELECT max(max_salary) INTO act_maxsal FROM jobs;
    IF minsal >= act_minsal AND maxsal <= act_maxsal  
      THEN
        UPDATE jobs
          SET    min_salary = minsal, max_salary = maxsal
          WHERE  job_id = jobid;
        IF SQL%NOTFOUND THEN
          RAISE_APPLICATION_ERROR(-20204, 'Job not existent');
        END IF;
      ELSE
        RAISE_APPLICATION_ERROR(-20205, 'out of range');
    END IF;
  END;

  FUNCTION get_jobtitle (jobid jobs.job_id%TYPE)
    RETURN jobs.job_title%TYPE 
  IS
    title jobs.job_title%TYPE;
  BEGIN
    SELECT job_title INTO title
      FROM jobs WHERE job_id = jobid;
    RETURN title;
  END;
  
END;
/

/* Test */
EXECUTE job_pkg.add_job('IT_SYSAN', 'Systems Analyst');

SELECT * FROM jobs WHERE job_id = 'IT_SYSAN';




/* Erstellen Sie eine Package EMP_PKG mit Spezifikation und Body, das Ihre 
 * bisher erstellten Prozeduren und Funktionen zur Mitarbeiter-Verwaltung 
 * zusammenfasst.
 * - Prozedur ADD_EMP als öffentliches Konstrukt
 * - Funktion VALID_DEP als privates Konstrukt
 * - Funktion get_annual_sal als öffentliches Konstrukt
 * Testen Sie anschließend das Package.
 */
 
/* Spezifikation */
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
    
  FUNCTION get_annual_sal(empid employees.employee_id%TYPE)
    RETURN NUMBER; 
    
END;
/

/* Body */
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
  
END;
/

/*  Test */
SELECT employee_id, last_name, salary, commission_pct, 
         emp_pkg.get_annual_sal(employee_id) FROM employees
          WHERE department_id in (50, 80);

EXECUTE emp_pkg.add_emp('Ella', 'Fitz', 'ELFITZ', deptid=> 15);

EXECUTE emp_pkg.add_emp('Max', 'Mustermann1', 'MAXMUSTER1', deptid=> 80);

SELECT last_name FROM employees WHERE department_id = 80;
ROLLBACK;