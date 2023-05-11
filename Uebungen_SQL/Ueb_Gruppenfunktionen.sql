-- Übung: Verwendung von Gruppenfunktionen

-- 1.	Zeigen Sie das höchste Gehalt, das niedrigste Gehalt, die Summe aller 
-- Gehälter und das Durchschnittsgehalt für alle Mitarbeiter an. 
-- Runden Sie das Ergebnis auf die nächste ganze Zahl.




-- 2.	Verändern Sie die vorherige Abfrage so, dass die Werte je Jobkennung 
-- berechnet und angezeigt werden. 




-- 3.	Zeigen Sie die Jobkennungen und die Anzahl der Mitarbeiter mit 
-- diesem Job an.




-- 4.	Zeigen Sie die Differenz zwischen dem niedrigsten und höchsten Gehalt 
-- je Abteilung an. Nennen Sie die Spalte „Differenz“.




-- 5.	Bestimmen Sie die Anzahl der Manager (ohne diese aufzulisten).


 

-- 6.	Zeigen Sie je Managerkennung das Gehalt des unterstellten Angestellten 
-- mit dem niedrigsten Gehalt an. 
-- Schließen Sie alle Angestellten aus, deren Manager nicht bekannt ist. 
-- Schließen Sie alle Gruppen aus, deren Mindestgehalt 6000 oder weniger 
-- beträgt.
-- Sortieren Sie die Ausgabe in absteigender Reihenfolge nach dem Gehalt.


  

-- 7.	Zeigen Sie die Anzahl der Mitarbeiter, deren Nachname mit dem 
-- Buchstaben “n“ endet.




-- 8. Zeigen Sie je Kalenderjahr an, wieviele Angestellte jeweils eingestellt 
-- wurden.  



    
-- 9. Schreiben Sie eine Abfrage, um eine Einstufung der Abteilungen auf Basis 
-- der Mitarbeiteranzahl in folgender Form anzuzeigen:
-- "Department_ID			Size". 
-- Dabei sollen Abteilungen mit weniger als 5 Mitarbeitern die Size "Little",
-- Abteilungen mit einer Mitarbeiterzahl zwischen 5 und 9 die Size "Medium"
-- Abteilungen mit einer Mitarbeiterzahl ab 10 die Size "Big" erhalten.


  
  
-- 10. Zeigen Sie für alle Mitarbeiter, deren Managerkennung kleiner 130 ist, 
-- Folgendes an:
-- Managerkennung,  Job-Kennung und Gesamtgehalt für jede Jobkennung, 
-- sortiert nach der Managerkennung.



  
-- 11. Erweitern Sie Aufgabe 10, so dass zusätzlich angezeigt wird:
-- Gesamtgehalt der Mitarbeiter unter dem jeweiligen Manager, 
-- Gesamtgehalt aller Mitarbeiter unter diesen Managern.


  

-- 12. Erweitern Sie Aufgabe 10 um eine Anzeige, die deutlich macht, 
-- ob die Nullwerte in den Spalten aus der Rollup-Auswertung resultieren 
-- oder auf Basis gespeicherter Nullwerte aus der Tabelle zustande kommen.

  
  
  
-- 13. Erweitern Sie die Abfrage aus Aufgabe 12, so dass zusätzlich angezeigt 
-- wird: Gesamtgehalt je Jobkennung unabhängig vom Manager.




-- 14. Modifizieren Sie die Abfrage aus Aufgabe 11, so dass nur folgende 
-- Gruppierungen angezeigt werden:
-- (Abteilungskennung, Managerkennung, Jobkennung),
-- (Abteilungskennung, Jobkennung),
-- (Managerkennung, Jobkennung)


  
  
  
-- 15. Erstellen Sie eine Abfrage, um folgende Angaben für alle Abteilungen 
-- anzuzeigen, deren Abteilungsnummer größer als 80 ist:
--  - Gesamtgehalt für jeden Job in der Abteilung
--  - Das Gesamtgehalt
--  - Das Gesamtgehalt für die Städte, in denen sich Abteilungen befinden
--  - Das Geamtgehalt für jeden Job, unabhängig von der Abteilung
--  - Das Gesamtgehalt für jede Abteilung, unabhängig von der Stadt
--  - Das Gesamtgehalt für die Abteilungen, unabhängig von Job-Bezeichnung
--    und Stadt



  
-- 16.  Erstellen Sie eine Abfrage, um folgende Gruppierungen anzuzeigen:
--  - Abteilungsnummer, Jobkennung
--  - Jobkennung, Managerkennung
--  wobei die Ausgabe das Maximal- und das Minimalgehalt nach Abteilung, 
--  Tätigkeit und Manager enthalten soll.

  
  

