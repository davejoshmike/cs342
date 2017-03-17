-- Exercise 7.1
DROP VIEW birthdayczarmatview;
CREATE MATERIALIZED VIEW BIRTHDAYCZARMATVIEW FOR UPDATE AS 
    (SELECT id,
        firstname, 
        lastname, 
        BIRTHDATE
     From Person
    );

-- a. GenX-ers
    SELECT *
    FROM birthdayczarmatview
    WHERE BIRTHDATE >= to_date('01-01-1961', 'MM-DD-YYYY')
    AND BIRTHDATE <= to_date('12-31-1975', 'MM-DD-YYYY');

-- b. update person table 
    --reverse
    UPDATE PERSON
    SET BIRTHDATE = NULL
    WHERE BIRTHDATE = TO_DATE('05-23-1967', 'MM-DD-YYYY');

    UPDATE PERSON
    SET BIRTHDATE = TO_DATE('05-23-1967', 'MM-DD-YYYY') 
    WHERE BIRTHDATE IS NULL;
    -- do the results change?
    -- no the materialized view does not update even though the base table
    -- was updated. 

--c.
    INSERT INTO birthdayczarmatview VALUES (16, 'Bobby', 'Dylan', TO_DATE('01/01/1975','MM/DD/YYYY'));
    -- the materialized view is required to be key persistant, which means we
    -- are allowed to insert an entry as long as there are no constraints violated
    -- on the base table. The rest of the fields will be NULL in the base table.

    --select max(id)
    --from PERSON

--d. 
    DROP VIEW birthdayczarmatview;
    -- The row that was inserted above didn't get saved when the materialized view
    -- was deleted. So dropping the view deleted the row that was inserted.
