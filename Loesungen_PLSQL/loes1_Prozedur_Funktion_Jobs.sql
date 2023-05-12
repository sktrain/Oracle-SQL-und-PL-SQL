/* Erstellen Sie eine Prozedur Add_Job, um eine neue Berufsbezeichnung 
 * in die Jobs-Tabelle einzufügen. Geben Sie die Jobkennung  und die 
 * Berufsbezeichnung mit Hilfe von 2 Parametern an.
 */
CREATE OR REPLACE PROCEDURE add_job ( jobid  jobs.job_id%TYPE,
                                       jobtitle jobs.job_title%TYPE )
  IS
  BEGIN
    INSERT INTO jobs (job_id, job_title)
      VALUES (jobid, jobtitle);
  END; 


/* Fügen Sie mit Hilfe der Prozedur ( 'SQL_PRG', 'PL/SQL Programmer' ) ein.
 */

CALL ADD_JOB('SQL_PRG', 'PL/SQL Programmer');

-- zum Test
SELECT * FROM jobs WHERE job_id = 'SQL_PRG';






/* Erstellen Sie eine Prozedur Del_Job, um einen Beruf aus der
 * Jobs-Tabelle zu löschen. Geben Sie die Jobkennung dazu als Parameter an.
 * Nehmen Sie die Exceptionbehandlung vor, falls kein Beruf gelöscht wurde,
 * indem Sie eine Applikationsfehler liefern.
 */
CREATE OR REPLACE PROCEDURE del_job (jobid  jobs.job_id%TYPE)
  IS
  BEGIN
    DELETE FROM jobs WHERE job_id = jobid;
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20203, 'No job deleted');
    END IF;
  END;


/* Testen Sie die Prozedur anhand der Jobkennung 'SQL_PRG'.
 * Was passiert, wenn Sie eine nicht vorhandene Jobkennung verwenden?
 */
CALL del_job('SQL_PRG');

-- 2: Aufruf provoziert Fehler, da der Job nicht mehr vorhanden.
CALL del_job('SQL_PRG');




/* Erstellen Sie eine Prozedur upd_job um eine Eintrag in der Tabelle JOBS 
 * zu aktualisieren. Die Prozedur soll neue Werte für die Gehaltsgrenzen bei 
 * gegebener Jobkennung setzen und die 3 Parameter, Jobkennung und 
 * Gehaltsgrenzen, als Eingabeparameter erwarten. Die neuen Gehaltsgrenzen 
 * sollen aber innerhalb der bisherigen Grenzwerte aller Jobkennungen liegen.
 * Bei einem Fehlschlag soll ein Applikationsfehler geliefert werden.
 */
CREATE OR REPLACE PROCEDURE upd_job( jobid jobs.job_id%TYPE, minsal jobs.min_salary%TYPE,
                      maxsal jobs.max_salary%TYPE )
  IS
    act_minsal jobs.min_salary%TYPE;
    act_maxsal jobs.max_salary%TYPE;
  BEGIN
    SELECT min(min_salary) INTO act_minsal FROM jobs;
    SELECT max(max_salary) INTO act_maxsal FROM jobs;
    IF minsal >= act_minsal AND maxsal <= act_maxsal  
      THEN
        UPDATE jobs
          SET    min_salary = minsal, max_salary = maxsal
          WHERE  job_id = jobid;
        IF SQL%NOTFOUND THEN
          RAISE_APPLICATION_ERROR(-20204, 'Job not existent');
        END IF;
      ELSE
        RAISE_APPLICATION_ERROR(-20205, 'out of range');
    END IF;
  END;


/* Testen Sie die Prozedur anhand der Jobkennung 'SQL_PRG' und anhand einer 
 * nicht vorhandenen Jobkennung, sowie verschiedener Grenzwerte.
 */
EXEC upd_job( 'SQL_PRG', 1000, 4000 );

-- zum Test
SELECT * FROM jobs WHERE job_id = 'SQL_PRG';




/* Erstellen Sie eine Funktion get_jobtitle, die zu einer Jobkennung als
 * Eingabe den zugehörigen Jobtitel zurückliefert.
 * Testen Sie anschließend die Funktion mit 'ST_CLERK'.
 */
CREATE OR REPLACE FUNCTION get_jobtitle (jobid jobs.job_id%TYPE)
 RETURN jobs.job_title%TYPE 
IS
  title jobs.job_title%TYPE;
BEGIN
  SELECT job_title INTO title
    FROM jobs WHERE job_id = jobid;
  RETURN title;
END; 
/

/* Test via SELECT gegen DUAL */
SELECT get_jobtitle('ST_CLERK') FROM dual;

/* Test via BIND-Variable */
VARIABLE title VARCHAR2(35);
EXECUTE :title := get_jobtitle ('ST_CLERK');
PRINT title;







