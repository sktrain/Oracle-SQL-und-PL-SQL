-- Übungen: Hierarchische Queries

-- 1a. Schreiben Sie eine hierarchische Abfrage für die Mitarbeiter des Managers 
-- Mourgos, beginnend mit diesem. Es sollen die Nachnamen, Gehälter und 
-- Abteilungsnummern der Mitarbeiter, sowie die Hierarchie-Ebene angezeigt 
-- werden.
SELECT last_name, salary, department_id, level as "Ebene"
FROM employees
START WITH last_name = 'Mourgos'
CONNECT BY PRIOR employee_id = manager_id;


-- 1b. Erweitern Sie die vorherige Ausgabe um Pfadangaben, die die
-- Hierarchie verdeutlichen.
SELECT last_name, salary, department_id, level as "Ebene",
SYS_CONNECT_BY_PATH(last_name, '/') as "Pfad"
FROM employees
START WITH last_name = 'Mourgos'
CONNECT BY PRIOR employee_id = manager_id;


-- 2 Zeigen Sie die Managerhierarchie für den Mitarbeiter Lorentz an, 
-- beginnend mit dem direkten Vorgesetzten.
SELECT last_name, employee_id, level as "Ebene",
SYS_CONNECT_BY_PATH(last_name, '/') as "Pfad"
FROM employees
WHERE last_name != 'Lorentz'
START WITH last_name = 'Lorentz'
   CONNECT BY PRIOR manager_id = employee_id;

-- 3. Zeigen Sie die Managementhierarchie beginnend mit dem Mitarbeiter Kochhar
-- an (top-down). Geben Sie jeweils Nachname, Managerkennung und Abteilungs_
-- nummer der Mitarbeiter aus. Dabei sollen die Zeilen je Hierarchiestufe um 2
-- Positionen eingerückt werden und die Einrückung mit "_"-Zeichen verdeutlicht
-- werden (Hinweis: Verwenden Sie die LPAD-Funktion)
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL * 2) -2, '_'),
       manager_id, department_id
FROM employees
START WITH last_name = 'Kochhar' 
    CONNECT BY PRIOR employee_id = manager_id;



-- 4. Zeigen Sie die Managementhierarchie beginnend mit der Person auf der
-- obersten Ebene (eventuell gibt es mehrere) an (top-down). 
-- Geben Sie jeweils Nachname, Mitarbeiter-, Manager- und Jobkennung aus.
-- Alle Mitarbeiter mit der Jobkennung IT_PROG sowie der Mitarbeiter De Haan 
-- und alle ihm unterstellten Mitarbeiter sollen ausgeschlossen werden.
-- Ordnen Sie die Ausgabe in den Zweigen nach den Nachnamen.
SELECT last_name, employee_id, manager_id, job_id 
FROM employees
WHERE job_id != 'IT_PROG'
START WITH manager_id is null
  CONNECT BY PRIOR employee_id = manager_id
            AND last_name != 'De Haan'
ORDER SIBLINGS BY last_name;



-- 5. Zeigen Sie die Managementhierarchie unter dem Mitarbeiter De Haan an,
-- verwenden Sie dabei aber dessen Mitarbeiterkennung. 
-- Geben Sie jeweils Nachname, Mitarbeiter-, Manager- und Jobkennung aus.
-- Ordnen Sie die Ausgabe in den Zweigen nach den Nachnamen.
SELECT last_name, employee_id, manager_id, job_id,
        SYS_CONNECT_BY_PATH(last_name, '/') "Pfad"
FROM employees
START WITH employee_id = (SELECT employee_id FROM employees
                               WHERE last_name = 'De Haan')
  CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;



-- 6. Zeigen Sie die Mitarbeiterkennung, die Managerkennung, den Nachnamen, 
-- sowie die Ebene der Mitarbeiter an, die sich 2 Ebenen unter dem Mitarbeiter
-- De Haan befinden.
SELECT employee_id, manager_id, last_name, LEVEL
  FROM employees
  WHERE LEVEL = 3
  CONNECT BY PRIOR employee_id = manager_id
  START WITH employee_id = (SELECT employee_id FROM employees
                               WHERE last_name = 'De Haan');
  
  

