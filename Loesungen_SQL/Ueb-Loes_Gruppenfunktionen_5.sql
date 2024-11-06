-- Übung: Verwendung von Gruppenfunktionen  -  Lösungen

-- 1.	Zeigen Sie das höchste Gehalt, das niedrigste Gehalt, die Summe aller 
-- Gehälter und das Durchschnittsgehalt für alle Mitarbeiter an. 
-- Runden Sie das Ergebnis auf die nächste ganze Zahl.

SELECT	ROUND (MAX (salary), 0)  	"Maximum",
			ROUND (MIN (salary), 0)   	"Minimum",
			ROUND (SUM(salary), 0)   	"Summe",
			ROUND (AVG(salary), 0)		"Durchschnitt"
FROM	employees;


-- 2.	Verändern Sie die vorherige Abfrage so, dass die Werte je Jobkennung 
-- berechnet und angezeigt werden. 

SELECT 	job_id, 
			ROUND (MAX (salary), 0)  	"Maximum",
			ROUND (MIN (salary), 0)         "Minimum",
			ROUND (SUM(salary), 0)   	"Summe",
			ROUND (AVG(salary), 0)		"Durchschnitt"
FROM	employees
GROUP BY 	job_id;


-- 3.	Zeigen Sie die Jobkennungen und die Anzahl der Mitarbeiter mit 
-- diesem Job an.

SELECT  job_id,   COUNT(*)
FROM	employees
GROUP  BY  job_id;


-- 4.	Zeigen Sie die Differenz zwischen dem niedrigsten und höchsten Gehalt 
-- je Abteilung an. Nennen Sie die Spalte „Differenz“.

SELECT	department_id,   MAX(salary) - MIN(salary)   "Differenz"
FROM	employees
GROUP  BY  department_id;


-- 5.	Bestimmen Sie die Anzahl der Manager (ohne diese aufzulisten).

SELECT	COUNT( DISTINCT manager_id )   "Anzahl Manager"
FROM	employees;
 

-- 6.	Zeigen Sie je Managerkennung das Gehalt des unterstellten Angestellten 
-- mit dem niedrigsten Gehalt an. 
-- Schließen Sie alle Angestellten aus, deren Manager nicht bekannt ist. 
-- Schließen Sie alle Gruppen aus, deren Mindestgehalt 6000 oder weniger 
-- beträgt.
-- Sortieren Sie die Ausgabe in absteigender Reihenfolge nach dem Gehalt.
SELECT manager_id, MIN(salary)
	FROM employees
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING MIN(salary) > 6000
	ORDER BY MIN(salary) DESC;


-- oder mit Anzeige des Managernamen (vorab Self-Join)
SELECT  c.last_name, MIN(i.salary)
	FROM employees i JOIN employees c
      ON i.manager_id = c.employee_id
	WHERE i.manager_id IS NOT NULL
	GROUP BY i.manager_id, c.last_name
	HAVING MIN(i.salary) > 6000
	ORDER BY MIN(i.salary) DESC; 
  

-- 7.	Zeigen Sie die Anzahl der Mitarbeiter, deren Nachname mit dem 
-- Buchstaben “n“ endet.

SELECT   count(*) 
	FROM   employees
  WHERE  last_name  LIKE  '%n' ;

-- oder

SELECT   count(*) 
	FROM       employees
  WHERE    substr(last_name, -1) = 'n' ;


-- 8. Zeigen Sie je Kalenderjahr an, wieviele Angestellte jeweils eingestellt 
-- wurden.  
SELECT EXTRACT(YEAR FROM hire_date) AS YEAR, 
        count(*) as "COUNT" FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY YEAR;

    
-- 9. Schreiben Sie eine Abfrage, um eine Einstufung der Abteilungen auf Basis 
-- der Mitarbeiteranzahl in folgender Form anzuzeigen:
-- "Department_ID			Size". 
-- Dabei sollen Abteilungen mit weniger als 5 Mitarbeitern die Size "Little",
-- Abteilungen mit einer Mitarbeiterzahl zwischen 5 und 9 die Size "Medium"
-- Abteilungen mit einer Mitarbeiterzahl ab 10 die Size "Big" erhalten.

SELECT	department_id, 
		CASE
			WHEN department_id IS NULL THEN 'no department'
			WHEN count(department_id) < 5 THEN 'Little'
			WHEN count(department_id) BETWEEN 5 AND 9 THEN 'Medium'
			WHEN count(department_id) > 9 THEN 'Big'
		END AS "Size"		
	FROM employees
	GROUP BY department_id; 
  
  
-- 10. Zeigen Sie für alle Mitarbeiter, deren Managerkennung kleiner 130 ist, 
-- Folgendes an:
-- Managerkennung,  Job-Kennung und Gesamtgehalt für jede Jobkennung, 
-- sortiert nach der Managerkennung.

SELECT manager_id, job_id, sum(salary) "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY manager_id, job_id
  ORDER BY manager_id;

  
-- 11. Erweitern Sie Aufgabe 10, so dass zusätzlich angezeigt wird:
-- Gesamtgehalt der Mitarbeiter unter dem jeweiligen Manager, 
-- Gesamtgehalt aller Mitarbeiter unter diesen Managern.

SELECT manager_id, job_id, sum(salary)  "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id;
  

-- 12. Erweitern Sie Aufgabe 10 um eine Anzeige, die deutlich macht, 
-- ob die Nullwerte in den Spalten aus der Rollup-Auswertung resultieren 
-- oder auf Basis gespeicherter Nullwerte aus der Tabelle zustande kommen.

SELECT   manager_id MANAGER, job_id JOB, 
         SUM(salary),
         GROUPING(manager_id) GRP_MANAGER,
         GROUPING(job_id) GRP_JOB
