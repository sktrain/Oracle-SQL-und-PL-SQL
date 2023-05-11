-- Übung: Unterabfragen  -  Lösungen

-- 1.	Schreiben Sie eine Abfrage, die für den Mitarbeiter Zlotkey, die Nachnamen 
-- sowie das Anstellungsdatum aller Kollegen ausgibt, die in der gleichen 
-- Abteilung arbeiten. Schließen Sie Zlotkey aus.

SELECT 	last_name, hire_date
FROM employees
WHERE 	department_id = (SELECT  department_id
					FROM	  employees
					WHERE	last_name = 'Zlotkey')
		AND	last_name <> 'Zlotkey';
		
		
-- 2.	Zeigen Sie die Mitarbeiternummer und Nachnamen aller Mitarbeiter an, 
-- die mehr als das Durchschnittsgehalt verdienen. 
-- Sortieren Sie das Ergebnis absteigend nach dem Gehalt.

SELECT employee_id, last_name
FROM    employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;


-- 3.	Zeigen Sie den Nachnamen, die Abteilungsnummer und die Jobkennung aller 
-- Mitarbeiter an, deren Abteilung in der Lokation mit der ID 1700 (location_id)
-- liegt.

SELECT 	last_name, department_id, job_id
FROM 	employees
WHERE 	department_id   IN (SELECT department_id FROM departments
						WHERE location_id = 1700);

-- hier alternativ eine Variante via JOIN            
SELECT e.last_name, e.department_id, d.location_id, l.city
  FROM employees e join departments d
      ON e.department_id = d.department_id 
      join locations l
      ON d.location_id = l.location_id
  WHERE d.location_id = 1700;
						
						
-- 4. Zeigen Sie den Nachnamen und das Gehalt aller Mitarbeiter an, 
-- die direkt "King" unterstellt sind.	

SELECT  last_name, salary
FROM	employees	
WHERE	manager_id	in ( SELECT employee_id
						FROM	employees	
						WHERE UPPER(last_name) = 'KING' );
						
						
					
-- 5. Zeigen Sie für alle Mitarbeiter aus der Abteilung "Executive" die 
-- Abteilungsnummer, den Nachnamen und die Jobkennung an.

SELECT	department_id, last_name, job_id
FROM	employees	
WHERE	department_id = ( SELECT department_id
							FROM departments
							WHERE department_name = 'Executive');	
							
						
-- 6. Zeigen Sie Mitarbeiterkennung, Nachname und Gehalt für alle Mitarbeiter 
-- an, die mehr als das Durchschnittsgehalt verdienen und in derselben Abteilung
-- arbeiten wie ein Mitarbeiter namens "Higgins". Schlieesen Sie "Higgins" aus.

SELECT 	employee_id, last_name, salary
FROM employees
WHERE 	department_id = (SELECT  department_id
					FROM	  employees
					WHERE	last_name = 'Higgins')
		AND salary > ( SELECT AVG(salary)
						FROM employees ) 
		AND last_name <> 'Higgins';
		
		
-- 7. Zeigen sie die Abteilungen an, in denen keine "Sales Representatives" 
-- (Job_id "SA_REP") arbeiten. Geben Sie die Abteilungskennung und den 
-- Abteilungsnamen aus.

SELECT	department_id, department_name
FROM	departments
WHERE	department_id not in  ( SELECT	department_id			
								FROM employees
								WHERE job_id = 'SA_REP'
									AND department_id IS NOT NULL );
									
									
-- 8. Erweitern Sie Aufgabe 7, so dass die Stadt zu jeder Abteilung angezeigt 
-- wird.

SELECT	department_id, department_name, l.city
FROM	departments d INNER JOIN locations l
		ON d.location_id = l.location_id
WHERE	department_id not in  ( SELECT	department_id			
								FROM employees
								WHERE job_id = 'SA_REP'
									AND department_id IS NOT NULL );
                  
-- oder ohne expliziten Join, stattdessen mit korrelierter Subquery
-- ist übrigens laut Ausführungsplan bessere Variante:

SELECT	department_id, department_name, 
       (select l.city from locations l 
               where d.location_id = l.location_id  ) as city 
FROM	departments d 
WHERE	department_id not in  ( SELECT	distinct department_id			
								FROM employees
								WHERE job_id = 'SA_REP'
									AND department_id IS NOT NULL );

									
								
								
-- 9. Zeigen Sie die Namen und das Einstellungsdatum aller Mitarbeiter an, 
-- die nach dem Mitarbeiter Davies eingestellt wurden.

SELECT	first_name, last_name, hire_date
FROM	employees 
WHERE	hire_date > ( SELECT hire_date 
						FROM employees
						WHERE UPPER(last_name) = 'DAVIES')
ORDER BY hire_date;




-- 10. Zeigen Sie die Mitarbeiter an, die mindestens zweimal den Job bzw.
-- die Abteilung gewechselt haben (mind. 2 Einträge in der "Job_History").
-- Listen Sie Nachnamen und aktuelle Jobkennung auf.

-- via korrelierter Subquery: laut Execution Plan unglücklich
SELECT	e.last_name, e.job_id
FROM	employees e
WHERE 2 <= ( SELECT count(*)
				FROM job_history
				WHERE employee_id = e.employee_id ) ;	

-- alternativ mit nicht-korrelierte Subquery: laut Plan deutlich besser!        
SELECT	e.last_name, e.job_id
FROM	employees e
WHERE employee_id IN ( SELECT employee_id
				FROM job_history
        GROUP BY employee_id
        HAVING count(employee_id) >= 2
				) ;	
        
-- bzw. statt WHERE-Klausel JOIN-Variante
SELECT last_name, job_id FROM employees e  JOIN  
    (SELECT employee_id, count(*) AS c  
          FROM job_history 
          GROUP BY employee_id
          HAVING count(*)>1 ) sub
                                  ON e.EMPLOYEE_ID = sub.employee_id ;
        
-- oder ohne korrelierte Unterabfrage mit Verwendung der OVER-Klausel
SELECT e.last_name, e.job_id FROM employees e  JOIN  
    (SELECT DISTINCT employee_id, count(*) OVER (PARTITION BY employee_id) AS c 
           FROM job_history ) sub
      ON e.EMPLOYEE_ID = sub.employee_id
    WHERE sub.c > 1  ;
    

 				
						
-- 11. Zeigen Sie die Abteilungsnummer und das minimale Gehalt für die 
-- Abteilung mit dem höchsten Durchschnittsgehalt.

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= ALL 
					(SELECT AVG(salary)
						FROM employees
						GROUP BY department_id)
						;

-- oder

SELECT department_id, MIN(salary) "Minimum"
FROM	employees
GROUP BY department_id
HAVING AVG(salary) = (SELECT MAX(AVG(salary))
						FROM employees
						GROUP BY department_id);
						

