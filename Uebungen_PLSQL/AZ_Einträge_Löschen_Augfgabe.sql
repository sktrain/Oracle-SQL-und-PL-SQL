/*
Suche alle Tabellen die das Feld "AZ" beinhalten
Vergleiche die Inhalte der Tabellen mit dem Feld "AZ" ob dieses in der 
Tabelle "AKTEN" vorhanden ist
wenn nein -> Datensatz löschen
*/

/********************************
Vorbereitung: Testdaten
********************************/

-- Erstmal TestTabellen erzeugen
DROP TABLE MASTER;
Create TABLE Master AS SELECT distinct last_name AS "AZ" FROM employees; 

DROP TABLE TABLE1;
CREATE TABLE TABLE1 
   (AZ VARCHAR2(20 BYTE), 
	COLUMN1 NUMBER
   ); 

DROP TABLE TABLE2;
CREATE TABLE TABLE2 
   (AZ VARCHAR2(20 BYTE), 
	COLUMN1 NUMBER
   );

DROP TABLE TABLE3;   
CREATE TABLE TABLE3 
   (AZ VARCHAR2(20 BYTE), 
	COLUMN1 NUMBER
   );

DROP TABLE TABLE4;   
CREATE TABLE TABLE4 
   (AZ VARCHAR2(20 BYTE), 
	COLUMN1 NUMBER
   );

/
   
-- jetzt mit Testdaten befüllen
INSERT ALL
   INTO Table1 
   INTO Table2
   INTO Table3
   INTO Table4
   SELECT distinct last_name, row_number() OVER (ORDER BY last_name) FROM employees;

-- da jetzt alle dieselben Werte unter AZ haben, im Master ein paar löschen
DELETE FROM MASTER WHERE REGEXP_LIKE(az, '^[OR]');

COMMIT;
    
/******************************************************
Jetzt zur eigentlichen Aufgabe
******************************************************/


-- Schritt 1:
-- Beschaffe alle Tabellennamen mit der Spalte





-- Schritt 2:
-- Lösche in einer Schleife für diese Tabellen die entsprechenden Einträge.
-- Herausforderungen:
-- wie finden wir die Einträge?
-- beim Löschen ist der Tabellenname ein Syntax-Konstrukt, kein String
-- welche Schleife?




   
   
