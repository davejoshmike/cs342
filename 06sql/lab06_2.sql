-- Exercise 6.2: Aggregates and Funcions
-- a. Compute the average age of all the people in the database. Note you can use the following Oracle features in this query.
    SELECT avg(months_between(trunc(sysdate), trunc(BIRTHDATE))/12) "Average Age" FROM Person;

    -- This aggregate function operates on the entire table which is one giant group

-- b. Get the household ID and count of members of all households in Grand Rapids having at least 2 members. Order the results by decreasing size
    SELECT p.householdid, count(*), h.PHONENUMBER
    FROM (Person p JOIN household h 
        ON h.city = 'Grand Rapids') 
    GROUP BY p.householdid, h.phonenumber
    HAVING count(*) > 1 
    ORDER BY count(*) DESC
    ;
    
-- c. Modify the previous query to retrieve the phone number of the household as well.
    SELECT p.householdid, count(*), h.PHONENUMBER
    FROM (Person p JOIN household h 
        ON h.city = 'Grand Rapids' AND p.householdid=h.id) 
    GROUP BY p.householdid, h.phonenumber
    HAVING count(*) > 1 
    ORDER BY count(*) DESC
    ;
