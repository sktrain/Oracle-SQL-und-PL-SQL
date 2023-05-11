-- �bungen zu Indizes

-- a) Um die Performanceunterschiede durch den Einsatz eines Index besser 
-- messen zu k�nnen, f�hren Sie bitte die folgenden Schritte durch:
CREATE TABLE big_emp AS SELECT * FROM employees;

-- ca. 8-mal durchf�hren ergibt ca. 50.000 Zeilen
INSERT INTO big_emp SELECT * FROM big_emp; 

COMMIT;

-- neue Spalte anh�ngen f�r Primary key
ALTER TABLE big_emp ADD (nr number);

-- eindeutige Spaltenwert vergeben
UPDATE big_emp SET nr=rownum; 

/* nicht unbedingt notwendig
F�hren Sie nun unter SQL*Plus folgende Befehle aus:
SET TIMING ON
SET AUTOTRACE ON
? kann evtl. zu einem Fehler f�hren, wenn UTLXPLAN.SQL noch nicht gestartet wurde.
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
-- Vergleichen Sie die Laufzeit und den Ausf�hrungsplan mit oben.

-- b) Warum werden die Abfragen bei der zweiten Ausf�hrung meist schneller?


-- L�schen Sie die Tabelle BIG_EMP bitte wieder.
DROP TABLE big_emp;
