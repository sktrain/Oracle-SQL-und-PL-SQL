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

DECLARE 
    table_x user_tab_columns.table_name%type;
    anweisung VARCHAR2(500);
    result NUMBER;
    CURSOR c IS SELECT table_name FROM USER_TAB_COLUMNS
        WHERE user_tab_columns.column_name = 'AZ' AND table_name != 'MASTER'; 
BEGIN
    OPEN c; 
    LOOP
        FETCH c INTO table_x;
        EXIT WHEN c%NOTFOUND;
        -- Bastle die Anweisung als String
        anweisung :=
        'DELETE FROM ' || table_x || ' WHERE az in 
            (SELECT ' || table_x || '.az FROM master right outer join ' ||
            table_x || ' ON master.az = ' || table_x || '.az 
                 WHERE master.az is null)';
        -- bzw. mit liefern des jeweiligen ROWCOUNT
        anweisung :=
        'BEGIN 
        '  ||
        'DELETE FROM ' || table_x || ' WHERE az in 
            (SELECT ' || table_x || '.az FROM master right outer join ' ||
            table_x || ' ON master.az = ' || table_x || '.az 
                 WHERE master.az is null);
                 ' || ':res := SQL%ROWCOUNT;' ||
        '       
        END;';
        -- nur zur Prüfung
        DBMS_OUTPUT.PUT_LINE(anweisung);
        EXECUTE IMMEDIATE anweisung  USING OUT result;
        DBMS_OUTPUT.PUT_LINE( result || ' Zeilen gelöscht in ' || table_x);
    END LOOP;
    CLOSE c;
    COMMIT;
EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
END;


   
   
