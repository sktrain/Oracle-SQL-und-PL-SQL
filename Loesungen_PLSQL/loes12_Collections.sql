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
The error “ORA-22908: reference to NULL table value” results from setting the
table columns to NULL.
b) How can you fix the error?
You should always use a nested table’s default constructor to initialize it:
*/
TRUNCATE TABLE pOrder;
-- A better approach is to avoid setting the table
-- column to NULL, and instead, use a nested table's
-- default constructor to initialize
BEGIN
-- Insert an order
INSERT INTO pOrder
(ordid, supplier, requester, ordered, items)
VALUES (1000, 12345, 9876, SYSDATE,
typ_item_nst(typ_item(99, 129.00)));
END;
/
-- However, if the nested table is set to NULL, you can
-- use an UPDATE statement to set its value.
-- This is another alternative. Run either the block above,
-- or the block below to insert an order.
BEGIN
-- Insert an order
INSERT INTO pOrder
(ordid, supplier, requester, ordered, items)
VALUES (1000, 12345, 9876, SYSDATE, null);
-- Once the nested table is set to null, use the update
-- update statement
UPDATE pOrder
SET items = typ_item_nst(typ_item(99, 129.00))
WHERE ordid = 1000;
END;
/

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
This causes an ORA-06531: Reference to uninitialized collection. To fix it,
initialize the v_am variable by using the same technique as the others:
*/
DECLARE
TYPE credit_card_typ
IS VARRAY(100) OF VARCHAR2(30);
v_mc credit_card_typ := credit_card_typ();
v_visa credit_card_typ := credit_card_typ();
v_am credit_card_typ := credit_card_typ();
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
CREATE OR REPLACE TYPE typ_cr_card AS OBJECT --create object
(card_type VARCHAR2(25),
card_num NUMBER);
/

/*
b) Create a nested table type called typ_cr_card_nst that is a table of
typ_cr_card.
*/
CREATE OR REPLACE TYPE typ_cr_card_nst -- define nested table type
AS TABLE OF typ_cr_card;
/

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

CREATE OR REPLACE PACKAGE BODY credit_card_pkg
IS
PROCEDURE update_card_info(p_cust_id NUMBER, 
                           p_card_type VARCHAR2, 
                           p_card_no VARCHAR2)
IS
  v_card_info typ_cr_card_nst;
  i INTEGER;
BEGIN
  SELECT credit_cards INTO v_card_info
    FROM customer
    WHERE customer_id = p_cust_id;
  IF v_card_info.EXISTS(1) THEN -- cards exist, add more
    i := v_card_info.LAST;
    v_card_info.EXTEND(1);
    v_card_info(i+1) := typ_cr_card(p_card_type, p_card_no);
    UPDATE customer
      SET credit_cards = v_card_info
      WHERE customer_id = p_cust_id;
  ELSE -- no cards for this customer yet, construct one
    UPDATE customer
      SET credit_cards = typ_cr_card_nst(typ_cr_card(p_card_type, p_card_no))
      WHERE customer_id = p_cust_id;
  END IF;
END update_card_info;

PROCEDURE display_card_info(p_cust_id NUMBER)
IS
  v_card_info typ_cr_card_nst;
  i INTEGER;
BEGIN
  SELECT credit_cards INTO v_card_info
    FROM customer
    WHERE customer_id = p_cust_id;
  IF v_card_info.EXISTS(1) THEN
    FOR idx IN v_card_info.FIRST..v_card_info.LAST LOOP
        DBMS_OUTPUT.PUT('Card Type: ' ||
        v_card_info(idx).card_type || ' ');
        DBMS_OUTPUT.PUT_LINE('/ Card No: ' ||
        v_card_info(idx).card_num );
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Customer has no credit cards.');
  END IF;
END display_card_info;
END credit_card_pkg; -- package body

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

SELECT c1.customer_id, c1.lastname, c2.*
FROM customer c1, TABLE(c1.credit_cards) c2
WHERE customer_id = 120;