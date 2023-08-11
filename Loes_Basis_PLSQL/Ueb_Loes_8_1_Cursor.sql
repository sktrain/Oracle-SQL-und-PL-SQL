/* Erstellen Sie eine Hilfstabelle TOPSALARIES mit einer
 * Spalte f�r die Geh�lter auf Basis der EMPLOYEES-Tabelle
 */
CREATE TABLE TOPSALARIES AS
    SELECT salary FROM employees WHERE 1 = 0;
/

/* Fragen Sie mit Hilfe eines Cursors die n h�chsten Geh�lter
 * aus der Tabelle EMPLOYEES ab und tragen Sie diese in die
 * Tabelle TOPSALARIES ein. Den Wert f�r n k�nnen Sie frei 
 * w�hlen und sich bei Bedarf auch per Austauschvariable liefern
 * lassen.
 * Der Cursor sollte die Geh�lter ohne Duplikate in absteigender
 * Reihenfolge liefern.
 */

-- L�sung mit festem n = 10 und WHILE-Schleife
DECLARE 
  lim NUMBER(3) := 10;
  sal employees.salary%TYPE;
  -- Cursor-Deklaration
  CURSOR emp_sal_cursor IS
    SELECT DISTINCT salary FROM employees
        ORDER BY salary DESC NULLS LAST;

BEGIN
  OPEN emp_sal_cursor;
  FETCH emp_sal_cursor INTO sal;  -- Ersten Wert holen
  WHILE emp_sal_cursor%ROWCOUNT <= lim AND
        emp_sal_cursor%FOUND   -- solange noch was zu holen und im Limit
    LOOP
      -- SYS.DBMS_OUTPUT.PUT_LINE(sal); -- nur zum Test
      INSERT INTO topsalaries (salary) VALUES (sal);
      FETCH emp_sal_cursor INTO sal;  -- n�chsten Wert holen
    END LOOP;
  -- Ende der Verarbeitung
  CLOSE emp_sal_cursor;
END;
/

SELECT * FROM topsalaries; -- nur zum Test
/
-- L�sung mit Setzen von n via Austauschvariable und Basis-Schleife
SET VERIFY OFF

DECLARE 
  lim NUMBER(3) := &limit;
  sal employees.salary%TYPE;
  -- Cursor-Deklaration
  CURSOR emp_sal_cursor IS
    SELECT DISTINCT salary FROM employees
        ORDER BY salary DESC NULLS LAST;

BEGIN
  OPEN emp_sal_cursor;
  LOOP
    -- Retrieve one row.
    FETCH emp_sal_cursor INTO sal;
    -- Exit the loop after all rows have been retrieved.
    EXIT WHEN emp_sal_cursor%NOTFOUND 
              OR emp_sal_cursor%ROWCOUNT > lim;
    /* Process data here */
    -- DBMS_OUTPUT.PUT_LINE(sal); nur zum Test
    INSERT INTO topsalaries (salary) VALUES (sal);
  END LOOP;
  -- End processing.
  CLOSE emp_sal_cursor;
END;
/

DELETE FROM topsalaries;  -- nur zum Aufr�umen

