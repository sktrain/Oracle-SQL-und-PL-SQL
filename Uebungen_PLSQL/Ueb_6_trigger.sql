/* Die Zeilen in der Tabelle JOBS geben die Gehaltsgrenzen je T�tigkeit vor.
 * Schreiben Sie eine Prozedur CHECK_SALARY, die pr�ft, ob das gew�nschte 
 * Gehalt eines Mitarbeiters die Grenzen einh�lt. Die Prozedur erwartet
 * als Eingabeparameter die Jobkennung und den gew�nschten Gehaltswert.
 * Bei Verletzung der Grenzen soll eine applikationsspezifische Ausnahme 
 * mit entsprechender Fehlermeldung geworfen werden.
 */



/* Erzeugen Sie einen Trigger f�r die Tabelle EMPLOYEES, der bei INSERT- oder
 * UPDATE-Operationen auf der Tabelle vor der jeweiligen Operation f�r die 
 * Zeile mit Hilfe der Prozedur CHECK_SALARY pr�ft, ob der Gehaltswert ok ist
 * und im Fehlerfalle die Operation verhindert.
 */


/* Testen Sie den Trigger:
 * F�gen Sie die Angestellte Eleanor Beh zur Abteilung 30 mit Hilfe der 
 * EMP_PKG.ADD_EMP-Prozedur hinzu.
 * Versuchen Sie das Gehalt des Mitarbeiters mit der ID 115 auf 2000 zu �ndern.
 * Versuchen Sie die Jobkennung des Mitarbeiters mit der ID 115 auf HR_REP zu
 * �ndern.
 * K�nnen Sie das Gehalt dieses Mitarbeiters erfolgreich auf 2800 �ndern?
 */
 



/* Aktualisieren Sie den obigen Trigger zur Gehaltspr�fung so, dass er nur 
 * bei einer tats�chlichen Ver�nderung der Jobkennung oder des Gehalts 
 * gefeuert wird.  Nutzen Sie daf�r eine entsprechende WHEN-Klausel.
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
 

/* Versuchen Sie f�r die Mitarbeiter mit der Jobkennung IT_PROG das Gehalt um
 * 2000 zu erh�hen.
 */
 

/* Erh�hen Sie das Gehalt von Eleanor Beh auf 9000.
 */

                     
/*  �ndern Sie die Jobkennung von Eleanor Beh zu ST_MAN.
*/
           






                     
                     
                     
/* Verhindern Sie das L�schen von Mitarbeiter-Records in der Tabelle EMPLOYEES
 * w�hrend der Gesch�ftszeiten von 9:00 bis 18:00.
 */


/* Versuchen Sie Mitarbeiter mit der Jobkennung SA_REP, die keiner Abteilung 
 * zugeordnet sind, zu l�schen. (Das sollte f�r den Mitarbeiter Grant mit
 * der ID 178 zutreffen.)
*/
