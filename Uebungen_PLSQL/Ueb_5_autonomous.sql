/* Wenn die Prozedur add_emp aus dem Package emp_pkg ausgeführt wird, soll das
 * in einer Log-Tabelle protokolliert werden.
 * Dazu wird zuerst die Log-Tabelle und eine Sequenz für die Protokolleinträge
 * mit Hilfe folgender Anweisungen erstellt:
 */

CREATE SEQUENCE  log_seq  MINVALUE 1 MAXVALUE 99999999999999999999999
INCREMENT BY 1 START WITH 1 NOCACHE  NOCYCLE ;

CREATE TABLE LOG_EMP (  log_id NUMBER PRIMARY KEY,
                        user_name VARCHAR2(30),
                        c_date DATE,
                        e_lastname  VARCHAR2(25 BYTE)
                      );

/* Ergänzen Sie die Prozedur add_emp im Package emp_pkg mit einer lokalen 
 * Prozedur (innerhalb von add_emp), die nach erfolgreicher Prüfung der 
 * Abteilungsnummer und Einfügen des neuen Mitarbeiters einen Eintrag in
 * der Log-Tabelle erstellt, der unabhängig von einen eventuellen Rollback 
 * existieren soll, d.h. es ist eine autonome Transaktion zu verwenden.
 * Folgende Werte sollen protokolliert werden:
 * - Name des Benutzers (SQL-Funktion USER)
 * - Zeitpunkt
 * - Nachname des neu hinzugefügten Mitarbeiters
 */




/* Testen Sie die Protokollierung durch das Hinzufügen neuer Mitarbeiter, 
 * führen Sie einen Rollback durch und vergewissen Sie sich, dass die 
 * Log-Einträge trotzdem noch vorhanden sind.
 */


