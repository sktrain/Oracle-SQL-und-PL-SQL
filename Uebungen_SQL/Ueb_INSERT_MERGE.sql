/* Erstellen Sie mittels Unterabfrage auf die HR.EMPLOYEES-Tabelle
3 Tabellen "emp_salary", "emp_low_salary", "emp_high_salary" 
mit jeweils 3 Spalten, wobei Sie folgende Spalten
"employee_id, last_name, salary" aus der HR.EMPLOYEES-Tabelle
übernehmen.
Versuchen Sie keine Datensätze mit zu übernehmen. */


         
/* Fügen Sie alle Datensätze aus der EMPLOYEES-Tabelle
der Abteilung 50 in die 3 neu erstellten Tabellen */



/* Fügen Sie alle Datensätze aus der EMPLOYEES-Tabelle
der Abteilung 100 in die 3 neu erstellten Tabellen,
wobei Zeilen mit einem Gehalt < 5000 in die emp_low_salary
- Tabelle, Zeilen mit einem Gehalt < 10000 
in die emp_salary-Tabelle und Zeilen mit einem höheren 
Gehalt in die emp_high_salary-Tabelle wandern sollen. */



      
/* Fügen Sie alle Datensätze aus der EMPLOYEES-Tabelle
der Abteilung 90 in die 3 neu erstellten Tabellen,
wobei Zeilen mit einem Gehalt < 5000 nur in die emp_low_salary
- Tabelle, Zeilen mit einem Gehalt >= 5000 und < 10000 
in die emp_salary-Tabelle und Zeilen mit einem höheren 
Gehalt in die emp_high_salary-Tabelle wandern sollen. */
      


/* Mischen Sie in die Zieltabelle emp_salary alle Datensätze
der EMPLOYEES-Tabelle, wobei auf Basis der employee_id ein
UPDATE in der Zieltabelle erfolgt, der den Nachnamen auf 
'Mustermann' setzt, und ansonsten die Zeilen in die Zieltabelle
übernimmt. */


  
    
