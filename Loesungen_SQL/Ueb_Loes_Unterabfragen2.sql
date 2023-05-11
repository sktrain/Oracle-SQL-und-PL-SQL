/* Unterabfragen 2 */

/* Aufgabe 1 - Listen Sie Nachname, Abteilungsnummer und Gehalt eines jeden 
Mitarbeiter auf, dessen Abteilung und Gehaltswert mit dem Gehalt und zugleich 
der Abteilungsnummer eines Mitarbeiters übereinstimmt, der eine Provision 
(commission_pct) erhält */

SELECT last_name, department_id, salary
  FROM employees
  WHERE (salary, department_id) IN 
      (SELECT salary, department_id FROM employees
           WHERE commission_pct IS NOT NULL) ;

           
/* Aufgabe 2 - Listen Sie Nachname, Einstellungsdatum und Gehalt eines jeden 
Mitarbeiter an, der das  gleiche Gehalt und die gleiche Provision wie der 
Mitarbeiter 'Kochhar' erhält. Kochhar soll nicht im Ergebnis enthalten sein */

SELECT last_name, hire_date, salary
  FROM employees
  WHERE (salary, NVL(commission_pct, 0)) IN
        (SELECT salary, NVL(commission_pct, 0) FROM employees
            WHERE last_name = 'Kochhar')
        AND last_name != 'Kochhar';
        
        
/* Aufgabe 3 - Zeigen Sie die Mitarbeiter an, deren Gehalt höher als das Gehalt 
aller Sales Manager ist (job_id = 'SA_MAN'). Sortieren Sie die Ergebnisse
vom höchsten zum niedrigsten Gehalt. */

SELECT last_name, job_id, salary FROM employees
  WHERE salary > ALL (SELECT salary FROM employees
                        WHERE job_id = 'SA_MAN')
  ORDER BY  salary desc;
  
-- oder alternativ mit Max arbeiten:

SELECT last_name, job_id, salary FROM employees
  WHERE salary > (SELECT max(salary) FROM employees
                        WHERE job_id = 'SA_MAN')
  ORDER BY  salary desc;


/* Aufgabe 4 - Suchen Sie alle Angestellten und zeigen deren Namen an, die 
keine Vorgesetzten sind. Verwenden Sie dabei möglichst den EXISTS-Operator. 
Können Sie die Aufgabe auch mit dem IN-Operator lösen? */

SELECT OUTER.first_name, OUTER.last_name FROM employees OUTER
  WHERE NOT EXISTS ( SELECT 'EgalWas' FROM employees
                       WHERE manager_id = outer.employee_id);
                       
-- alternativ via IN-Operator

SELECT first_name, last_name FROM employees
   WHERE employee_id NOT IN ( SELECT DISTINCT manager_id FROM employees 
                                WHERE manager_id IS NOT NULL
                                -- nicht vergessen, auf NOT NULL zu prüfen!
                                );
                          

/* Aufgabe 5 - Zeigen Sie je Mitarbeiter in einer Zeile den Nachnamen, das 
Gehalt sowie die Anzahl der Mitarbeiter an, die mehr verdienen. */

SELECT last_name, salary, (SELECT count(*) FROM employees
                    WHERE e.salary < salary) as higher
  FROM employees e
  ORDER BY higher; 


/* Aufgabe 6  Erstellen Sie eine Abfrage, um die Angestelltennummer und den 
Nachnamen der Mitarbeiter anzuzeigen, die in Kalifornien 
(state_province = 'California') arbeiten. 
Verwenden Sie skalare Unterabfragen */

SELECT employee_id, last_name FROM employees e
  WHERE ( (SELECT location_id FROM departments d 
              WHERE e.department_id = d.department_id)
           IN (SELECT location_id FROM locations l
                  WHERE state_province = 'California'))
  ORDER BY last_name;
                  
-- alternativ wäre die Aufgabe prinzipiell auch via JOIN lösbar:
SELECT e.employee_id, e.last_name 
    FROM employees e JOIN departments d
                     ON e.department_id = d.department_id
                     JOIN locations l
                     ON d.location_id = l.location_id
        WHERE l.state_province = 'California'
    ORDER BY last_name;
                  
                  
/* Aufgabe 7 Erstellen Sie eine Abfrage, um die Jobkennungen der Jobs 
anzuzeigen, deren Maximalgehalt 50% des Maximalgehalts des Jobkennung mit dem 
höchsten Maximalwert im Unternehmen übersteigt.
Verwenden Sie die WITH-Klausel */

WITH max_sal_calc AS
    ( SELECT job_id, MAX(salary) AS job_max
        FROM employees 
        GROUP BY job_id)
SELECT job_id, job_max FROM max_sal_calc
  WHERE job_max > ( SELECT MAX(job_max) / 2
                      FROM max_sal_calc)
  ORDER BY job_max DESC; 
  

-- oder mal statt job_id mit Anzeige des job_title
WITH max_sal_calc AS
    ( SELECT job_title, MAX(salary) AS job_max
        FROM employees 
        JOIN jobs ON employees.job_id = jobs.job_id
        GROUP BY job_title)
SELECT job_title, job_max FROM max_sal_calc
  WHERE job_max > ( SELECT MAX(job_max) / 2
                      FROM max_sal_calc)
  ORDER BY job_max DESC; 

-- Variante ohne WITH-Klausel
select max(salary), job_id from employees
group by job_id
having max(salary) * 2 > all (select max(salary) from employees
group by job_id);
  

/* Aufgabe 8 Erstellen Sie eine Abfrage, um die Namen der Abteilungen 
anzuzeigen, deren Gesamtlohnkosten ein Achtel (1/8) der Gesamtlohnkosten des 
Unternehmens übersteigen. Verwenden Sie die WITH-Klausel. */

WITH SUMMARY AS
  ( SELECT d.department_name, sum(e.salary) AS dept_total
     FROM employees e JOIN departments d
          ON e.department_id = d.department_id
     GROUP BY department_name)
SELECT department_name, dept_total
  FROM SUMMARY
  WHERE dept_total > (SELECT sum(dept_total) * 1/8 FROM SUMMARY)
  ORDER BY dept_total desc;