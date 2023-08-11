/* Erstellen Sie einen parametrisierten Cursor, der eine Job_id und
 * einen Vergleichswert für das Gehalt erwartet, und mittels einer Abfrage
 * den Nachnamen, Vornamen und den Wert (Gehalt - Vergleichswert) der 
 * Mitarbeiter abfragt, deren Gehalt über dem Vergleichswert liegt.
 * Die Ergebnisse sollen mit dem Hinweis "Overpaid" einmal für die Kombination 
 * ('ST_CLERK', 5000)   und  einmal für die Kombination ('SA_REP', 10000)
 * ausgegeben werden, d.h. der Cursor wird jeweils mit der entsprechenden
 * Parametrisierung verwendet.
 */
DECLARE
    last_name_   employees.last_name%TYPE;
    first_name_  employees.first_name%TYPE;
    overpayment_      employees.salary%TYPE;
  -- Parametrisierter Cursor
  CURSOR c (job VARCHAR2, max_sal NUMBER) IS
    SELECT last_name, first_name, (salary - max_sal) overpayment
    FROM employees
    WHERE job_id = job
    AND salary > max_sal
    ORDER BY salary;
 
BEGIN
-- 1. Verwendung für ST_Clerk
  DBMS_OUTPUT.PUT_LINE('----------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Stock Clerks:');
  DBMS_OUTPUT.PUT_LINE('----------------------');
  OPEN c('ST_CLERK', 5000);
  LOOP
      FETCH c INTO last_name_, first_name_, overpayment_;
      EXIT WHEN c%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(last_name_ || ', ' || first_name_ ||
        ' (by ' || overpayment_ || ')');
    END LOOP;
  CLOSE c;
  
  
-- 2. Verwendung für ST_Clerk
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  DBMS_OUTPUT.PUT_LINE('Overpaid Sales Representatives:');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  OPEN c('SA_REP', 10000);
  LOOP
      FETCH c INTO last_name_, first_name_, overpayment_;
      EXIT WHEN c%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(last_name_ || ', ' || first_name_ ||
        ' (by ' || overpayment_ || ')');
    END LOOP;
  CLOSE c;
END;
/