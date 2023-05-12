/* 
1) Examine the following definitions. 
*/

CREATE OR REPLACE TYPE typ_item AS OBJECT --create object
(prodid NUMBER(5),
price NUMBER(7,2) )
/
CREATE TYPE typ_item_nst -- define nested table type
AS TABLE OF typ_item
/
CREATE TABLE pOrder ( -- create database table
ordid NUMBER(5),
supplier NUMBER(5),
requester NUMBER(4),
ordered DATE,
items typ_item_nst)
NESTED TABLE items STORE AS item_stor_tab
/

/*
2) The following code generates an error. 
*/
BEGIN
-- Insert an order
INSERT INTO pOrder
(ordid, supplier, requester, ordered, items)
VALUES (1000, 12345, 9876, SYSDATE, NULL);
-- insert the items for the order created
INSERT INTO TABLE (SELECT items
FROM pOrder
WHERE ordid = 1000)
VALUES(typ_item(99, 129.00));
END;
/

/*
a) Why does the error occur?

b) How can you fix the error?

*/


/*
3) Examine the following code. This code produces an error. Which line causes the
error, and how do you fix it?
*/
DECLARE
TYPE credit_card_typ
IS VARRAY(100) OF VARCHAR2(30);
v_mc credit_card_typ := credit_card_typ();
v_visa credit_card_typ := credit_card_typ();
v_am credit_card_typ;
v_disc credit_card_typ := credit_card_typ();
v_dc credit_card_typ := credit_card_typ();
BEGIN
v_mc.EXTEND;
v_visa.EXTEND;
v_am.EXTEND;
v_disc.EXTEND;
v_dc.EXTEND;
END;
/



/*
4) In the following practice exercises, you implement a nested table column in the
CUSTOMERS table and write PL/SQL code to manipulate the nested table.
*/
-- first the sample table:
CREATE TABLE CUSTOMER 
  ("CUSTOMER_ID" NUMBER(10,0) NOT NULL, 
	 "FIRSTNAME" VARCHAR2(255 BYTE), 
	 "LASTNAME" VARCHAR2(255 BYTE), 
	 PRIMARY KEY ("CUSTOMER_ID"));

/* insert sample data, use table "employees": */
INSERT INTO CUSTOMER
  SELECT employee_id, first_name, last_name from employees;

/*  
4) Create a nested table to hold credit card information.
a) Create an object type called typ_cr_card. It should have the following
specification:
card_type VARCHAR2(25)
card_num NUMBER
*/


/*
b) Create a nested table type called typ_cr_card_nst that is a table of
typ_cr_card.
*/


/*
c) Add a column called credit_cards to the CUSTOMERS table. Make this
column a nested table of type typ_cr_card_nst. You can use the following
syntax:
*/
ALTER TABLE customer ADD
(credit_cards typ_cr_card_nst)
NESTED TABLE credit_cards STORE AS credit_store_tab;


/*
5) Create a PL/SQL package that manipulates the credit_cards column in the
CUSTOMERS table.
a. The package specification and part of the package body.
*/


CREATE OR REPLACE PACKAGE credit_card_pkg
IS
PROCEDURE update_card_info
(p_cust_id NUMBER, p_card_type VARCHAR2, p_card_no
VARCHAR2);
PROCEDURE display_card_info
(p_cust_id NUMBER);
END credit_card_pkg; -- package spec
/

/*
b. Complete the code so that the package:
- Inserts credit card information (the credit card name and number for a specific
customer)
- Displays credit card information in an unnested format
*/
/*
CREATE OR REPLACE PACKAGE BODY credit_card_pkg
IS
PROCEDURE update_card_info
(p_cust_id NUMBER, p_card_type VARCHAR2, p_card_no
VARCHAR2)
IS
v_card_info typ_cr_card_nst;
i INTEGER;
BEGIN
SELECT credit_cards
INTO v_card_info
FROM customers
WHERE customer_id = p_cust_id;
IF v_card_info.EXISTS(1) THEN
-- cards exist, add more
-- fill in code here
ELSE -- no cards for this customer, construct one
-- fill in code here
END IF;
END update_card_info;
PROCEDURE display_card_info
(p_cust_id NUMBER)
IS
v_card_info typ_cr_card_nst;
i INTEGER;
BEGIN
SELECT credit_cards
INTO v_card_info
FROM customers
WHERE customer_id = p_cust_id;
-- fill in code here to display the nested table
-- contents
END display_card_info;
END credit_card_pkg; -- package body
/
*/



/*
6) Test your package with the following statements and compare the output:
*/
EXECUTE credit_card_pkg.display_card_info(120);
-- Customer has no credit cards.

EXECUTE credit_card_pkg.update_card_info(120, 'Visa', 11111111);

SELECT credit_cards
FROM customer
WHERE customer_id = 120;

EXECUTE credit_card_pkg.display_card_info(120);

EXECUTE credit_card_pkg.update_card_info(120, 'MC', 2323232323);
EXECUTE credit_card_pkg.update_card_info (120, 'DC', 4444444);

EXECUTE credit_card_pkg.display_card_info(120);


/*
7) Write a SELECT statement against the credit_cards column to unnest the data.
Use the TABLE expression.

For example, if the SELECT statement returns:
SELECT credit_cards
FROM customers
WHERE customer_id = 120;
CREDIT_CARDS(CARD_TYPE, CARD_NUM)
--------------------------------------------------------
TYP_CR_CARD_NST(TYP_CR_CARD('Visa', 11111111),
TYP_CR_CARD('MC', 2323232323), TYP_CR_CARD('DC', 4444444))
then rewrite it using the TABLE expression so that the results look like this:
-- Use the table expression so that the result is:
CUSTOMER_ID CUST_LAST_NAME CARD_TYPE CARD_NUM
----------- --------------- ------------- -----------
120 Higgins Visa 11111111
120 Higgins MC 2323232323
120 Higgins DC 4444444
*/

