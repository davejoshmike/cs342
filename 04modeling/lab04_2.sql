-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

select * from PersonTeam;
select * from PersonVisit;

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

-- Exercise 4.2
	-- a. 
	-- PersonTeam:
	-- 	personName, teamName => personName, teamName
	
	-- PersonVisit:
	-- 	personName, personVisit => personName, personVisit
	
	-- These are in BCNF because every partial key depends on a superkey
	
	-- b.
	-- PersonTeamVisit:
	-- 	personName, teamName, personVisit => personName, teamName, personVisit
	-- This table is 
	
	-- c.
		-- No it does not, I would prefer the combined schemata. With the first value, there is no unique or primary key to connect the two tables together, as PersonName and TeamName do not determine personVisit. The answer also might depend on whether or not a person
		