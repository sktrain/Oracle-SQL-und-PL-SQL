-- Übungen zu Indizes

-- a) Um die Performanceunterschiede durch den Einsatz eines Index besser 
-- messen zu können, führen Sie bitte die folgenden Schritte durch:
CREATE TABLE big_emp AS SELECT * FROM employees;

-- ca. 8-mal durchführen ergibt ca. 50.000 Zeilen
INSERT INTO big_emp SELECT * FROM big_emp; 

COMMIT;

-- neue Spalte anhängen für Primary key
ALTER TABLE big_emp ADD (nr number);

-- eindeutige Spaltenwert vergeben
UPDATE big_emp SET nr=rownum; 

/* nicht unbedingt notwendig
Führen Sie nun unter SQL*Plus folgende Befehle aus:
SET TIMING ON
SET AUTOTRACE ON
Dies kann evtl. zu einem Fehler führen, wenn UTLXPLAN.SQL noch nicht gestartet wurde.
Dann als SYS bei ORACLE folgende Scripte starten:
@%oracle_home%\rdbms\admin\utlxplan.sql
@%oracle_home%\sqlplus\admin\plustrce.sql
grant plustrace to public;
*/

SELECT * FROM big_emp WHERE nr=8000;
-- ggf. DBBC und Shared Pool als SYS flushen!
-- Merken Sie sich bitte die Laufzeit.

-- Vergeben Sie nun einen Unique-Index auf die Spalte nr.
CREATE UNIQUE INDEX big_emp_nr_ind ON big_emp (nr);

SELECT * FROM big_emp WHERE nr=8000;
-- Vergleichen Sie die Laufzeit und den Ausführungsplan mit oben.

-- b) Warum werden die Abfragen bei der zweiten Ausführung meist schneller?


-- Löschen Sie die Tabelle BIG_EMP bitte wieder.
DROP TABLE big_emp;
