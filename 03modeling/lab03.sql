-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden

drop table Person-Household;
drop table Person;
drop table Household;

create table Household(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	mentorid integer,
	householdid integer,
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	FOREIGN KEY (mentorid) REFERENCES Person(id),
	FOREIGN KEY (householdid) REFERENCES HouseHold(id)
	);

Create table Person-Household (
	personid integer,
	householdid integer,
	role varchar(15) CHECK (role in ('father', 'mother', 'child')),
	PRIMARY KEY (personid, householdid),
	FOREIGN KEY (householdid) REFERENCES Household(id),
	FOREIGN KEY (personid) REFERENCES Person(id)
	);

INSERT INTO Household VALUES (0,'5555 Oxford Dr. SE','Grand Rapids','MI','49506','616-555-5555');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m');

INSERT INTO Person-Household VALUES (0,0, 'father');
INSERT INTO Person-Household VALUES (1,0, 'mother');
-- insert into person values (to_date('17-Feb-2017','dd-MM-yyyy'))

