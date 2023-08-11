/* Erstellen Sie einen PL/SQL-Block der via Substitutionsvariable 
 * eine Angestelltennummer entgegen nimmt, damit die Tabelle "Employees"
 * abfragt. Der Nachname und das Gehalt werden abgefragt, in Variablen 
 * gespeichert und anschlie�end ausgegeben.
 */
SET VERIFY OFF
DECLARE 
  l_name  employees.last_name%TYPE;
  sal     employees.salary%TYPE;
BEGIN
  SELECT last_name, salary INTO l_name, sal FROM employees
      WHERE employee_id = &id;
  DBMS_OUTPUT.PUT_LINE(l_name || ' : ' || sal);
END;


/* Erweitern Sie die vorige L�sung so, dass durch ihr Programm eine 
 * Fehlermeldung ausgegeben wird, falls eine ung�ltige Angestelltennummer
 * eingegeben wird.
 */
SET VERIFY OFF
DECLARE 
  l_name  employees.last_name%TYPE;
  sal     employees.salary%TYPE;
BEGIN
  SELECT last_name, salary INTO l_name, sal FROM employees
      WHERE employee_id = &id;
  DBMS_OUTPUT.PUT_LINE(l_name || ' : ' || sal);
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.PUT_LINE('Fehler: es wurde wahrscheinlich keine g�ltige Nummer angegeben');
END;

/* Erweitern Sie die vorige L�sung so, dass der Beitrag des Angestellten zur
 * Pensionskasse berechnet und ausgegeben wird.
 * Der Beitrag betr�gt 12% des Versorgungsbezugs. 
 * Der Versorgungsbezug sind 45% des Gehalts.
 */
 
SET VERIFY OFF
DECLARE 
  l_name  employees.last_name%TYPE;
  sal     employees.salary%TYPE;
  beitrag NUMBER;
BEGIN
  SELECT last_name, salary INTO l_name, sal FROM employees
      WHERE employee_id = &id;
  DBMS_OUTPUT.PUT_LINE(l_name || ' : ' || sal);
  beitrag := (sal * 0.45)*0.12;
  DBMS_OUTPUT.PUT_LINE('Der Beitrag f�r die Pensionskasse ist: ' || beitrag);
EXCEPTION
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.PUT_LINE('Fehler: es wurde wahrscheinlich keine g�ltige Nummer angegeben');
END;
