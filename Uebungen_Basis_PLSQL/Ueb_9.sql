/* Erstellen Sie eine Hilfstabelle EMPSALARY mit 3 Spalten, die den Spalten 
 * employee_id, last_name und salary der Tabelle employees entspricht, 
 * mit leerem Inhalt.
 */




/* Erstellen Sie einen PL/SQL-Block, der mit Hilfe einer Substitutionsvariablen
 * f�r den Nachnamen eines Mitarbeiters die Daten aus der Tabelle employees 
 * selektiert und in die Tabelle empsalary eintr�gt.
 * Verwenden Sie dabei keinen expliziten Cursor.
 * Falls die Selektion keine Zeile oder mehr als eine Zeile zur�ckgibt,
 * behandeln Sie diese F�lle mit einer entsprechenden Ausnahmebehandlung und
 * geben eine Fehlermeldung aus.
 */




/* Erstellen Sie einen PL/SQL-Block, der die nicht-vordefinierte Exception
 * "ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found"
 * dedidiziert durch Definition einer benutzer-defifinierten Exception 
 * abfangbar macht und eine ensprechende Meldung ausgibt.
 * Provozieren Sie diese Exception, indem Sie versuchen, die Abteilung 50
 * aus der Tabelle departments zu l�schen.
 */




/* Bei unser L�sung zur Fakult�tsberechnung, ist es ein Fehler, wenn bei der
* Nutzung eine nicht-positive Gannzahl �bergeben wird.
* Erwetern Sie die L�sung zur Fakult�tsfunktion so, dass eine eigene benutzer-
* definierte Exception im Falle der nicht erlaubten Eingabe geworfen wird.
* Zus�tzlich k�nnen wir auch den Fehler durch den �berlauf spezifisch abfangen:
* "ORA-06502: PL/SQL: numeric or value error: number precision too large"
*/
