/* Erstellen Sie einen PL/SQL-Block, der Informationen zu einem Land ausgibt.
 * Verwenden Sie dabei einen RECORD, basierend auf der Tabelle countries.
 * �ber eine Austauschvariable cid soll die L�nderkennung (country_id) angeben, 
 * die entsprechenden Daten in den Record gelesen und anschlie�end 
 * �ber den Record ausgegeben werden.
 * Testen Sie das mit verschiedenen L�nderkennungen, z.B. CA, US, DE
 */

SET VERIFY OFF

DECLARE 
  c_record  countries%ROWTYPE;
BEGIN 
  SELECT * INTO c_record
      FROM countries WHERE country_id = UPPER('&cid');
  DBMS_OUTPUT.PUT_LINE('L�nderkennung: ' || c_record.country_id);
  DBMS_OUTPUT.PUT_LINE('L�ndername: ' || c_record.country_name);
  DBMS_OUTPUT.PUT_LINE('Regionskennung: ' || c_record.region_id);
END;
/  
  
/* Erstellen Sie einen Record, der aus der Tabelle employees den Vornamen und 
 * Nachnamen �bernimmt und aus der Tabelle departments die Abteilungsnummer und
 * den Abteilungsnamen.
 * F�llen Sie in den RECORD die Daten des Mitarbeiters mit der Nummer 110 
 * mit den zugeh�rigen Abteilungsdaten.
 * Geben Sie diese anschlie�end �ber den Record aus.
 */
DECLARE 
  TYPE rec_ma_type IS RECORD (vorname VARCHAR2(30),
                              nachname VARCHAR2(30),
                              abtnr  departments.department_id%TYPE,
                              abtname departments.department_name%TYPE);
  ma_record rec_ma_type;
BEGIN
  SELECT e.first_name, e.last_name, d.department_id, d.department_name
      INTO ma_record 
      FROM employees e JOIN departments d
                    ON e.department_id = d.department_id
      WHERE employee_id = 110;
  DBMS_OUTPUT.PUT_LINE('Vorname: ' || ma_record.vorname);
  DBMS_OUTPUT.PUT_LINE('Nachname: ' || ma_record.nachname);
  DBMS_OUTPUT.PUT_LINE('Abteilungsnummer: ' || ma_record.abtnr);
  DBMS_OUTPUT.PUT_LINE('Abteilungsname: ' || ma_record.abtname);
END;
/

/* F�gen Sie eine Zeile in die Tabelle departments ein, indem Sie einen
 * Record verwenden.
 * Es sollen folgende Daten eingef�gt werden:
 * Name: "Musterabteilung", ID:  "4711", die restlichen Werte k�nnen
 * auf Null gesetzt werden.
 */
DECLARE
  dep_record  departments%ROWTYPE;
BEGIN
  dep_record.department_id := 4711;
  dep_record.department_name := 'Musterabteilung';
  dep_record.manager_id := NULL;
  -- location_id ist null, wenn nicht explizit gesetzt
  
  INSERT INTO departments VALUES dep_record;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN ROLLBACK;
END;
/


  