/* Erstellen Sie einen PL/SQL-Block, der die höchste Abteilungsnummer
* aus der Tabelle "departments" abruft und in einer Variablen speichert.
* Geben Sie die Variable aus
*/





/* Erweitern Sie das obige Programm um das Einfügen einer neuen Abteilung:
 * Setzen Sie den Namen anhand einer PL/SQL-Variablen und die Abteilungsnummer
 * um 10 höher als die bislang höchste Abteilungsnummer. Die Lokationskennung
 * und die Abteilungsleiterkennung können Sie mit NULL belegen.
 * Prüfen Sie mit Hilfe des Attributs SQL%ROWCOUNT, ob das Hinzufügen 
 * erfolgreich war.
 */



-- nur zur Überprüfung
SELECT * FROM departments WHERE DEPARTMENT_NAME = 'Muster_Abt';

/* Ergänzen Sie den bisherigen Code, so dass die Lokationskennung (location_id)
 * mittels UPDATE-Anweisung auf 3000 gesetzt wird.
 */
