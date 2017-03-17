-- Exercise 7.3
-- Do the following for the query on which the view in the previous exercises is based.
(SELECT firstname, lastname, 
        TRUNC(MONTHS_BETWEEN(sysdate, BIRTHDATE)/12), 
        BIRTHDATE
     From Person
    );

-- a. Write an equivalent query in the relational algebra.
   PROJECTIONfirstname, lastname, birthdate (Person)

-- b. Write an equivalent query in the domain relational calculus.
    {firstname, lastname, birthdate | Person}

--Don’t worry about querying the concatenated full name or the age;
--just query the first/last name and birthdate. 
--Store your results in lab07_3.txt (or an image file).