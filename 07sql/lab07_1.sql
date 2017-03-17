-- Exercise 7.1
DROP VIEW birthdayczarview;
CREATE VIEW birthdayczarview AS 
    (SELECT firstname || ' ' || lastname "FULLNAME", 
        TRUNC(MONTHS_BETWEEN(sysdate, BIRTHDATE)/12) "AGE", 
        BIRTHDATE
     From Person
    );

-- a. GenX-ers
    SELECT *
    FROM birthdayczarview
    WHERE BIRTHDATE >= to_date('01-01-1961', 'MM-DD-YYYY')
    AND BIRTHDATE <= to_date('12-31-1975', 'MM-DD-YYYY');

-- b. update person table 
    UPDATE PERSON
    SET BIRTHDATE = TO_DATE('05-23-1967', 'MM-DD-YYYY') 
    WHERE BIRTHDATE IS NULL;
    -- do the results change?
    -- The results of the view query do indeed change. 
    -- I am guessing that either whenever a table the view references changes,
    -- or when a view is queried, the view gets updated with the new changes
    -- from the table


-- c.  
    INSERT INTO BIRTHDAYCZARVIEW VALUES ('Bobby Dylan', 42, TO_DATE('01/01/1975','MM/DD/YYYY'));
    -- In order to make a modification to the view, we would need Person.ID in order to make
    -- the birthday czar view a key persistant table

-- d.
    DROP VIEW BIRTHDAYCZARVIEW;
    SELECT *
    FROM Person
    WHERE BIRTHDATE >= to_date('01-01-1961', 'MM-DD-YYYY')
    AND BIRTHDATE <= to_date('12-31-1975', 'MM-DD-YYYY');
    -- dropping the view does not affect the base table
