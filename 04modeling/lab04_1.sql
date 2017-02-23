-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team IDs are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

-- terrible things:
--1. Bad DB Smell - lots of null values
--2. no teamID - there is no way to distinguish between teams except through teamName. 
--3. no primary key or constraints declared in the table
	--a. there is no way to distinguish between different entries if someone accidentally puts a duplicate id for personId or mentorId.
	--b. also personId and mentorId can be null
--4. there is nothing stopping a person from having more than one mentor if there are multiple entries with the same personId => add a unique constraint and a foreign key constraint (if keeping it all in one table)
--5. A Person, Mentor and a Team are different real-world entities. It would be difficult to explain a PersonMentorTeam to your grandma.

-- Bad Schema --
drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');

--Functional Dependencies:
--personID, name, status, mentorId, mentorName, mentorStatus, teamName, teamRole, teamTime => personID, name, status, mentorId, mentorName, mentorStatus, teamName, teamRole, teamTime

-- Good Schema --
drop table Person;
drop table Mentor;
drop table Team;
drop table PersonTeam;
	
CREATE TABLE Team (
    teamName varchar(10) PRIMARY KEY,
    teamTime varchar(10)
	);

CREATE TABLE PersonTeam (
	personId integer,
	teamName varchar(10),
	teamRole varchar(10),
	PRIMARY KEY (personId, teamName)
	);
CREATE TABLE Mentor (
	mentorId integer PRIMARY KEY,
	mentorName varchar(10),
	mentorStatus char(1)
	);

CREATE TABLE Person (
	personId integer PRIMARY KEY,
	mentorId integer,
	teamName varchar(10),
	name varchar(10),
	status char(1),
	FOREIGN KEY (mentorId) REFERENCES Mentor(mentorId),
	FOREIGN KEY (teamName) REFERENCES Team(teamName)
	);
	
-- Functional Dependencies (3NF and BCNF):
	--personId => name, status
	--mentorId => mentorName, mentorStatus
	--teamName => teamTime
	--personId, teamId => teamRole

INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM AltPerson;
INSERT INTO PersonTeam SELECT DISTINCT personId, teamName, teamRole FROM AltPerson;
INSERT INTO Mentor SELECT DISTINCT mentorId, mentorName, MentorStatus FROM AltPerson WHERE mentorId IS NOT NULL;
INSERT INTO Person SELECT DISTINCT personId, mentorId, teamName, name, status FROM AltPerson WHERE mentorId IS NOT NULL;
