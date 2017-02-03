-- David Michel
-- February 3, 2017
-- Helpful Links
	-- https://cs.calvin.edu/courses/cs/342/kvlinden/01introduction/lab.html
	-- http://docs.oracle.com/cd/E11882_01/server.112/e10831/img/comsc008.gif
	-- http://www.w3schools.com/sql/
-- Lab 01
-- Exercise 1.1
	-- a.
	SELECT table_name 
	FROM user_tables;

	-- b.
	SELECT COUNT(*) 
	FROM EMPLOYEES

	-- c.
		-- i.
		SELECT FIRST_NAME,LAST_NAME 
		FROM EMPLOYEES 
		WHERE SALARY > 15000;
		
		-- ii.
		
		
	-- d.
	SELECT FIRST_NAME || ' ' || LAST_NAME 
	FROM EMPLOYEES, DEPARTMENTS
	WHERE DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
	AND DEPARTMENTS.DEPARTMENT_NAME = 'Finance'
	ORDER BY LAST_NAME ASC;

	-- e. 
	SELECT locations.city, locations.state_province, countries.country_name
	FROM locations, countries, regions
	WHERE locations.country_id = countries.country_id AND countries.region_id = regions.region_id AND regions.region_name = 'Asia';

	-- f.