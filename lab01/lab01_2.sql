-- reference
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/queries009.htm
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions001.htm#i88893

-- The "dual" table only contains one column. That column only contains one row with one value. This table allows you to practice constant expressions and queries that don't require entries to perform an operation. It also makes for nice, neat results because a query will only ever return one column, row or value

-- neatly returns only one row and column
select * from dual;
-- returns X

-- arithmetic expressions
SELECT 1+1
from dual;
-- returns 2, doesn't rely on any database entries

SELECT 1 
from dual;
-- returns 1, doesn't rely on any database entries

-- allows you to check who the USERs are
SELECT USER
from dual;
-- returns SYSTEM

-- allows you to check the date of the system
SELECT SYSDATE 
from dual;
-- returns 03-FEB-17