/* Berechnen Sie mit Hilfe eines PL/SQL-Blocks die Fakult�t einer positiven
 * Ganzzzahl. Die Zahl soll mit Hilfe einer Substitutionsvariablen �bergeben
 * werden.
 * Die Fakult�t einer postiven Ganzzahl N ist definiert als das Produkt
 * der Zahlen von 1 bis N:    N! = n * (n-1) * ... *1.
 * Testen Sie, ob auch eine positive Ganzzahl �bergeben wird.
 */
SET VERIFY OFF

DECLARE 
  input   NUMBER(38);
  result  NUMBER(38);
BEGIN
  input := &in;
  IF input < 1
    THEN 
      DBMS_OUTPUT.PUT_LINE('Falsche Eingabe!!  
                            Es muss positive Ganzzahl eingegeben werden');
      RETURN;
  END IF;
  result := 1;
  FOR i IN 1..input LOOP
    result := result * i;
  END LOOP;
  SYS.DBMS_OUTPUT.PUT_LINE('Fakult�t von ' || input || ' ist: ' || result);
END;
/

/* Erweitern Sie die vorherige Aufgabe so, dass die Fakult�t f�r die Zahlen 
 * von 1 bis zum Eingabewert berechnet und ausgegeben werden.
 */
SET VERIFY OFF 

DECLARE 
  input   NUMBER(38);
  result  NUMBER(38);
BEGIN
  input := &in;
  IF input < 1
    THEN 
      DBMS_OUTPUT.PUT_LINE('Falsche Eingabe!!  
                            Es muss positive Ganzzahl eingegeben werden');
      RETURN;
  END IF;
  FOR i IN 1..input LOOP
    result := 1;
    FOR j IN 1..i LOOP
      result := result * j;
    END LOOP;
    SYS.DBMS_OUTPUT.PUT_LINE('Fakult�t von ' || i || ' ist: ' || result);
  END LOOP;
END;
/

/* Mit Exception-Handling und Verwendung von PLS_INTEGER. 
 * �berlauf tritt viel fr�her auf.
 */
SET VERIFY OFF 

DECLARE 
  input   PLS_INTEGER;
  result  PLS_INTEGER;
BEGIN
  input := &in;
  IF input < 1
    THEN 
      DBMS_OUTPUT.PUT_LINE('Falsche Eingabe!!  
                            Es muss positive Ganzzahl eingegeben werden');
      RETURN;
  END IF;
  FOR i IN 1..input LOOP
    result := 1;
    FOR j IN 1..i LOOP
      result := result * j;
    END LOOP;
    SYS.DBMS_OUTPUT.PUT_LINE('Fakult�t von ' || i || ' ist: ' || result);
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    SYS.DBMS_OUTPUT.PUT_LINE('�berlauf erzeugt');
    SYS.DBMS_OUTPUT.PUT_LINE('Die Zahl ' || input || ' hat �berlauf erzeugt');
    -- funktioniert nicht, da der �berlauf nicht die �ussere Schleife abbricht !!
END;
/