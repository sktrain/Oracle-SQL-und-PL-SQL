/* Die Zeilen in der Tabelle JOBS geben die Gehaltsgrenzen je T�tigkeit vor.
 * Schreiben Sie eine Prozedur CHECK_SALARY, die pr�ft, ob das gew�nschte 
 * Gehalt eines Mitarbeiters die Grenzen einh�lt. Die Prozedur erwartet
 * als Eingabeparameter die Jobkennung und den gew�nschten Gehaltswert.
 * Bei Verletzung der Grenzen soll eine applikationsspezifische Ausnahme 
 * mit entsprechender Fehlermeldung geworfen werden.
 */


CREATE OR REPLACE PROCEDURE check_salary (p_the_job VARCHAR2,
                                          p_the_salary NUMBER) IS
  v_minsal jobs.min_salary%type;
  v_maxsal jobs.max_salary%type;
BEGIN
  SELECT min_salary, max_salary INTO v_minsal, v_maxsal
  FROM jobs
  WHERE job_id = UPPER(p_the_job);
  IF p_the_salary NOT BETWEEN v_minsal AND v_maxsal THEN
    RAISE_APPLICATION_ERROR(-20100, 
      'Invalid salary $' ||p_the_salary ||'. '||
      'Salaries for job '|| p_the_job || 
      ' must be between $'|| v_minsal ||' and $' || v_maxsal);
  END IF;
END;
/

/* Erzeugen Sie einen Trigger f�r die Tabelle EMPLOYEES, der bei INSERT- oder
 * UPDATE-Operationen auf der Tabelle vor der jeweiligen Operation f�r die 
 * Zeile mit Hilfe der Prozedur CHECK_SALARY pr�ft, ob der Gehaltswert ok ist
 * und im Fehlerfalle die Operation verhindert.
 */

CREATE OR REPLACE TRIGGER check_salary_trg 
BEFORE INSERT OR UPDATE OF job_id, salary 
ON employees
FOR EACH ROW
BEGIN
  check_salary(:new.job_id, :new.salary);
END;
/

/* Testen Sie den Trigger:
 * F�gen Sie die Angestellte Eleanor Beh zur Abteilung 30 mit Hilfe der 
 * EMP_PKG.ADD_EMP-Prozedur hinzu.
 * Versuchen Sie das Gehalt des Mitarbeiters mit der ID 115 auf 2000 zu �ndern.
 * Versuchen Sie die Jobkennung des Mitarbeiters mit der ID 115 auf HR_REP zu
 * �ndern.
 * K�nnen Sie das Gehalt dieses Mitarbeiters erfolgreich auf 2800 �ndern?
 */
 
EXECUTE emp_pkg.add_emp('Eleanor', 'Beh', 30);

UPDATE employees
  SET salary = 2000
WHERE employee_id = 115;

UPDATE employees
  SET job_id = 'HR_REP'
WHERE employee_id = 115;

UPDATE employees
  SET salary = 2800
WHERE employee_id = 115;



/* Aktualisieren Sie den obigen Trigger zur Gehaltspr�fung so, dass er nur 
 * bei einer tats�chlichen Ver�nderung der Jobkennung oder des Gehalts 
 * gefeuert wird.  Nutzen Sie daf�r eine entsprechende WHEN-Klausel.
 * (Achten Sie dabei auf den NULL-Wert im OLD-Record beim INSERT)
 */

CREATE OR REPLACE TRIGGER check_salary_trg 
BEFORE INSERT OR UPDATE OF job_id, salary 
ON employees FOR EACH ROW
WHEN (new.job_id <> NVL(old.job_id,'?') OR
      new.salary <> NVL(old.salary,0))
BEGIN
  check_salary(:new.job_id, :new.salary);
END;
/

/* Testen Sie den Trigger mit Hilfe der Prozedur EMP_PKG.ADD_EMP mit 
 * folgenden Parametern: 
 * Vorname: 'Eleanor'
 * Nachname: 'Beh'
 * Email: 'EBEH'
 * Job: 'IT_PROG'
 * Salary: 5000
 */
 
BEGIN
  emp_pkg.add_emp('Eleanor', 'Beh', 'EBEH',
                        job => 'IT_PROG', sal => 5000);
END;

/* Versuchen Sie f�r die Mitarbeiter mit der Jobkennung IT_PROG das Gehalt um
 * 2000 zu erh�hen.
 */
 
UPDATE employees
  SET salary = salary + 2000
WHERE job_id = 'IT_PROG';

/* Erh�hen Sie das Gehalt von Eleanor Beh auf 9000.
 */

UPDATE employees
  SET salary = 9000
WHERE employee_id = (SELECT employee_id
                     FROM employees
                     WHERE last_name = 'Beh');
                     
/*  �ndern Sie die Jobkennung von Eleanor Beh zu ST_MAN.
*/
           
UPDATE employees
  set job_id = 'ST_MAN'
WHERE employee_id = (SELECT employee_id 
                     FROM employees 
                     WHERE last_name = 'Beh');
                     
                     
                     
/* Verhindern Sie das L�schen von Mitarbeiter-Records in der Tabelle EMPLOYEES
 * w�hrend der Gesch�ftszeiten von 9:00 bis 18:00.
 */

CREATE OR REPLACE TRIGGER delete_emp_trg
BEFORE DELETE ON employees
DECLARE
  the_day VARCHAR2(3) := TO_CHAR(SYSDATE, 'DY');
  the_hour PLS_INTEGER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
BEGIN
   IF (the_hour BETWEEN 9 AND 18) AND (the_day NOT IN ('SAT','SUN')) THEN
     RAISE_APPLICATION_ERROR(-20150, 
      'Employee records cannot be deleted during the business hours of 9AM and 6PM');
   END IF;
END;
/

/* Versuchen Sie Mitarbeiter mit der Jobkennung SA_REP, die keiner Abteilung 
 * zugeordnet sind, zu l�schen. (Das sollte f�r den Mitarbeiter Grant mit
 * der ID 178 zutreffen.)
*/
DELETE FROM employees
  WHERE job_id = 'SA_REP'
  AND   department_id IS NULL;
