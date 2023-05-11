-- Übung 4: Joins  -  Lösungen

-- 1. Schreiben Sie eine Abfrage, um den Nachnamen, die Abteilungsnummer und 
-- den Abteilungsnamen aller Mitarbeiter anzuzeigen.

SELECT	e.last_name, e.department_id, d.department_name
FROM 	employees e     JOIN 	departments d
		ON   e.department_id = d.department_id ;
		
		
-- 2. Geben Sie die Adressen aller Abteilungen in der Form
-- Lokationskennung, Abteilungsname, Stadt und Strasse aus.

SELECT	l.location_id, d.department_name, l.city, l.street_address
FROM 	locations l     JOIN 	departments d
		ON   l.location_id = d.location_id ;

		
		
-- 3. Erstellen Sie eine eindeutige Auflistung aller Jobkennungen in der 
-- Abteilung 80. Die Lokationskennung ("Location_id") der Abteilung soll 
-- ebenfalls angezeigt werden.

SELECT DISTINCT e.job_id,  d.location_id
FROM 	employees  e  JOIN   departments d
		ON 	e.department_id = d.department_id 
WHERE	e.department_id = 80;


-- 4. Erweitern Sie die Aufgabe 3 so, dass zusätzlich der Name der Stadt für 
-- die Lokation angezeigt wird.

SELECT DISTINCT e.job_id,  d.location_id, l.city
FROM 	employees  e  JOIN   departments d
		ON 	(e.department_id = d.department_id)
		JOIN locations l
		ON (d.location_id = l.location_id)
WHERE	e.department_id = 80;


-- 5. Zeigen Sie den Nachnamen, die Jobkennung, die Abteilungsnummer und den 
-- Abteilungsnamen für alle Mitarbeiter an, die in Toronto arbeiten.

SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM 	employees e   JOIN    departments d
			ON (e.department_id = d.department_id)
			JOIN locations l
			ON (d.location_id = l.location_id)
WHERE 	LOWER(l.city) = 'toronto';


-- 6. Zeigen Sie zu jeder Abteilung den Abteilungsnamen und den Namen des 
-- Landes an, in dem die Abteilung liegt.

SELECT	d.department_name, c.country_name
FROM 	locations l     JOIN 	departments d
		ON   l.location_id = d.location_id 
		JOIN countries c
		ON l.country_id = c.country_id;
		

-- 7. Zeigen Sie zu jeder Abteilung die Abteilunsnummer, 
-- den Namen der Abteilung und den Namen des Abteilungsleiters an.

SELECT	d.department_id, d.department_name, e.last_name "Abteilungsleiter"
FROM 	employees e     JOIN 	departments d
		ON   d.manager_id = e.employee_id ;


-- 8. Zeigen sie den Nachnamen und die Mitarbeiternummer sowie den zugehörigen 
-- Manager mit seiner Mitarbeiternummer und seinem Nachnamen an. 
-- Nennen Sie die Spalten "Employee", "EMP#", "Manager Name"“ und "MGR#".

SELECT 	i.last_name "Employee", i.employee_id   "EMP#", 
			m.last_name "Manager Name",  m.employee_id  "MGR#"
	FROM 	employees i  JOIN   employees m
			ON (i.manager_id = m.employee_id);
			
			
-- 9. Modifizieren Sie die vorherige Abfrage, so dass auch der Mitarbeiter 
-- King angezeigt wird, der keinen Manager hat.

SELECT 	w.last_name "Employee", w.employee_id   "EMP#", 
			m.last_name "Manager Name",  m.employee_id  "MGR#"
	FROM 	employees w  LEFT OUTER JOIN   employees m
			ON (w.manager_id = m.employee_id);
			

 
-- 10. Schreiben Sie eine Abfrage, die für den Mitarbeiter Zlotkey den 
-- Nachnamen, die Abteilungsnummer und die Nachnamen aller Kollegen ausgibt, 
-- die in der gleichen Abteilung arbeiten. 
-- Geben Sie den Spalten passende Überschriften.

SELECT 	e.department_id  "department", e.last_name   "employee", 
			c.last_name  "colleague"
FROM	employees e   JOIN   employees c
			ON	(e.department_id = c.department_id)
WHERE	
   --upper(c.last_name) != 'ZLOTKEY' AND
   e.employee_id <> c.employee_id AND 
   e.last_name = 'Zlotkey'
ORDER BY	e.department_id, e.last_name, c.last_name;


-- 11. Schreiben Sie eine Abfrage, die den Namen, die Jobkennung, den 
-- Abteilungsnamen, das Gehalt und das minimale Gehalt(aus der Tabelle Jobs) 
-- ausgibt, sofern der Mitarbeiter in der Gehaltseinstufung liegt.

SELECT 	e.last_name  "Employee", e.job_id "Job", 
        d.department_name "Department", e.salary "Gehalt",
        j.min_salary "Mindestlohn"
FROM	employees e   
      JOIN   departments d
          ON	e.department_id = d.department_id
      JOIN jobs j
          ON  e.job_id = j.job_id 
        WHERE e.salary BETWEEN j.min_salary AND j.max_salary;
		    
		    
-- 12. Zeigen Sie die Namen und das Einstellungsdatum aller Mitarbeiter an, 
-- die nach dem Mitarbeiter Davies eingestellt wurden.

SELECT	r.first_name, r.last_name, r.hire_date
FROM	employees l JOIN employees r
		ON (l.hire_date < r.hire_date)
    WHERE (UPPER(l.last_name) = 'DAVIES')
ORDER BY r.hire_date;

    


-- 13. Zeigen Sie die Jobkennungen, die in den Abteilungen "Administration" 
-- und "Executive" vorkommen. 
-- Zeigen Sie auch die Anzahl der Mitarbeiter für diese Jobs an, wobei die 
-- Ausgabe nach der Anzahl sortiert erfolgen soll.

SELECT	e.job_id, count(e.job_id) "Haeufigkeit"
FROM	employees e JOIN departments d
		ON e.department_id = d.department_id
WHERE	d.department_name in ('Administration', 'Executive')
GROUP BY e.job_id
ORDER BY "Haeufigkeit";



