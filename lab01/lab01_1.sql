-- David Michel
-- February 3, 2017
-- Helpful Links
	-- https://cs.calvin.edu/courses/cs/342/kvlinden/01introduction/lab.html
	-- http://docs.oracle.com/cd/E11882_01/server.112/e10831/img/comsc008.gif
	-- http://www.w3schools.com/sql/
-- Lab 01
-- Exercise 1.1
	-- a. list all the rows in the departmnets table
	SELECT *
	FROM DEPARTMENTS;

	-- b. find the number of employees in the database
	SELECT COUNT(*)
	FROM EMPLOYEES;

	-- c. list the employees who:
		-- i. make more than $15,000 per year
		SELECT *
		FROM EMPLOYEES 
		WHERE SALARY > 15000;
		
		-- ii. were hired from 2002-2004 (inclusive)
		SELECT *
		FROM EMPLOYEES
		WHERE HIRE_DATE >= '01-JAN-02'
		AND HIRE_DATE <= '31-DEC-04';
		
		-- iii. have a phone number that doesn't start with area code 515
		SELECT *
		FROM EMPLOYEES
		WHERE PHONE_NUMBER NOT LIKE '515%';		
		
	-- d. list the names of the employees in the finance department
	SELECT FIRST_NAME || ' ' || LAST_NAME 
	FROM EMPLOYEES, DEPARTMENTS
	WHERE DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
	AND DEPARTMENTS.DEPARTMENT_NAME = 'Finance'
	ORDER BY LAST_NAME ASC;

	-- e. list city, state and country name for all locations in the Asian region
	SELECT LOCATIONS.CITY, LOCATIONS.STATE_PROVINCE, COUNTRIES.COUNTRY_NAME
	FROM LOCATIONS, COUNTRIES, REGIONS
	WHERE LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID AND COUNTRIES.REGION_ID = REGIONS.REGION_ID AND REGIONS.REGION_NAME = 'Asia';

	-- f. list the locations that have no state or province specified
	SELECT *
	FROM LOCATIONS
	WHERE STATE_PROVINCE IS NULL;
	