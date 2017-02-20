-- a. The original IMDB Movie table included fields for both score and votes. Can you add a constraint (using the mechanisms we’ve studied) the requires that all movies having a non-NULL score value must also have more than 1000 votes? If so, explain what constraint you’d specify; if not, include an explanation of why it’s not possible.
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900),
	CHECK (votes > 1000),
	CHECK (score is not NULL)
	);
-- This would satisfy the constraints, except that score can now not be ever set to null. There is IF THEN and CASE statements in PL-SQL, however in SQL there is not conditional logic other than WHERE EXISTS and the like
	-- to that effect:
	-- CHECK (votes > 1000 WHERE EXISTS (SELECT score FROM Movie))
	-- probably wouldn't work as there is no Movie table to select from yet
	
-- b. Database systems, including Oracle, allow DBAs to create separate constraints that are set on given tables, which allows DBAs to turn constraints off and on during database operations, e.g.:
--ALTER TABLE tableName
--    ADD CONSTRAINT constraintName
--    someConstraint;
--Can you imagine when, if ever, you might want to separate a constraint from the table definition it modifies? If so, describe the circumstances; if not, explain why not.

-- It doesn't seem to make much sense to seperate a constraint from the defenition, except maybe in refactoring/database cleansing. Only when you want to normalize the data does it seem like this would be used.