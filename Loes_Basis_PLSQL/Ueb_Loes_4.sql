/* Erstellen Sie einen PL/SQL-Block, der die h�chste Abteilungsnummer
* aus der Tabelle "departments" abruft und in einer Variablen speichert.
* Geben Sie die Variable aus
*/
DECLARE 
  max_deptno  DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
  SELECT MAX(department_id) INTO max_deptno FROM departments;
  DBMS_OUTPUT.PUT_LINE('Max. Abteilungsnummer: ' || max_deptno);
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.PUT_LINE(sqlerrm);
END;


/* Erweitern Sie das obige Programm um das Einf�gen einer neuen Abteilung:
 * Setzen Sie den Namen anhand einer PL/SQL-Variablen und die Abteilungsnummer
 * um 10 h�her als die bislang h�chste Abteilungsnummer. Die Lokationskennung
 * und die Abteilungsleiterkennung k�nnen Sie mit NULL belegen.
 * Pr�fen Sie mit Hilfe des Attributs SQL%ROWCOUNT, ob das Hinzuf�gen 
 * erfolgreich war.
 */
DECLARE 
  max_deptno  DEPARTMENTS.DEPARTMENT_ID%TYPE;
  dept_name   DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
  SELECT MAX(department_id) INTO max_deptno FROM departments;
  DBMS_OUTPUT.PUT_LINE('Max. Abteilungsnummer: ' || max_deptno);
  dept_name := 'Muster_Abt';
  INSERT INTO departments (department_id, department_name, location_id, manager_id)
    VALUES (max_deptno+10, dept_name, NULL, NULL);
  DBMS_OUTPUT.PUT_LINE('Zeilen getroffen: ' || SQL%ROWCOUNT);
  COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE(sqlerrm);
END; 
/
-- nur zur �berpr�fung
SELECT * FROM departments WHERE DEPARTMENT_NAME = 'Muster_Abt';

/* Erg�nzen Sie den bisherigen Code, so dass die Lokationskennung (location_id)
 * mittels UPDATE-Anweisung auf 3000 gesetzt wird.
 */
DECLARE 
  max_deptno  DEPARTMENTS.DEPARTMENT_ID%TYPE;
  dept_name   DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
  SELECT MAX(department_id) INTO max_deptno FROM departments;
  DBMS_OUTPUT.PUT_LINE('Max. Abteilungsnummer: ' || max_deptno);
  dept_name := 'Muster_Abt';
  INSERT INTO departments (department_id, department_name, location_id, manager_id)
    VALUES (max_deptno+10, dept_name, NULL, NULL);
  DBMS_OUTPUT.PUT_LINE('INSERT: Zeilen getroffen: ' || SQL%ROWCOUNT);
  UPDATE departments
    SET location_id = 3000
    WHERE department_name = dept_name;
  DBMS_OUTPUT.PUT_LINE('UPDATE: Zeilen getroffen: ' || SQL%ROWCOUNT);
  COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE(sqlerrm);
END;
 