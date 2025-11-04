CREATE OR REPLACE PROCEDURE ModifyColumnSize(
     owner_name ALL_TAB_COLUMNS.OWNER%type,
     tab_name ALL_TAB_COLUMNS.TABLE_NAME%type,
     col_name ALL_TAB_COLUMNS.COLUMN_NAME%type,
     required_length ALL_TAB_COLUMNS.DATA_LENGTH%type DEFAULT 1,
     required_precision ALL_TAB_COLUMNS.DATA_PRECISION%type DEFAULT 1)
IS
    actual_length ALL_TAB_COLUMNS.DATA_LENGTH%type; 
    actual_type ALL_TAB_COLUMNS.DATA_TYPE%type;
    actual_precision ALL_TAB_COLUMNS.DATA_PRECISION%type;
    actual_scale ALL_TAB_COLUMNS.DATA_SCALE%type;
    todo_string VARCHAR(500);
BEGIN
    SELECT DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE INTO actual_type, actual_length, actual_precision, actual_scale
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = UPPER(owner_name)
          AND TABLE_NAME = UPPER(tab_name)
          AND COLUMN_NAME = UPPER(col_name);
          
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
--    SELECT DATA_LENGTH INTO actual_length
--        FROM ALL_TAB_COLUMNS
--        WHERE OWNER = UPPER(owner_name)
--          AND TABLE_NAME = UPPER(tab_name)
--          AND COLUMN_NAME = UPPER(col_name);
--    DBMS_OUTPUT.PUT_LINE('Aktuelle Spaltenlänge ist: ' || actual_length);
    
EXCEPTION WHEN NO_DATA_FOUND THEN  -- falls SELECT nichts liefert
    DBMS_OUTPUT.PUT_LINE('Offensichtlich wurden ungültige Werte eingegeben!');

END;

/


-- Aufruf der Prozedur:

EXEC ModifyColumnSize('hr', 'emps', 'last_name', required_length=>30);

-- oder
EXEC ModifyColumnSize('hr', 'emps', 'salary', required_precision=>10);
