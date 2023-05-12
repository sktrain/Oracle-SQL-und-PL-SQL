/* Erweiterung des Package EMP_PKG:
 * Statt bei der Validierung der Abteilungskennung die Tabelle DEPARTMENTS
 * zu nutzen, soll die Liste der Abteilungen einmal in den Speicher geladen
 * werden und diese Liste benutzt werden. Sofern sich die Abteilungsdaten 
 * selten �ndern und damit die Liste selten aktualisiert werden muss, 
 * verspricht dieser Ansatz eine bessere Performanz.
 * Daf�r sollten folgende Schritte ausgef�hrt werden:
 * 1) Erstellen Sie eine �ffentliche Hilfsprozedur im Package, die eine
 * private Index-By-Table-Struktur mit BOOLEAN-Werten initialisiert, wobei 
 * die Abteilungsnummer aus der Tabelle DEPARTMENTS die Indizes bilden,
 * unter denen TRUE abgespeichert ist (das signalisiert eine g�ltige 
 * Abteilungsnummer). 
 * 2) Im Package Body wird in einem Initalisierungsblock die Speicher-Tabelle
 * mit Hilfe der Prozedur erstmalig gef�llt.
 * 3) Die Validierungsfunktion f�r die Abteilungsnummern wird modifiziert,
 * um jetzt anhand der Speichertabelle zu pr�fen.
 */
 
 
 


/* Testen Sie die neue Funktionalit�t:
 * - F�gen Sie mit Hilfe der Prozedur add_emp Max Mustermann in Abteilung 
 *   15 hinzu.
 * - F�gen Sie eine neue Abteilung mit der Kennung 15 und dem Namen Security
 *   in der Tabelle DEPARTMENTS ein.
 * - Initialisieren Sie die Hauptspeichertabelle neu und versuchen Sie jetzt
 *   das Hinzuf�gen von Max Mustermann
*/

