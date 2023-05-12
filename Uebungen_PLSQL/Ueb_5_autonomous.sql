/* Wenn die Prozedur add_emp aus dem Package emp_pkg ausgef�hrt wird, soll das
 * in einer Log-Tabelle protokolliert werden.
 * Dazu wird zuerst die Log-Tabelle und eine Sequenz f�r die Protokolleintr�ge
 * mit Hilfe folgender Anweisungen erstellt:
 */

CREATE SEQUENCE  log_seq  MINVALUE 1 MAXVALUE 99999999999999999999999
INCREMENT BY 1 START WITH 1 NOCACHE  NOCYCLE ;

CREATE TABLE LOG_EMP (  log_id NUMBER PRIMARY KEY,
                        user_name VARCHAR2(30),
                        c_date DATE,
                        e_lastname  VARCHAR2(25 BYTE)
                      );

/* Erg�nzen Sie die Prozedur add_emp im Package emp_pkg mit einer lokalen 
 * Prozedur (innerhalb von add_emp), die nach erfolgreicher Pr�fung der 
 * Abteilungsnummer und Einf�gen des neuen Mitarbeiters einen Eintrag in
 * der Log-Tabelle erstellt, der unabh�ngig von einen eventuellen Rollback 
 * existieren soll, d.h. es ist eine autonome Transaktion zu verwenden.
 * Folgende Werte sollen protokolliert werden:
 * - Name des Benutzers (SQL-Funktion USER)
 * - Zeitpunkt
 * - Nachname des neu hinzugef�gten Mitarbeiters
 */




/* Testen Sie die Protokollierung durch das Hinzuf�gen neuer Mitarbeiter, 
 * f�hren Sie einen Rollback durch und vergewissen Sie sich, dass die 
 * Log-Eintr�ge trotzdem noch vorhanden sind.
 */


