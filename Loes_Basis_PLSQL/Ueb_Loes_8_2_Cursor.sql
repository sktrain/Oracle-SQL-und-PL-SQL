/* Fragen Sie mit Hilfe eines Cursors für eine gegebene Abteilungsnummer
 * Nachname, Gehalt und Manager_ID aus der Tabelle EMPLOYEES abruft, 
 * die in der angegebenen Abteilung arbeiten.
 * Verwenden Sie dabei die Cursor-FOR-Schleife.
 * Wenn das Gehalt des Angestellten unter 5000 liegt, zeigen Sie die
 * Nachricht "Gehaltserhöhung steht an" an, andernfalls die Nachricht 
 * "Gehalt ist ok".
 */
SET VERIFY OFF
DECLARE
  -- über Austauschvariable
  deptno employees.department_id%TYPE := &dep;
  
  CURSOR emp_dep_cursor IS
    SELECT last_name, salary, manager_id
      FROM employees 
      WHERE department_id = deptno;
BEGIN
  -- Impliziter OPEN.
  FOR emp_record IN emp_dep_cursor LOOP
    -- Impliziter FETCH erfolgt hier
    -- emp_dep_cursor%NOTFOUND wird implizit gecheckt als Abbruchbedingung

    -- Verarbeitung der geholten Zeilen
    IF emp_record.salary < 5000
      THEN 
        DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ': Gehaltserhöhung steht an');
      ELSE
        DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ': Gehalt ist ok');
    END IF;
  END LOOP;
  -- Impliziter CLOSE erfolgt 
END;
/



/* Erweitern Sie die Lösung, so dass statt der Manager_ID der Name des 
 * Managers geholt und mit ausgegeben wird.
 */
SET VERIFY OFF
DECLARE
  -- über Austauschvariable
  deptno employees.department_id%TYPE := &dep;
  
  CURSOR emp_dep_cursor IS
    SELECT i.last_name as lname, i.salary as sal, c.last_name as chief
      FROM employees i JOIN employees c
           ON i.manager_id = c.employee_id
      WHERE i.department_id = deptno;
BEGIN
  -- Impliziter OPEN.
  FOR emp_record IN emp_dep_cursor LOOP
    -- Impliziter FETCH erfolgt hier
    -- emp_dep_cursor%NOTFOUND wird implizit gecheckt als Abbruchbedingung

    -- Verarbeitung der geholten Zeilen
    IF emp_record.sal < 5000
      THEN 
        DBMS_OUTPUT.PUT_LINE('Hallo ' || emp_record.chief || ' fuer: ' || 
                         emp_record.lname || ': Gehaltserhöhung steht an');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Hallo ' || emp_record.chief || ' fuer: ' || 
                         emp_record.lname || ': Gehalt ist ok');
    END IF;
  END LOOP;
  -- Impliziter CLOSE erfolgt 
END;
/

