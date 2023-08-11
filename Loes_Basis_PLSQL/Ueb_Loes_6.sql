/* Für die folgende Übung erstellen Sie sich mittels
 * CREATE TABLE my_emp AS SELECT ... 
 * eine Kopie der EMPLOYEES-Tabelle
 */
 
 CREATE TABLE my_emp AS SELECT * FROM employees;
 /
 
/* Erstellen Sie einen PL/SQL-Block, der die Gehälter der Abteilungen 10 bis 90 
 * jeweils um die Abteilungsnummer in Prozent erhöht.
 * Z.B. Abteilunsnummer 50 -> Gehaltsaufschlag 50%
 * Verwenden Sie die Basis-Schleife und zählen Sie die Abteilungsnummer jeweils
 * um 10 hoch (d.h. wir gehen davon aus, dass Abteilunsnummern Vielfache von 10
 * sind).
 */
DECLARE v_counter  NUMBER(3) := 10;  -- Aufpassen, wie groß v_counter wird
BEGIN
  LOOP 
    UPDATE my_emp SET salary = salary * (1 +v_counter/100)
      WHERE department_id = v_counter;
    v_counter := v_counter + 10;
    EXIT WHEN v_counter = 100;
  END LOOP;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN 
      ROLLBACK;
END;
/

/* Setzen Sie obige Aufgabe um, indem Sie die FOR-Schleife verwenden.
 */
BEGIN
  FOR i IN 1..9 LOOP 
    UPDATE my_emp SET salary = salary * (1 +i/10)
      WHERE department_id = i*10;
  END LOOP;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN 
      ROLLBACK;
END;
/
 
 
/* Verändern Sie das bisherige Programm so, dass alle Abteilungen in 
 * berücksichtigt werden, wobei Abteilungen mit geraden Vielfachen von
 * 10 bei der Abteilungsnummer 20% Gehaltserhöhung 
 * (Abteilungsnummern 20, 40, 60, ...)
 * und Abteilungen mit ungeraden Vielfachen von 10 bei der Abteilungsnummer
 * (10, 30, 50, ...)
 * 10% Gehaltserhöhung bekommen sollen. (Abteilungsnummern werden wie oben
 * jeweils um 10 weitergezählt.)
 * Verwenden Sie die WHILE-Schleife.
 */
DECLARE 
  upper_limit NUMBER(3);
  v_counter   NUMBER(3);  
BEGIN
  SELECT MIN(department_id) INTO v_counter
      FROM my_emp;
  SELECT MAX(department_id) INTO upper_limit
      FROM my_emp;
  WHILE v_counter <= upper_limit LOOP
    IF mod(v_counter/10, 2) = 0  -- gerade Abteilungsnummer
      THEN     
        UPDATE my_emp SET salary = salary * 1.2
          WHERE department_id = v_counter;
          -- DBMS_OUTPUT.put_line(v_counter || ' : gerade');
      ELSE
        UPDATE my_emp SET salary = salary * 1.1
          WHERE department_id = v_counter;
          -- DBMS_OUTPUT.put_line(v_counter || ' : ungerade');
    END IF;
    v_counter := v_counter + 10;
  END LOOP;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN 
      ROLLBACK;
END;
/ 
 
-- Zum Aufräumen
-- DROP TABLE my_emp;
