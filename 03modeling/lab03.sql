-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden

drop table Team;
drop table PersonHousehold;
drop table Person;
drop table Household;

create table Household(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	province varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Person (
	ID integer PRIMARY KEY,
	householdid integer,
	mentorid integer,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	FOREIGN KEY (mentorid) REFERENCES Person(id),
	FOREIGN KEY (householdid) REFERENCES HouseHold(id)
	);

Create table PersonHousehold (
	personid integer,
	householdid integer,
	role varchar(15),
	CHECK (role in ('father', 'mother', 'child')),
	FOREIGN KEY (personid) REFERENCES Person(id),
	FOREIGN KEY (householdid) REFERENCES Household(id),
	--CONSTRAINT Person(id) PRIMARY KEY (personid),
	--CONSTRAINT Household(id) PRIMARY KEY (householdid)
	PRIMARY KEY (personid, householdid)
	);
	
create table Team (
	ID integer,
	personid integer,
	role varchar(15),
	teamName varchar(15),
	startDate date,
	endDate date,
	CHECK (teamName in ('worship','elders','pastoral','tech'))
	FOREIGN KEY (personid) REFERENCES Person(id),
	PRIMARY KEY (id, personid),
	);
	
--one person per team (mult roles?)
	
INSERT INTO Household VALUES (0,'5555 Oxford Dr. SE','Grand Rapids','MI','49506','616-555-5555');
INSERT INTO Household VALUES (1,'333 Woodcliff Ave SE','Grand Rapids','MI','49506','616-333-3333');

INSERT INTO Person VALUES (0,0,1,'mr.','Keith','VanderLinden','m');
INSERT INTO Person VALUES (1,0,0,'ms.','Brenda','VanderLinden','m');

INSERT INTO Person VALUES (2,1,NULL, 'mr.','Other','Person','m');
INSERT INTO Person VALUES (3,1,NULL, 'mrs.','Other','Person','m');

INSERT INTO PersonHousehold VALUES (0,0, 'father');
INSERT INTO PersonHousehold VALUES (1,0, 'mother');

INSERT INTO Team VALUES (0, 0, 'leader', 'worship', to_date('2017-Feb-17','YYYY-MM-DD'), to_date('2017-Feb-24','YYYY-MM-DD'));
INSERT INTO Team VALUES (0, 1, 'singer', 'worship', to_date('2017-Feb-17','YYYY-MM-DD'), to_date('2017-Feb-24','YYYY-MM-DD'));
-- insert into person values (to_date('17-Feb-2017','dd-MM-yyyy'))

