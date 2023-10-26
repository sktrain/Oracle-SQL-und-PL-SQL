 /* 
 The PIVOT operator takes data in separate rows, aggregates it and converts it 
 into columns. 
 To see the PIVOT operator in action we need to create a test table.
 */
 
 create table pivot_test (
  id            number,
  customer_id   number,
  product_code  varchar2(5),
  quantity      number
);

insert into pivot_test values (1, 1, 'A', 10);
insert into pivot_test values (2, 1, 'B', 20);
insert into pivot_test values (3, 1, 'C', 30);
insert into pivot_test values (4, 2, 'A', 40);
insert into pivot_test values (5, 2, 'C', 50);
insert into pivot_test values (6, 3, 'A', 60);
insert into pivot_test values (7, 3, 'B', 70);
insert into pivot_test values (8, 3, 'C', 80);
insert into pivot_test values (9, 3, 'D', 90);
insert into pivot_test values (10, 4, 'A', 100);
commit;


/* Aufgabe: wir wollen folgendes Ergebnis:
   Eine Zeile mit den aufsummierten Quantitys
   
A_SUM_QUANTITY B_SUM_QUANTITY C_SUM_QUANTITY
-------------- -------------- --------------
           210             90            160
           
*/



        
/* Aufgabe: jetzt pro Customer
   
CUSTOMER_ID A_SUM_QUANTITY B_SUM_QUANTITY C_SUM_QUANTITY
----------- -------------- -------------- --------------
          1             10             20             30
          2             40                            50
          3             60             70             80
          4            100
           
*/





/* Aufgabe: jetzt mal mit Hilfe von XML und ANY für alle Products im
   XML-Format (Dadurch haben wir dynamisch alle Products pro Customer)
   
product_code_XML
----------------------------------------------------------------------------------------------------
<PivotSet><item><column name = "PRODUCT_CODE">A</column><column name = "SUM_QUANTITY">210</column></
item><item><column name = "PRODUCT_CODE">B</column><column name = "SUM_QUANTITY">90</column></item><
item><column name = "PRODUCT_CODE">C</column><column name = "SUM_QUANTITY">160</column></item><item>
<column name = "PRODUCT_CODE">D</column><column name = "SUM_QUANTITY">90</column></item></PivotSet>
           
*/




/* Für den UNPIVOT nutzen wir folgende Tabelle */

create table unpivot_test (
  id              number,
  customer_id     number,
  product_code_a  number,
  product_code_b  number,
  product_code_c  number,
  product_code_d  number
);

insert into unpivot_test values (1, 101, 10, 20, 30, null);
insert into unpivot_test values (2, 102, 40, null, 50, null);
insert into unpivot_test values (3, 103, 60, 70, 80, 90);
insert into unpivot_test values (4, 104, 100, null, null, null);
commit;


/* Aufgabe: Mit Hilfe des UNPIVOT-Operator wollen wir folgendes Ergebnis:

        ID CUSTOMER_ID P   QUANTITY
---------- ----------- - ----------
         1         101 A         10
         1         101 B         20
         1         101 C         30
         2         102 A         40
         2         102 C         50
         3         103 A         60
         3         103 B         70
         3         103 C         80
         3         103 D         90
         4         104 A        100

*/

              

/* Aufgabe: Zusätzlich sollen Nullwerte in den Aggregationsspalten des 
   Ausgangstabelle im Ergebnis auch berücksichtigt werden
*/


