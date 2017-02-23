drop table PartOrder;
drop table Orders;
drop table Part;
drop table Customer;
drop table Employee;

create table Employee(
	empnum integer PRIMARY KEY,
	firstname varchar(15),
	lastname varchar(15),
	zipcode char(5)
	);

create table Customer(
	custnum integer PRIMARY KEY,
	firstname varchar(15),
	lastname varchar(15),
	zipcode char(5)
	);
	
create table Part(
	partnum integer PRIMARY KEY,
	partame varchar(15),
	price float CHECK (price >= 0.00),
	stockqty integer
	);	

create table Orders(
	orderNum integer PRIMARY KEY,
	empnum integer,
	custnum integer,
	recieptDate date,
	expect_ship_date date,
	actual_ship_date date,
	FOREIGN KEY (empnum) REFERENCES Employee(empnum),
	FOREIGN KEY (custnum) REFERENCES Customer(custnum)
	);

create table PartOrder(	
	partnum integer,
	ordernum integer,
	qty integer,
	FOREIGN KEY (partnum) REFERENCES Part(partnum),
	FOREIGN KEY (ordernum) REFERENCES Orders(ordernum),
	PRIMARY KEY (partnum,ordernum)
	);
	
INSERT INTO Employee VALUES (0,'Bob', 'Dylan','49506');
INSERT INTO Employee VALUES (1, 'Bob', 'Dylan II', '49506');

INSERT INTO Customer VALUES (0,'Lance', 'Armstrong','60187');
INSERT INTO Customer VALUES (1, 'Lance', 'Armstrong II', '60187');

INSERT INTO PART VALUES (0, 'hammer', 24.99, 15);
INSERT INTO PART VALUES (1, 'screwdriver', 14.99, 8);
INSERT INTO PART VALUES (2, 'box of nails', 4.99, 50);

INSERT INTO ORDERS VALUES (0,0,0, to_date('17-Feb-2017','DD-MON-YYYY'), to_date('24-Feb-2017','DD-MON-YYYY'), to_date('22-Feb-2017','DD-MON-YYYY'));
INSERT INTO ORDERS VALUES (1,1,0, to_date('17-Feb-2017','DD-MON-YYYY'), to_date('24-Feb-2017','DD-MON-YYYY'), to_date('22-Feb-2017','DD-MON-YYYY'));

INSERT INTO PartOrder VALUES(0,0,1);
INSERT INTO PartOrder VALUES(1,0,1);
INSERT INTO PartOrder VALUES(2,0,1);

INSERT INTO PartOrder VALUES(1,1,1);