FROM     employees
WHERE    manager_id < 130
GROUP BY ROLLUP(manager_id, job_id);
  
-- oder erweitert: via Case-Anweisung schönere Ausgabe statt 0 oder 1

SELECT manager_id, job_id, 
       sum(salary) "Gehaltssumme", 
       CASE grouping(manager_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '  
          -- leere Zeichkette wird eventuell vom Tool als "null" ausgegeben
                                 END  AS "Sum_je_Man",
       CASE grouping(job_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '
                                 END  AS "Sum_je_Job"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id ;
  
-- oder, ebenfalls via Case, aber in den Gruppierungsspalten vernünftig 
-- angezeigt

SELECT CASE WHEN manager_id is null and grouping(manager_id) = 1
              THEN 'Gesamtsumme' 
            WHEN manager_id is null and grouping(manager_id) = 0
              THEN 'Nullgruppe Manager_ID'
            ELSE to_char(manager_id) END AS MANAGER_ID,
       CASE WHEN job_id is null and grouping(job_id) = 1 
                                and grouping(manager_id) = 1
              THEN ''
            WHEN job_id is null and grouping(job_id) = 1 
              THEN 'Summe ' || manager_id  -- nächsthöhere Gruppierung anzeigen
            WHEN job_id is null and grouping(job_id) = 0 
              THEN 'Null-Gruppe JOB_ID'
            ELSE job_id
       END AS JOB_ID,
       sum(salary) "Gehaltssumme"
       -- , case grouping(manager_id) WHEN 1 THEN 'Aggregiert'
       --                          ELSE ' '             
       --                         END  AS "Sum_je_Man",
       -- case grouping(job_id) WHEN 1 THEN 'Aggregiert'
       --                          ELSE ' '
       --                          END  AS "Sum_je_Job"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id desc, job_id;

  
  
  
  
-- 13. Erweitern Sie die Abfrage aus Aufgabe 12, so dass zusätzlich angezeigt 
-- wird: Gesamtgehalt je Jobkennung unabhängig vom Manager.

SELECT  manager_id
        , job_id
        , sum(salary) "Gehaltssumme"
        , CASE grouping(manager_id) 
            WHEN 1 THEN 'Aggregiert'
                ELSE ' '     
          END  AS "Sum_je_Man"
        , CASE grouping(job_id) 
            WHEN 1 THEN 'Aggregiert'
                ELSE ' '
          END  AS "Sum_je_Job"
  FROM employees
  WHERE manager_id < 130
  GROUP BY CUBE (manager_id, job_id)
  ORDER BY manager_id;


-- 14. Modifizieren Sie die Abfrage aus Aufgabe 11, so dass nur folgende 
-- Gruppierungen angezeigt werden:
-- (Abteilungskennung, Managerkennung, Jobkennung),
-- (Abteilungskennung, Jobkennung),
-- (Managerkennung, Jobkennung)

SELECT department_id, manager_id, job_id, sum(salary)  "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY 
  GROUPING SETS ( (department_id, manager_id, job_id),
                  (department_id, job_id),
                  (manager_id, job_id) )
  ORDER BY department_id, manager_id;
  
  
  
-- 15. Erstellen Sie eine Abfrage, um folgende Angaben für alle Abteilungen 
-- anzuzeigen, deren Abteilungsnummer größer als 80 ist:
--  - Gesamtgehalt für jeden Job in der Abteilung
--  - Das Gesamtgehalt
--  - Das Gesamtgehalt für die Städte, in denen sich Abteilungen befinden
--  - Das Geamtgehalt für jeden Job, unabhängig von der Abteilung
--  - Das Gesamtgehalt für jede Abteilung, unabhängig von der Stadt
--  - Das Gesamtgehalt für die Abteilungen, unabhängig von Job-Bezeichnung
--    und Stadt

SELECT l.city, d.department_name, e.job_id, sum(e.salary) sum_salary
  FROM locations l 
       JOIN departments d ON l.location_id = d.location_id
       JOIN employees e ON e.department_id = d.department_id
  WHERE e.department_id > 80
  GROUP BY CUBE ( l.city, d.department_name, e.job_id)
  ORDER BY l.city, d.department_name, e.job_id;
  
-- oder mit Verwendung von GROUPING bzw. GROUPING_ID
SELECT l.city, d.department_name, e.job_id, sum(e.salary) sum_salary,
       GROUPING(l.city), GROUPING(d.department_name), GROUPING(e.job_id),
       GROUPING_ID(l.city, d.department_name, e.job_id),
       GROUP_ID()
  FROM locations l 
       JOIN departments d ON l.location_id = d.location_id
       JOIN employees e ON e.department_id = d.department_id
  WHERE e.department_id > 80
  GROUP BY CUBE ( l.city, d.department_name, e.job_id);
  

  
-- 16  Erstellen Sie eine Abfrage, um folgende Gruppierungen anzuzeigen:
--  - Abteilungsnummer, Jobkennung
--  - Jobkennung, Managerkennung
--  wobei die Ausgabe das Maximal- und das Minimalgehalt nach Abteilung, 
--  Tätigkeit und Manager enthalten soll.
SELECT department_id, job_id, manager_id, MAX(salary), MIN(salary)
  FROM employees 
  GROUP BY GROUPING SETS ((department_id, job_id), (job_id, manager_id));
  
-- mit Anzeige des Namens der Abteilung und des Vorgesetzten (Manager)
SELECT d.department_name, e.job_id, e.manager_id, 
       MAX(salary) max_salary, 
       MIN(salary) min_salary
  FROM employees e 
      JOIN departments d ON e.department_id = d.department_id
  GROUP BY GROUPING SETS ((e.department_id, d.department_name, e.job_id), 
                          (e.job_id, e.manager_id));
  
  

