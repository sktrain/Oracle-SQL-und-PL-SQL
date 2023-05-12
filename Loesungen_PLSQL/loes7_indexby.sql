/* Erzeugen Sie einen PL/SQL-Block, der die Abteilungsnamen aus der Tabelle
 * DEPARTMENTS mittels einer Schleife in einen INDEX BY Table speichert.
 * Sie können dabei nutzen, dass die Abteilungsnummern Vielfache von 10 sind.
 * Geben Sie anschließend die gespeicherten Werte zur Kontrolle wieder aus.
 */

DECLARE
   TYPE dept_table_type is table of departments.department_name%TYPE 
   INDEX BY PLS_INTEGER;
   my_dept_table   dept_table_type;
   count_deptid   NUMBER(4);
   min_deptid   NUMBER(4);
   v_deptno     NUMBER(4);
BEGIN
  SELECT count(department_id), min(department_id) INTO count_deptid, v_deptno
    FROM departments;
    
  FOR i IN 1..count_deptid
  LOOP	
    SELECT department_name INTO my_dept_table(i)
      FROM departments	WHERE department_id = v_deptno;
      v_deptno := v_deptno+10;
  END LOOP;
 FOR i IN 1..count_deptid
  LOOP
    DBMS_OUTPUT.PUT_LINE (my_dept_table(i));
  END LOOP;
END;



/* Erweitern Sie die vorherige Lösung so, dass der INDEX BY Table statt dem 
 * Namen alle Informationen zur Abteilung speichern kann (Record-basiert).
 */
DECLARE
TYPE dept_table_type is table of departments%ROWTYPE 
   INDEX BY PLS_INTEGER;
   my_dept_table	dept_table_type;
   count_deptid   NUMBER(4);
   min_deptid   NUMBER(4);
   v_deptno     NUMBER(4);
BEGIN
  SELECT count(department_id), min(department_id) INTO count_deptid, v_deptno
    FROM departments;
    
  FOR i IN 1..count_deptid
  LOOP	
    SELECT * INTO my_dept_table(i)
      FROM departments	WHERE department_id = v_deptno;
      v_deptno := v_deptno+10;
  END LOOP;
 FOR i IN 1..count_deptid
  LOOP
    DBMS_OUTPUT.PUT_LINE ('Department Number: ' || my_dept_table(i).department_id
     || ' Department Name: ' || my_dept_table(i).department_name 
     || ' Manager Id: '||  my_dept_table(i).manager_id
     || ' Location Id: ' || my_dept_table(i).location_id);
  END LOOP;
END;

