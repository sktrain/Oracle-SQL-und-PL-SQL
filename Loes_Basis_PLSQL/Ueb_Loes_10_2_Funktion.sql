/* Erstellen Sie für unsere Fakultätsberechnung eine entsprechende Funktion.
 * Testen Sie diese durch Aufruf.
 */
create or replace FUNCTION fakultaet(n NUMBER)
  RETURN NUMBER
  AS
    result  NUMBER(38);
  BEGIN
    IF n < 1
    THEN 
      RAISE_APPLICATION_ERROR(-20210, 'Only positive numbers allowed');
    END IF;
    result := 1;
    FOR i IN 1..n LOOP
     result := result * i;
    END LOOP;
    return result;
END;
/
SELECT fakultaet(40) FROM dual;



/* Erweitern Sie die Lösung so, dass auch eine benutzerdefinierte Exception
 * geworfen wird, wenn ein Überlauf auftritt.
 */
 
create or replace FUNCTION fakultaet(n NUMBER)
  RETURN NUMBER
AS
    result  NUMBER(38);
    value_error Exception;
    PRAGMA EXCEPTION_INIT (value_error, -01426);
BEGIN
    IF n < 1
    THEN 
      RAISE_APPLICATION_ERROR(-20210, 'Only positive numbers allowed');
    END IF;
    result := 1;
    FOR i IN 1..n LOOP
     result := result * i;
    END LOOP;
    RETURN result;
EXCEPTION 
  WHEN VALUE_ERROR THEN
    RAISE_APPLICATION_ERROR(-20211, 'Overflow');
END;


/* Können Sie auch eine rekursive Variante der Funktion schreiben, d.h. die
 * Funktion ruft sich selbst auf nach dem Muster:
 * Fakultaet(n) = n * Fakultaet(n-1)
 * Hinweis: Sportliche Aufgabe?
 */
 create or replace FUNCTION fakultaet_rek(n NUMBER)
  RETURN NUMBER
  AS
  BEGIN
    IF (n = 1) 
      THEN RETURN 1;
      ELSE RETURN (n * fak(n-1));
    END IF;
  END;
  
SELECT fakultaet_rek(5) from dual;