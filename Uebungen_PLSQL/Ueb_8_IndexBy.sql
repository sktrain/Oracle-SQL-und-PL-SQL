/* Erweiterung des Package EMP_PKG:
 * Statt bei der Validierung der Abteilungskennung die Tabelle DEPARTMENTS
 * zu nutzen, soll die Liste der Abteilungen einmal in den Speicher geladen
 * werden und diese Liste benutzt werden. Sofern sich die Abteilungsdaten 
 * selten ändern und damit die Liste selten aktualisiert werden muss, 
 * verspricht dieser Ansatz eine bessere Performanz.
 * Dafür sollten folgende Schritte ausgeführt werden:
 * 1) Erstellen Sie eine öffentliche Hilfsprozedur im Package, die eine
 * private Index-By-Table-Struktur mit BOOLEAN-Werten initialisiert, wobei 
 * die Abteilungsnummer aus der Tabelle DEPARTMENTS die Indizes bilden,
 * unter denen TRUE abgespeichert ist (das signalisiert eine gültige 
 * Abteilungsnummer). 
 * 2) Im Package Body wird in einem Initalisierungsblock die Speicher-Tabelle
 * mit Hilfe der Prozedur erstmalig gefüllt.
 * 3) Die Validierungsfunktion für die Abteilungsnummern wird modifiziert,
 * um jetzt anhand der Speichertabelle zu prüfen.
 */
 
 
 


/* Testen Sie die neue Funktionalität:
 * - Fügen Sie mit Hilfe der Prozedur add_emp Max Mustermann in Abteilung 
 *   15 hinzu.
 * - Fügen Sie eine neue Abteilung mit der Kennung 15 und dem Namen Security
 *   in der Tabelle DEPARTMENTS ein.
 * - Initialisieren Sie die Hauptspeichertabelle neu und versuchen Sie jetzt
 *   das Hinzufügen von Max Mustermann
*/

