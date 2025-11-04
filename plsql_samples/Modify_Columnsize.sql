/*************************************************************
Key System Views for Retrieving Column Data Types

USER_TAB_COLUMNS: Contains column information for tables owned 
                  by the current user.
                  
ALL_TAB_COLUMNS: Provides the current user column details 
                 for all accessible tables in the database.

DBA_TAB_COLUMNS: Contains column information for all tables in 
                 the database, requiring DBA privileges to access.

*************************************************************/

-- Basis ist z.B:
SELECT * FROM ALL_TAB_COLUMNS
WHERE OWNER = 'HR' AND TABLE_NAME = 'EMPLOYEES';

-- oder spezieller:
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    DATA_LENGTH,
    DATA_PRECISION,
    DATA_SCALE
FROM ALL_TAB_COLUMNS
WHERE OWNER = 'HR'
AND TABLE_NAME = 'EMPS';


/* Für den Test */
CREATE TABLE EMPS AS
  SELECT * FROM EMPLOYEES;

/***************************** PL/SQL-Skript**********************/

SET VERIFY OFF

DECLARE 
    owner_name ALL_TAB_COLUMNS.OWNER%type := UPPER('&Schema');
    tab_name ALL_TAB_COLUMNS.TABLE_NAME%type := UPPER('&Tabellenname');
    col_name ALL_TAB_COLUMNS.COLUMN_NAME%type := UPPER('&Spaltenname');
    required_length ALL_TAB_COLUMNS.DATA_LENGTH%type := &VARCHAR_SIZE;
    required_precision ALL_TAB_COLUMNS.DATA_PRECISION%type := &PRECISION;
    actual_length ALL_TAB_COLUMNS.DATA_LENGTH%type; -- VARCHAR
    actual_type ALL_TAB_COLUMNS.DATA_TYPE%type;
    actual_precision ALL_TAB_COLUMNS.DATA_PRECISION%type;
    actual_scale ALL_TAB_COLUMNS.DATA_SCALE%type;
    todo_string VARCHAR(500); 
BEGIN
    SELECT DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE INTO actual_type, actual_length, actual_precision, actual_scale
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = owner_name
          AND TABLE_NAME = tab_name
          AND COLUMN_NAME = col_name;
          
    IF actual_type = 'VARCHAR2' AND actual_length < required_length
        THEN
            -- jetzt Dynamic SQL für 
            -- ALTER TABLE <name> MODIFY(<column> VARCHAR2(<required>));
            todo_string := 'ALTER TABLE ' || tab_name || ' MODIFY(' || col_name || ' VARCHAR2(' || required_length ||'))';
            DBMS_OUTPUT.PUT_LINE('Folgende Anweisung wird ausgeführt: ' || todo_string);
            EXECUTE IMMEDIATE todo_string;
    ELSIF actual_type = 'NUMBER' AND actual_precision < required_precision  -- Scale wird beibehalten
        THEN
            -- jetzt Dynamic SQL für 
            -- ALTER TABLE <name> MODIFY(<column> NUMBER(<required>));
            todo_string := 'ALTER TABLE ' || tab_name || ' MODIFY(' || col_name || ' NUMBER(' || required_precision || ',' || actual_scale ||'))';
            DBMS_OUTPUT.PUT_LINE('Folgende Anweisung wird ausgeführt: ' || todo_string);
            EXECUTE IMMEDIATE todo_string;
    END IF;
    -- nur zur Prüfung
    SELECT DATA_LENGTH INTO actual_length
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = owner_name
          AND TABLE_NAME = tab_name
          AND COLUMN_NAME = col_name;
    DBMS_OUTPUT.PUT_LINE('Aktuelle Spaltenlänge ist: ' || actual_length);
EXCEPTION WHEN NO_DATA_FOUND THEN  -- falls SELECT nichts liefert
    DBMS_OUTPUT.PUT_LINE('Offensichtlich wurden ungültige Werte eingegeben!');
END;


    
    
