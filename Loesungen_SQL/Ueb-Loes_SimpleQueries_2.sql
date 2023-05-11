-- Übung: Verwendung von Datentypen und Operatoren  -  Lösungen 

-- 1.	Schreiben Sie eine Abfrage, die den Nachnamen und das Gehalt der 
-- Mitarbeiter liefert, die mehr als 12.000 verdienen.

SELECT	last_name, salary
FROM	employees
WHERE	salary > 12000;


-- 2.	Schreiben Sie eine Abfrage, die den Nachnamen und die Abteilungsnummer 
-- für den Angestellten mit der Nummer 176 anzeigt.

SELECT	last_name, department_id
FROM	employees
WHERE	employee_id = 176;


-- 3.	Schreiben Sie eine Abfrage, die den Nachnamen und die Job-Kennung der 
-- Angestellten durch Komma und Leerzeichen getrennt in einer Spalte anzeigt. 
-- Nennen Sie die Spalte „Name/Job“.

SELECT  last_name  || ', ' || job_id  "Name/Job"   
FROM  employees;


-- 4.	Schreiben Sie eine Abfrage, die den Nachnamen und das Gehalt der 
-- Mitarbeiter liefert, deren Gehalt außerhalb des Bereichs zwischen 
-- 5.000 und 12.000 liegt.

SELECT	last_name, salary
FROM		employees
WHERE	salary NOT BETWEEN 5000 AND 12000;  -- salary <5000 or  salary > 12000


-- 5.	Schreiben Sie eine Abfrage, die den Nachnamen, Jobkennung und 
-- Einstellungsdatum der Mitarbeiter liefert, die zwischen dem 20.1.2004 und 
-- 1.5.2005 eingestellt wurden. Sortieren Sie die Ausgabe absteigend nach 
-- dem Einstellungsdatum.

SELECT	last_name, job_id, hire_date
FROM	employees
WHERE	hire_date BETWEEN '20.01.04' AND '01.05.05'
ORDER BY hire_date;
-- vorausgesetzt das Standardformat für das Datum ist “DD.MM.YY“

-- oder

SELECT	last_name, job_id, hire_date
FROM	employees
WHERE	hire_date 
BETWEEN DATE '2004-01-20' AND DATE '2005-05-01'
ORDER BY hire_date;
-- mit ANSI-Schreibweise;

SELECT	last_name, job_id, hire_date
FROM	employees
WHERE	hire_date 
BETWEEN to_date('01:2004:20 00.00.00', 'mm:yyyy:dd hh24.mi.ss') AND to_date('01.05.2005 23.59.59', 'mm:yyyy:dd hh24.mi.ss')
ORDER BY hire_date;
-- mit expliziter Formatfestlegung
 

-- 6.	Zeigen Sie die Nachnamen und Abteilungsnummer aller Mitarbeiter in den 
-- Abteilungen 20 und 50 in alphabetischer Reihenfolge der Namen an.

SELECT	last_name, department_id
FROM	employees
WHERE	department_id IN (20, 50)
ORDER BY	last_name;


-- 7.	Zeigen Sie die Nachnamen und Gehälter aller Mitarbeiter an, die zwischen
-- 5000 und 12000 verdienen, und in den Abteilungen 20 oder 50 arbeiten. 
-- Nennen Sie die Spalten „Employee“ und „Monthly Salary“.

SELECT 	last_name "Employee", salary "Monthly Salary"
FROM	employees
WHERE	salary BETWEEN 5000 AND 12000
AND department_id IN (20, 50);


-- 8.	Zeigen Sie den Nachnamen und das Einstellungsdatum aller Mitarbeiter an, 
-- deren Einstellungsdatum in 2006 liegt.

SELECT	last_name, hire_date
FROM	employees
WHERE	hire_date LIKE '%06';
-- unter der Voraussetzung, dass die Jahreszahl am Ende eines Datums ausgegebe
-- wird

-- oder so
SELECT	last_name, hire_date
FROM	employees
WHERE	to_char(hire_date, 'yyyy') = '2006';

-- 9.	Zeigen Sie den Nachnamen und die Jobkennung aller Mitarbeiter an, die 
-- keinen Manager haben.

SELECT	last_name, job_id
FROM 	employees
WHERE	manager_id IS NULL;


-- 10.	Zeigen Sie den Nachnamen, das Gehalt und die Provision für alle
-- Mitarbeiter, die Provision bekommen. 
-- Sortieren Sie die Ausgabe absteigend nach Gehalt und Provision.

SELECT	last_name, salary, commission_pct
FROM	employees
WHERE	commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;
 
-- 11.	Zeigen Sie den Nachnamen, die Jobkennung und das Gehalt für alle 
-- Mitarbeiter, die Vertriebler (SA_REP) oder Lagerangestellte (ST_CLERK) sind 
-- und deren Gehalt nicht 2500, 3500 oder 7000 ist.

SELECT	last_name, job_id, salary
FROM	employees
WHERE	job_id IN ('SA_REP', 'ST_CLERK') 
AND salary NOT IN (2500, 3500, 7000);

