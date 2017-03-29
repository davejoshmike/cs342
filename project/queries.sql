-- Query 1:
-- Example Usage:
    -- we know that w.personId = 0
    -- we are grabbing the rate of an income tax bracket
    -- where year is 2016 (current year filing for)
    -- and the persons wage falls in the specified tax bracket
    -- and filing type is single,
    -- and the person is from Michigan

-- Purpose:
    -- these results allow us to easily query the tax rate of a person. The tax rate
        -- can be calculated once based on person information, and a trigger can be added
        -- to update the view each time a person's information (such as marital status, 
        -- location, etc.) changes.
    
    -- the database needs this in order to get an accurate tax rate for a person,
        -- and there will likely be many queries that use the tax rate
    
    -- Since the data does not need to be updated everytime it is queried (i.e. only when 
        -- a person's wage or location changes) a materialized view will be much more
        -- efficient than a view. It also allows for the easy query of 
        -- select rate from taxrate where personId=0;
        -- rather than using the long query writen below

DROP MATERIALIZED VIEW TaxRate;
CREATE MATERIALIZED VIEW TaxRate AS
(SELECT p.id "PERSONID", itb.rate 
        FROM (incometaxbracket itb JOIN (Person p JOIN Wage w ON p.id=w.personId) 
            ON w.yearlywage >= itb.bmin AND w.yearlywage <= itb.bmax)
        WHERE itb.id =
            (SELECT it.id 
                FROM IncomeTax it 
                WHERE to_date('2016', 'YYYY') = it.year
                AND p.filingType = it.filingtype
                AND p.state = it.state)
)
;
-- Satisfies:
    -- 4 table join of IncomeTaxBracket, Wage, IncomeTax and Person tables
    -- nested select statements

-- Query 2:
    -- Finds the average wage in each state
    -- Good for those who want to do statistics on the database and/or get aggregatized data
    SELECT Avg(yearlyWage), p.state
        FROM (Wage w JOIN Person p ON p.id = w.personId)
        GROUP BY p.state;
    -- Satisfies: 
        --Aggregate statistics on grouped data

-- Query 3:
    -- queries anyone whos yearly wages are not entered
    -- used for seeing whose wages are null and who needs to update their wage information
    SELECT p.id, p.firstname, p.lastname, w.yearlywage
        FROM (Person p JOIN Wage w ON p.id = w.personid)
        WHERE w.yearlywage IS NULL;
    -- Satisfies:
        -- NULL comparison

-- Query 4:
    -- Find those terrible people who don't pay taxes
    -- Good for the IRS to find those who don't pay their taxes
    SELECT p.id, p.firstname, p.lastname
        FROM (Person p LEFT OUTER JOIN Tax t ON p.id = t.personid)
        GROUP BY t.personid, p.id, p.firstname, p.lastname
        HAVING count(t.personid)=0
        ORDER BY p.ID;
    -- Satisfies:
        -- Outer-join query

-- Query 5:
    -- Debt free, woohoo!
    -- Good for those who want to give extra benefits or better rates to those who have no debt
    SELECT p.id, p.firstname, p.lastname
        FROM (Person p LEFT OUTER JOIN Loan l ON p.id = l.personid)
        GROUP BY l.personid, p.id, p.firstname, p.lastname
        HAVING count(l.personid)=0
        ORDER BY p.ID;
    -- Satisfies:
        -- Outer-join query

-- Query 6:
    -- make sure users aren't entered already and/or find people with the same name as you
    -- helpful for those adding to the Person table to find duplicates of people
    SELECT * 
        FROM (PERSON p1 JOIN PERSON p2 
            ON p1.FIRSTNAME=p2.FIRSTNAME
            AND p1.LASTNAME=p2.LASTNAME
            AND p1.STATE=p2.STATE
            AND p1.CITY=p2.CITY
            AND P1.FILINGTYPE=p2.FILINGTYPE
            AND p1.id>p2.id);
    -- Satisfies:
        -- self-join query (but not using tuple variables)


-----------------------------------------
-- Project Deliverable #3 Requirements --
-----------------------------------------
-- X Include at least three significant queries, with comments on:
    -- what the query returns (one sentence)
    -- who would care about the results (one sentence)

-- X Include at least one view, with comments on 
    -- what the view provides (one sentence)
    -- who would use it (one sentence)
    -- why you chose materialized or non-materialized (one sentence)

-- Also include queries that use:
    -- X a join of at least four tables
    -- X proper comparisons of NULL values
    -- ~ a self-join using tuple variables
    -- X a combination of inner and outer joins
    -- X a nested select statement
    -- X aggregate statistics on grouped data
