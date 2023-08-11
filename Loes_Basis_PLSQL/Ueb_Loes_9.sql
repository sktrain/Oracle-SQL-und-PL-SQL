/* Erstellen Sie eine Hilfstabelle EMPSALARY mit 3 Spalten, die den Spalten 
 * employee_id, last_name und salary der Tabelle employees entspricht, 
 * mit leerem Inhalt.
 */

CREATE TABLE empsalary AS 
  SELECT employee_id, last_name, salary FROM employees
  WHERE 1 = 0;
/

/* Erstellen Sie einen PL/SQL-Block, der mit Hilfe einer Substitutionsvariablen
 * für den Nachnamen eines Mitarbeiters die Daten aus der Tabelle employees 
 * selektiert und in die Tabelle empsalary einträgt.
 * Verwenden Sie dabei keinen expliziten Cursor.
 * Falls die Selektion keine Zeile oder mehr als eine Zeile zurückgibt,
 * behandeln Sie diese Fälle mit einer entsprechenden Ausnahmebehandlung und
 * geben eine Fehlermeldung aus.
 */
SET VERIFY OFF

DECLARE 
  lname  employees.last_name%TYPE;
  empid     employees.employee_id%TYPE;
  sal   employees.salary%TYPE;
BEGIN
  SELECT employee_id, last_name, salary 
    INTO empid, lname, sal 
    FROM employees   WHERE last_name = '&name';
  INSERT INTO empsalary (employee_id, last_name, salary)
    VALUES (empid, lname, sal);
  --  nur zum Test
  SYS.DBMS_OUTPUT.PUT_LINE('Zeilen erfogreich eingefügt: ' || sql%rowcount);
  
  COMMIT;
EXCEPTION 
  WHEN no_data_found THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Keine Daten gefunden für Nachnamen: ' || lname);
  WHEN too_many_rows THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Zuviele Daten gefunden für Nachnamen: ' || lname);
  WHEN OTHERS THEN
    ROLLBACK;
    SYS.DBMS_OUTPUT.PUT_LINE('Sonstiger Fehler: ' || sqlerrm);   
END;
/


/* Erstellen Sie einen PL/SQL-Block, der die nicht-vordefinierte Exception
 * "ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found"
 * dedidiziert durch Definition einer benutzer-defifinierten Exception 
 * abfangbar macht und eine ensprechende Meldung ausgibt.
 * Provozieren Sie diese Exception, indem Sie versuchen, die Abteilung 50
 * aus der Tabelle departments zu löschen.
 */

-- So sieht die nicht spezialisierte Behandlung aus:
BEGIN
DELETE FROM departments WHERE department_id = 50;
EXCEPTION
 WHEN OTHERS THEN SYS.DBMS_OUTPUT.PUT_LINE('Fehler: '  || sqlerrm);
END;

-- So sieht die Lösung aus:
DECLARE
  my_exc  EXCEPTION;
  PRAGMA EXCEPTION_INIT (my_exc, -02292);
BEGIN
  DELETE FROM departments WHERE department_id = 50;
EXCEPTION
 WHEN my_exc THEN SYS.DBMS_OUTPUT.PUT_LINE('Myexception: '  || sqlerrm);
 WHEN OTHERS THEN SYS.DBMS_OUTPUT.PUT_LINE('Sonstiger Fehler: '  || sqlerrm);
END;  
  

/* Bei unser Lösung zur Fakultätsberechnung, ist es ein Fehler, wenn bei der
* Nutzung eine nicht-positive Gannzahl übergeben wird.
* Erwetern Sie die Lösung zur Fakultätsfunktion so, dass eine eigene benutzer-
* definierte Exception im Falle der nicht erlaubten Eingabe geworfen wird.
* Zusätzlich können wir auch den Fehler durch den Überlauf spezifisch abfangen:
* "ORA-06502: PL/SQL: numeric or value error: number precision too large"
*/
SET VERIFY OFF 

DECLARE 
  input   NUMBER(38);
  result  NUMBER(38);
  in_error EXCEPTION;
  overfl EXCEPTION;
  PRAGMA EXCEPTION_INIT (overfl, -06502);
BEGIN
  input := &in;
  IF input < 1
    THEN 
      -- DBMS_OUTPUT.PUT_LINE('Falsche Eingabe!! ');
      RAISE in_error;
  END IF;
  
  FOR i IN 1..input LOOP
    result := 1;
    FOR j IN 1..i LOOP
      result := result * j;
    END LOOP;
    SYS.DBMS_OUTPUT.PUT_LINE('Fakultät von ' || i || ' ist: ' || result);
  END LOOP;
EXCEPTION 
  WHEN in_error THEN
     SYS.DBMS_OUTPUT.PUT_LINE('Eingabefehler: '  || sqlcode);
     -- den Fehler sollte eher der Aufrufer abfangen
  WHEN overfl THEN
    SYS.DBMS_OUTPUT.PUT_LINE('Überlauf: '  || sqlcode);
  WHEN OTHERS THEN 
    SYS.DBMS_OUTPUT.PUT_LINE('Sonstiger Fehler: '  || sqlcode);
END;
/