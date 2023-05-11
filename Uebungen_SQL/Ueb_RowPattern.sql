-- Uebungen: Row Pattern Matching
-- Wer möchte, kann auch mal eine Lösung ohne Row Pattern Matching erstellen.

/* Gibt es bei den Coronazahlen nach Geschlecht (CorZahlenFuldaMitGeschlecht)
je Geschlecht Phasen mit gleichbleibenden Fallzahlen und wie lange war der
Zeitraum.
Zeigen Sie je Geschlecht den Zeitraum (Start, Ende) und die Fallzahl an.
*/


    
/*
Wir suchen bei den Angestellten bzgl. der Reihenfolge ihres Einstellungsdatums
nach den Fällen, bei denen 3-mal in Folge das Gehalt niedriger als das 
das Vorgängergehalt ist.
Ausgegeben soll jeweils eine Zeile per getroffenem Muster mit der Id, Nachnamen, 
Einstellungsdatum, Gehalt der Startzeile und mit der Id, Nachnamen, 
Einstellungsdatum und Gehalt der Endzeile.
*/





/* Zeigen Sie die Mitarbeiter an, die mindestens zweimal den Job bzw.
die Abteilung gewechselt haben (mind. 2 Einträge in der "Job_History").
Listen Sie Nachnamen, erste Jobkennung, erste Abteilung sowie aktuelle 
Jobkennung und Abteilung auf.
(Geht auch einfacher ohne Row Pattern)
*/







/* In einer Tabelle mit fortlaufenden Zahlen, die aber Lücken enthalten, suchen
wir nach den Abschnitten ohne Lücken und wollen je Abschnitt eine Zeile haben.
Die Zeile soll den Start- und Endwert zeigen.
Die folgende CREATE TABLE Anweisung erzeugt eine simple Ausgangstabelle, die
anschließend mit fortlaufenden Zahlen inklusive Lücken gefüllt wird.
*/
        
CREATE TABLE T_GAPS (id Number(3,0));

DECLARE 
  n NUMBER :=1;
BEGIN
  while (n < 200)
  loop
    INSERT INTO T_GAPS VALUES(n);
    IF mod(n, 10) = 0
        THEN n := n + 4;
        ELSE n := n + 1;
    END IF;
  END LOOP;
END;

    
    


/* Hierarchical child count:
Ausgangspunkt ist die Employees-Tabelle. Wir wollen zu jedem Angestellten
wissen, wie viele andere sind ihm direkt und indirekt unterstellt (auch die
tieferen Ebenen).
Folgender Query liefert die gesamte Hierarchie (depth-first) beginnend bei 
dem obersten Chef (siehe auch hierarchische Queries) und bildet die Basis 
zur Ermittlung der Zahlen.
Zur besseren Nachvollziehbarkeit kann man sich ja erstmal alle Zeilen je 
getroffenen Muster anzeigen lassen.
*/
select level as lvl, employee_id, last_name, manager_id, rownum as rn
        from employees
       start with manager_id is null
       connect by manager_id = prior employee_id
       order siblings by employee_id;

/* Lösungsansatz:
Wenn wir nach der Hierarchie (depth-first)ordnen, sind die folgenden 
Angestellten mit einem höheren Level die Unterstellten.
Wenn wir einen Angestellten erreichen mit einem gleichen oder niedrigeren
Level ist die Suche beendet. Wir müssen die getroffenen Zeilen nur zählen.
Allerdings müssen wir mit dem nächsten Angestellten weiter machen und nicht mit 
der Zeile hinter unserem Treffer, wir wollen ja alle Angestellten 
berücksichtigen.
*/

