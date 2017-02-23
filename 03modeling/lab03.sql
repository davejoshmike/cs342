-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden

drop table Team;
--drop table PersonHousehold;
drop table Person;
drop table Household;

create table Household(
	id integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	province varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
	

create table Person (
	id integer PRIMARY KEY,
	householdid integer,
	mentorid integer,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	role varchar(15),
	CHECK (role in ('father', 'mother', 'child')),
	FOREIGN KEY (householdid) REFERENCES Household(id),
	FOREIGN KEY (mentorid) REFERENCES Person(id)
	);

create table Request(
	id integer PRIMARY KEY,
	householdid integer,
	requesttype varchar(30) CHECK (requesttype in ('prayer','financial','emotional')),
	requesttext varchar(100),
	FOREIGN KEY (householdid) REFERENCES Household(id)
	);
	
	
-- Create table PersonHousehold (
	-- personid integer,
	-- householdid integer,
	-- role varchar(15),
	-- CHECK (role in ('father', 'mother', 'child')),
	-- FOREIGN KEY (personid) REFERENCES Person(id),
	-- FOREIGN KEY (householdid) REFERENCES Household(id),
	-- PRIMARY KEY (personid, householdid)
	-- );
	
create table Team (
	id integer,
	personid integer,
	role varchar(15),
	teamName varchar(15),
	startDate date,
	endDate date,
	CHECK (teamName in ('worship','elders','pastoral','tech')),
	FOREIGN KEY (personid) REFERENCES Person(id),
	PRIMARY KEY (id, personid)
	);
	
--one person per team (mult roles?)
	
INSERT INTO Household VALUES (0,'5555 Oxford Dr. SE','Grand Rapids','MI','49506','616-555-5555');
INSERT INTO Household VALUES (1,'333 Woodcliff Ave SE','Grand Rapids','MI','49506','616-333-3333');

INSERT INTO Person VALUES (0,0,NULL,'mr.','Keith','VanderLinden','m', 'father');
INSERT INTO Person VALUES (1,1,NULL,'ms.','Brenda','VanderLinden','m', 'mother');
UPDATE Person SET mentorid=1 WHERE id=0;

INSERT INTO Person VALUES (2,1,0, 'mr.','Other','Person','m', 'father');
INSERT INTO Person VALUES (3,1,1, 'mrs.','Other','Person','m', 'mother');

INSERT INTO Team VALUES (0, 0, 'leader', 'worship', to_date('17-Feb-2017','DD-MON-YYYY'), to_date('24-Feb-2017','DD-MON-YYYY'));
INSERT INTO Team VALUES (0, 1, 'singer', 'worship', to_date('17-Feb-2017','DD-MON-YYYY'), to_date('24-Feb-2017','DD-MON-YYYY'));

INSERT INTO Request VALUES (0,0,'prayer', 'praise for awesome students in cs342');
