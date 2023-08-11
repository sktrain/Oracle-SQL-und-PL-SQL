/* Erstellen Sie einen PL/SQL-Block, der die h�chste Abteilungsnummer
* aus der Tabelle "departments" abruft und in einer Variablen speichert.
* Geben Sie die Variable aus
*/





/* Erweitern Sie das obige Programm um das Einf�gen einer neuen Abteilung:
 * Setzen Sie den Namen anhand einer PL/SQL-Variablen und die Abteilungsnummer
 * um 10 h�her als die bislang h�chste Abteilungsnummer. Die Lokationskennung
 * und die Abteilungsleiterkennung k�nnen Sie mit NULL belegen.
 * Pr�fen Sie mit Hilfe des Attributs SQL%ROWCOUNT, ob das Hinzuf�gen 
 * erfolgreich war.
 */



-- nur zur �berpr�fung
SELECT * FROM departments WHERE DEPARTMENT_NAME = 'Muster_Abt';

/* Erg�nzen Sie den bisherigen Code, so dass die Lokationskennung (location_id)
 * mittels UPDATE-Anweisung auf 3000 gesetzt wird.
 */
