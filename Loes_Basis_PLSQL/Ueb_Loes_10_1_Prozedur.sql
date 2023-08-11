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
  COMMIT;
END;
/

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
CREATE OR REPLACE PROCEDURE del_job ( jobid  jobs.job_id%TYPE)
IS
BEGIN
  DELETE FROM jobs WHERE job_id = jobid;
  IF SQL%NOTFOUND THEN 
    RAISE_APPLICATION_ERROR(-20203, 'No job deleted');
  END IF;
  COMMIT;
END;

/* Testen Sie die Prozedur anhand der Jobkennung 'SQL_PRG'.
 * Was passiert, wenn Sie eine nicht vorhandene Jobkennung verwenden?
 */
CALL del_job('SQL_PRG');
