--Write an SQL query that creates phonebook entries as follows.

--Produce an appropriate phone-book entry for “traditional” family entries, e.g.:
--VanderLinden, Keith and Brenda - 111-222-3333 - 2347 Oxford St.
select p1.lastname || ', ' || p1.firstname || ' and ' || p2.firstname "Traditional Household",
    h.phonenumber, h.street
from ((Person p1 JOIN Person p2 ON p2.HOUSEHOLDID=p1.HOUSEHOLDID 
    AND p1.HOUSEHOLDROLE='husband' 
    AND p2.HOUSEHOLDROLE='wife') 
    JOIN Household h ON h.id=p1.HOUSEHOLDID)
;

--Extend your solution to handle families in which both spouses keep their own names, e.g.:
--VanderLinden, Keith and Brenda Roorda - 111-222-3333 - 2347 Oxford St.
select p1.lastname || ', ' || p1.firstname || ' and ' || p2.firstname || ' ' || p2.lastname "Traditional Household",
    h.phonenumber, h.street
from ((Person p1 JOIN Person p2 ON p2.HOUSEHOLDID=p1.HOUSEHOLDID 
    AND p1.HOUSEHOLDROLE='husband' 
    AND p2.HOUSEHOLDROLE='wife') 
    JOIN Household h ON h.id=p1.HOUSEHOLDID)
;

--Finally, extend your solution to include single-adult families, e.g.:
--Doe, Jane - 111-222-3333 - 2347 Main St.
select p.lastname || ', ' || p.firstname "Single Household",
    h.phonenumber, h.street
from (Person p JOIN Household h ON p.HOUSEHOLDROLE='single' 
    AND h.id=p.HOUSEHOLDID)
;

--List only the parents and the singles, not the children. Store your results in lab05_3.sql.