-- 1. Exercise 5.14
	--drop existing tables (in order of foreign key registration)
	DROP TABLE SHIPMENT;
	DROP TABLE WAREHOUSE;
	DROP TABLE ORDER_ITEM;
	DROP TABLE ITEM;
	DROP TABLE AORDER;
	DROP TABLE CUSTOMER;

	-- insert table data
	CREATE TABLE Customer (
	CUSTNUM INTEGER, 
	CUSTNAME VARCHAR(45), 
	CITY VARCHAR(45),
	PRIMARY KEY (CUSTNUM)
	);

	CREATE TABLE AOrder ( --Order is a reserved word in plsql
	ORDERNUM INTEGER, 
	ORDERDATE DATE, 
	CUSTNUM INTEGER,
	ORDERAMT INTEGER,
	PRIMARY KEY (ORDERNUM),
	FOREIGN KEY (CUSTNUM) REFERENCES Customer(CUSTNUM) ON DELETE CASCADE,
	CHECK (ORDERAMT > 0), -- Can not have a negative or zero order amt
	CHECK (ORDERDATE IS NOT NULL) -- an order needs to 	 have an orderdate
	);
	
	CREATE TABLE ITEM (
	ITEMNUM INTEGER, 
	ITEMNAME VARCHAR(45),
	UNIT_PRICE FLOAT,
	PRIMARY KEY (ITEMNUM)
	);
	
	CREATE TABLE Order_Item (
	ORDERNUM INTEGER, 
	ITEMNUM INTEGER, 
	QTY INTEGER,	
	FOREIGN KEY (ORDERNUM) REFERENCES AOrder(ORDERNUM) ON DELETE CASCADE,
	FOREIGN KEY (ITEMNUM) REFERENCES ITEM(ITEMNUM) ON DELETE SET NULL --If an different item is requested, the order_item table needs to be flexable
	);
	
	CREATE TABLE WAREHOUSE (
	WAREHOUSENUM INTEGER,
	CITY VARCHAR(45),
	PRIMARY KEY (WAREHOUSENUM)
	);
	
	CREATE TABLE SHIPMENT (
	SHIPMENTID INTEGER,
	ORDERNUM INTEGER, 
	WAREHOUSENUM INTEGER,
	SHIP_DATE DATE,
	PRIMARY KEY (SHIPMENTID),
	FOREIGN KEY (ORDERNUM) REFERENCES AORDER(ORDERNUM) ON DELETE CASCADE,
	FOREIGN KEY (WAREHOUSENUM) REFERENCES WAREHOUSE(WAREHOUSENUM) ON DELETE CASCADE,
	CHECK (SHIP_DATE IS NOT NULL) -- Must have a ship date logging the Shipment
	--CHECK (SHIP_DATE >= ORDER(ORDERDATE)) --A shipment cannot go out until the orders have been placed
	);
	
	
-- Load sample data
INSERT INTO CUSTOMER VALUES (1,'D Mike', 'Grand Rapids');
INSERT INTO CUSTOMER VALUES (2, 'B Mike', 'Chicago');
INSERT INTO CUSTOMER VALUES (3, 'C Mike', 'Los Angeles');
INSERT INTO CUSTOMER VALUES (4, 'A Mike', 'New York');
INSERT INTO CUSTOMER VALUES (5, 'Z Mike', 'Boulder');

INSERT INTO AORDER VALUES (1, to_date('01-Feb-2017','dd-MON-yyyy'), 1, 10);
INSERT INTO AORDER VALUES (2, to_date('02-Feb-2017','dd-MON-yyyy'), 1, 15);
INSERT INTO AORDER VALUES (3, to_date('03-Feb-2017','dd-MON-yyyy'), 2, 5);
INSERT INTO AORDER VALUES (4, to_date('04-Feb-2017','dd-MON-yyyy'), 2, 10);
INSERT INTO AORDER VALUES (5, to_date('05-Feb-2017','dd-MON-yyyy'), 3, 10);
INSERT INTO AORDER VALUES (6, to_date('05-Feb-2017','dd-MON-yyyy'), 4, 10);
INSERT INTO AORDER VALUES (7, to_date('05-Feb-2017','dd-MON-yyyy'), 4, 10);

INSERT INTO ITEM VALUES (1, 'Blue Jeans', 89.99);
INSERT INTO ITEM VALUES (2, 'Red Shirt', 34.99);
INSERT INTO ITEM VALUES (3, 'Pink Trousers', 30.50);
INSERT INTO ITEM VALUES (4, 'Black Suspenders', 14.99);
INSERT INTO ITEM VALUES (5, 'Silver Watch', 199.99);

INSERT INTO ORDER_ITEM VALUES (1, 1, 5);
INSERT INTO ORDER_ITEM VALUES (2, 2, 8);
INSERT INTO ORDER_ITEM VALUES (3, 3, 2);
INSERT INTO ORDER_ITEM VALUES (4, 4, 20);
INSERT INTO ORDER_ITEM VALUES (5, 5, 4);
INSERT INTO ORDER_ITEM VALUES (6, 3, 10);
INSERT INTO ORDER_ITEM VALUES (7, 1, 1);


INSERT INTO WAREHOUSE VALUES (1, 'Brampton');
INSERT INTO WAREHOUSE VALUES (2, 'Fishkill');
INSERT INTO WAREHOUSE VALUES (3, 'Birmingham');
INSERT INTO WAREHOUSE VALUES (4, 'Lexington');
INSERT INTO WAREHOUSE VALUES (5, 'Atlanta');

INSERT INTO SHIPMENT VALUES (1, 1, 1, to_date('06-Feb-2017','dd-MON-yyyy'));
INSERT INTO SHIPMENT VALUES (2, 2, 1, to_date('06-Feb-2017','dd-MON-yyyy'));
INSERT INTO SHIPMENT VALUES (3, 3, 2, to_date('07-Feb-2017','dd-MON-yyyy'));
INSERT INTO SHIPMENT VALUES (4, 4, 3, to_date('08-Feb-2017','dd-MON-yyyy'));
INSERT INTO SHIPMENT VALUES (5, 5, 4, to_date('09-Feb-2017','dd-MON-yyyy'));

	
	
-- 2. Exercise 5.20.a & c
	-- Consider only this modified version of the text exercise - What recommendations would you have for CIT if they were considering replacing surrogate student ID numbers with a more natural key? Either suggest a new form of key or try to convince them that surrogate keys are acceptable.
	
-- 3. Write the SQL commands to retrieve the following from the customer-order database you built above.

	-- all the order dates and amounts for orders made by a customer with a particular name (one that exists in your database), ordered chronologically by date
	
	-- all the customer ID numbers for customers who have at least one order in the database
	
	-- the customer IDs and names of the people who have ordered an item with a particular name (one that exists in your database)