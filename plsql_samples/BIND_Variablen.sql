-- Deklaration einer BIND-Variablen
VARIABLE e_id NUMBER;

-- Wertzuweisung in SQLPlus
EXECUTE :e_id := 101;
-- oder
EXEC :e_id := 100;

-- Verwenden von Bind-Variablen
SELECT last_name, first_name
  FROM employees
  WHERE employee_id = :e_id;
  
-- Verwenden/Wertzuweisung in PL/SQL
BEGIN
:e_id := 101;
END;
-- oder auch
BEGIN
  SELECT employee_id INTO :e_id FROM employees WHERE employee_id = 100;
END;


-- Anzeige aller Variablendeklarationen 
-- VARIABLE;

-- Ausgabe aller Variablen
--PRINT;
-- Ausgabe einer Variablen
--PRINT :e_id;
