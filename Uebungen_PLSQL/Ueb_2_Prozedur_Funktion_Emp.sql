/* Erstellen Sie eine Funktion, die für eine gegebene Mitarbeiterkennung das
 * jährliche Gesamtgehalt des Mitarbeiters liefert.
 * Dieses berechnet sich wie folgt:
 * (salary*12) + (commission_pct*salary*12)
 * Die Funktion soll auch für eventuelle Null-Werte beim Gehalt oder der
 * Provision einen entsprechenden numerischen Wert liefern.
 */

 
/* Nutzen Sie die Funktion get_annual_sal in einer SELECT-Anweisung, die für 
 * alle Mitarbeiter der Abteilungen 50 und 80 eine entsprechende Spalte mit dem 
 * jährlichen Gesamtgehalt ausgibt.
 */ 

          
          


/* Erstellen Sie eine Prozedur get_emp, die das Gehalt und die Jobkennung zu 
 * einer gegebenen Mitarbeiterkennung zurückliefert.
 */


/* Testen Sie die Prozedur */





/* Erstellen Sie eine Prozedur add_emp, um einen neuen Mitarbeiter in die 
 * employees-Tabelle aufzunehmen. Folgende Parameter sollen verwendet werden:
 * - first_name
 * - last_name
 * - email
 * - job: ‘SA_REP’ als default
 * - mgr: 145 als default
 * - sal: 3000 als default
 * - comm: NULL als default
 * - dept: 30 als default
 * - Für die employee_id kann die Sequenz EMPLOYEES_SEQ benutzt werden
 * - hire_date: TRUNC(SYSDATE)
 *
 * Dabei soll eine ebenfalls zu erstellende Hilfsfunktion valid_dep verwendet 
 * werden. Diese prüft, ob die angegebene Abteilungsnummer auch in der 
 * departments-Tabelle exisiert und liefert einen entsprechenden Wahrheitswert
 * zurück. 
 * Falls die Validierung nicht erfolgreich ist, soll das Hinzufügen 
 * unterbleiben und stattdessen ein Fehler an den Aufrufer signalisiert werden.
 */



/* Testen Sie die Prozedur für Ella Fitz in Abteilung 15, wobei andere 
 * Parameter soweit möglich mit ihren default-Werten benutzt werden.
 * Machen Sie einen weiteren Test mit Max Mustermann in Abteilung 80.
 */

