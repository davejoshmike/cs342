-- Exercise 5.1
-- a.
    select count(*) from person, household;
    -- There are 128 records queried. 
    -- The query did the cross product of the rows in person (16 rows) and the rows in household (8 rows).

-- b.
    select * from person ORDER BY To_char(BIRTHDATE, 'DDD') DESC;
    -- DDD computes the day of the year given a date