/* Die Zeilen in der Tabelle JOBS geben die Gehaltsgrenzen je Tätigkeit vor.
 * Schreiben Sie eine Prozedur CHECK_SALARY, die prüft, ob das gewünschte 
 * Gehalt eines Mitarbeiters die Grenzen einhält. Die Prozedur erwartet
 * als Eingabeparameter die Jobkennung und den gewünschten Gehaltswert.
 * Bei Verletzung der Grenzen soll eine applikationsspezifische Ausnahme 
 * mit entsprechender Fehlermeldung geworfen werden.
 */



/* Erzeugen Sie einen Trigger für die Tabelle EMPLOYEES, der bei INSERT- oder
 * UPDATE-Operationen auf der Tabelle vor der jeweiligen Operation für die 
 * Zeile mit Hilfe der Prozedur CHECK_SALARY prüft, ob der Gehaltswert ok ist
 * und im Fehlerfalle die Operation verhindert.
 */


/* Testen Sie den Trigger:
 * Fügen Sie die Angestellte Eleanor Beh zur Abteilung 30 mit Hilfe der 
 * EMP_PKG.ADD_EMP-Prozedur hinzu.
 * Versuchen Sie das Gehalt des Mitarbeiters mit der ID 115 auf 2000 zu ändern.
 * Versuchen Sie die Jobkennung des Mitarbeiters mit der ID 115 auf HR_REP zu
 * ändern.
 * Können Sie das Gehalt dieses Mitarbeiters erfolgreich auf 2800 ändern?
 */
 



/* Aktualisieren Sie den obigen Trigger zur Gehaltsprüfung so, dass er nur 
 * bei einer tatsächlichen Veränderung der Jobkennung oder des Gehalts 
 * gefeuert wird.  Nutzen Sie dafür eine entsprechende WHEN-Klausel.
 * (Achten Sie dabei auf den NULL-Wert im OLD-Record beim INSERT)
 */


/* Testen Sie den Trigger mit Hilfe der Prozedur EMP_PKG.ADD_EMP mit 
 * folgenden Parametern: 
 * Vorname: 'Eleanor'
 * Nachname: 'Beh'
 * Email: 'EBEH'
 * Job: 'IT_PROG'
 * Salary: 5000
 */
 

/* Versuchen Sie für die Mitarbeiter mit der Jobkennung IT_PROG das Gehalt um
 * 2000 zu erhöhen.
 */
 

/* Erhöhen Sie das Gehalt von Eleanor Beh auf 9000.
 */

                     
/*  Ändern Sie die Jobkennung von Eleanor Beh zu ST_MAN.
*/
           






                     
                     
                     
/* Verhindern Sie das Löschen von Mitarbeiter-Records in der Tabelle EMPLOYEES
 * während der Geschäftszeiten von 9:00 bis 18:00.
 */


/* Versuchen Sie Mitarbeiter mit der Jobkennung SA_REP, die keiner Abteilung 
 * zugeordnet sind, zu löschen. (Das sollte für den Mitarbeiter Grant mit
 * der ID 178 zutreffen.)
*/
