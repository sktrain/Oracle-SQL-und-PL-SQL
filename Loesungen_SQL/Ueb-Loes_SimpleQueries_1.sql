-- Übung 1: Basis der SELECT-Anweisung  -  Lösungen

-- 1.	Schreiben Sie eine Abfrage, die den Nachnamen, die Jobkennung, das 
-- Einstellungsdatum und die Angestelltennummer für jeden Angestellten liefert, 
-- wobei die Angestelltennummer als erster Wert und das Einstellungsdatum unter
-- der Überschrift „STARTDATE“ angezeigt wird.

SELECT 	employee_id, last_name, job_id, hire_date  AS STARTDATE
FROM	employees;


-- 2.	Schreiben Sie eine Abfrage, um alle Abteilungskennungen der Angestellten
-- ohne Duplikate absteigend sortiert aufzulisten.

SELECT DISTINCT  department_id  
  FROM employees  
  ORDER BY department_id  DESC;


-- 3. Zeigen Sie die Regionskennungen ohne Duplikate unter der 
-- Spaltenüberschrift "Regionskennung" in absteigender Sortierung nach 
-- dem Regionsnamen an.

SELECT DISTINCT  region_id  AS "Regionskennung"
FROM regions  
ORDER BY region_name;

-- oder mit Anzeige des Regionsnamens
SELECT DISTINCT  region_id  AS "Regionskennung", REGION_NAME
FROM regions  
ORDER BY region_name;


-- 4. Zeigen Sie den Inhalt der Location-Tabelle an. Verwenden Sie deutsche 
-- Spaltenüberschriften.

SELECT 	location_id  "Lokationskennung",
        postal_code  "PLZ",
        city  "Stadt",
        street_address  "Strasse",
        state_province  "Bundesland",
        country_id  "Landeskennung"
FROM	locations;





 
