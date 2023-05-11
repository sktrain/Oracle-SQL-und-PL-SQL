-- Übungen/Lösungen zu DML

-- 1. Erzeugen Sie mit Hilfe der folgenden Anweisungen die Tabelle 
-- "MY EMPLOYEE", die im Folgenden verwendet wird:

CREATE TABLE MY_EMPLOYEE
  ( id NUMBER(4) CONSTRAINT my_employee_id_nn NOT NULL, 
    lastname VARCHAR2(25),
    firstname VARCHAR2(25),
    userid VARCHAR2(8),
    salary NUMBER(9,2));
    
 
    
-- 2. Vergewissern Sie sich, dass die Tabelle angelegt wurde. 
Das kann man auch mittels des folgenden (Nicht-SQL-)Befehls tun:

DESCRIBE MY_EMPLOYEE;



-- 3. Fügen sie die erste Zeile in die Tabelle MY_EMPLOYEE von den folgenden 
-- Beispielsdaten ein, ohne die Spalten  beim INSERT aufzulisten.
-- ID   LAST_NAME   FIRST NAME    USERID    SALARY
-- 1    Patel       Ralph         rpatel      895
-- 2    Dancs       Betty         bdancs      860
-- 3    Muster3     Otto          mot3        1100
-- 4    Muster4     Otto          mot4        750


INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);


-- 4. Füllen Sie die MY EMPLOYEE Tabelle mit der 2. und 3. Zeile der 
-- Beispielsdaten, diemal mit expliziter Nennung der Spalten in der 
-- INSERT-Klausel.

INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);
INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (3, 'Muster3', 'Otto', 'mot3', 1100);


-- 5. Schreiben Sie die Änderungen fest.

COMMIT;


-- 6. Ändern Sie den Namen des Angestellten 3 zu Drexler.

UPDATE	my_employee
SET	lastname = 'Drexler'
WHERE	id = 3;



-- 7. Ändern Sie das Gehalt für alle Angestellten, die weniger als 900 
-- verdienen, auf 1000.

UPDATE	my_employee
SET	salary = 1000
WHERE	salary < 900;



-- 8. Löschen Sie Betty Dancs aus der Tabelle MY_EMPLOYEE.
DELETE
FROM my_employee
WHERE lastname = 'Dancs';



-- 9. Schreiben Sie alle anstehenden Änderungen fest.

COMMIT;




-- 10. Füllen Sie die MY_EMPLOYEE Tabelle mit der 4. Zeile der Beispielsdaten.

INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (4, 'Muster4', 'Otto', 'mot4', 750);




-- 11. Setzen Sie einen Zwischenpunkt (Savepoint) in der laufenden Transaktion. 

SAVEPOINT step_11;



-- 12. Leeren Sie die gesamte Tabelle.

DELETE
FROM my_employee;



-- 13. Machen Sie das Löschen rückgängig ohne die vorherige INSERT-Anweisung 
-- rückgängig zu machen. 

ROLLBACK TO step_11;



-- 14. Schreiben Sie die Daten endgültig fest.

COMMIT;
