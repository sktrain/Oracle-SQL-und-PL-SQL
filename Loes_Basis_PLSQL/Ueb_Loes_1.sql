/* Erstellen Sie einen einfachen anonymen Block, 
 * der "Hallo Welt" ausgibt. 
 */

-- Eventuell sinnvolle Befehle für die Ablaufumgebung (SQL+)
-- SET ECHO ON
-- SET FEEDBACK ON
-- SET PAGESIZE 49999
-- SET SERVEROUTPUT ON SIZE 1000000

BEGIN
  dbms_output.put_line('Hello World.');
END;
/


/* Erweitern Sie den vorherigen PL/SQL-Block durch Nutzung 
 * einer Substitutionsvariablen, do dass statt einer festen Zeichenkette
 * der Wert der Substitutionsvariable ausgegeben wird.
 */

DECLARE
  my_var VARCHAR2(30);
BEGIN
  my_var := '&input';
  dbms_output.put_line('Hello '|| my_var );
END;
/ 

/* Erweitern Sie den vorherigen PL/SQL-Block durch Hinzufügen 
 * eines Deklarationsteils mit folgenden Variablen:
 * - Variable "heute" vom Typ DATE mit Initialisierung durch SYSDATE
 * - Variable "morgen" vom Typ der Variablen "heute" (Attribut %TYPE nutzen)
 * Initialisieren Sie die Variable "morgen" im Ausführungsteil mit einem 
 * Ausdruck für den morgigen Tag. Geben Sie die Werte aus.
 */

DECLARE 
  heute DATE := SYSDATE;
  morgen heute%TYPE;
BEGIN
  dbms_output.put_line('Hello World.');
  morgen := heute + 1;
  dbms_output.put_line('Heute ist: ' || heute);
  dbms_output.put_line('Morgen ist: ' || morgen);
END;
/

/* Erweitern Sie den bisherige Block um eine weitere Variable vom Typ NUMBER.
 * Erstellen Sie eine entsprechende Bind-Variable und weisen dieser einen Wert 
 * Ihrer Wahl zu. Setzen sie den Wert der PL/SQL-Variablen auf den Wert der
 * Bind-Variablen und geben Sie diese zusätzlich aus.
 */
 
 --VARIABLE zahl NUMBER
 --EXEC :zahl := 100;
 DECLARE 
  heute DATE := SYSDATE;
  morgen heute%TYPE;
  myzahl NUMBER;
BEGIN
  dbms_output.put_line('Hello World.');
  morgen := heute + 1;
  dbms_output.put_line('Heute ist: ' || heute);
  dbms_output.put_line('Morgen ist: ' || morgen);
  myzahl := &zahl;
  DBMS_OUTPUT.PUT_LINE('Die eingegeben Zahl ist: ' || myzahl);
END;
/


 
 