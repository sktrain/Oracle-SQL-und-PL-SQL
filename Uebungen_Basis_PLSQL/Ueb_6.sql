/* F�r die folgende �bung erstellen Sie sich mittels
 * CREATE TABLE my_emp AS SELECT ... 
 * eine Kopie der EMPLOYEES-Tabelle
 */
 
 CREATE TABLE my_emp AS SELECT * FROM employees;
 /
 
/* Erstellen Sie einen PL/SQL-Block, der die Geh�lter der Abteilungen 10 bis 90 
 * jeweils um die Abteilungsnummer in Prozent erh�ht.
 * Z.B. Abteilunsnummer 50 -> Gehaltsaufschlag 50%
 * Verwenden Sie die Basis-Schleife und z�hlen Sie die Abteilungsnummer jeweils
 * um 10 hoch (d.h. wir gehen davon aus, dass Abteilunsnummern Vielfache von 10
 * sind).
 */





/* Setzen Sie obige Aufgabe um, indem Sie die FOR-Schleife verwenden.
 */



 
 
/* Ver�ndern Sie das bisherige Programm so, dass alle Abteilungen in 
 * ber�cksichtigt werden, wobei Abteilungen mit geraden Vielfachen von
 * 10 bei der Abteilungsnummer 20% Gehaltserh�hung 
 * (Abteilungsnummern 20, 40, 60, ...)
 * und Abteilungen mit ungeraden Vielfachen von 10 bei der Abteilungsnummer
 * (10, 30, 50, ...)
 * 10% Gehaltserh�hung bekommen sollen. (Abteilungsnummern werden wie oben
 * jeweils um 10 weitergez�hlt.)
 * Verwenden Sie die WHILE-Schleife.
 */

 

