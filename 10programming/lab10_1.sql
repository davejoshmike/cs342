-- parallel
    SET AUTOCOMMIT OFF;
    -- a.
    SELECT * FROM Movie WHERE id=238071;
    
    -- both return the same movie

    -- b. the 2nd session won't be able to delete
    DELETE FROM MOVIE WHERE id=238071;
    SELECT * FROM MOVIE WHERE id=238071;
    
    -- session 1 deleted successfully
    -- when you select with session 2 the movie still shows up. This implies
    -- that the transaction has been saved locally but has not been commited yet.

    -- c. rollback and query
    ROLLBACK;
    SELECT * FROM MOVIE WHERE id=238071;

    -- session 1s delete got rolled back and now returns the movie results again,
    -- as does session 2

    -- d. add movie and query
    INSERT INTO Movie VALUES ((select max(id)+1 from movie), 'Casablanca', 1954, 8, NULL);
    SELECT * FROM Movie WHERE id=(Select max(id) FROM movie);

    -- session 1 sees the newly created movie, session 2 does't know about it and doesn't
    -- select it.

            
    -- e. commit transaction
    COMMIT;
    SELECT * FROM Movie WHERE id=(Select max(id) FROM movie);

    -- now both session 1 and session 2 return the same results

-- Exercise 10.1
-- a. Does Oracle handle the transaction life-cycle with respect to starting and stopping SQL*Plus sessions
    -- Oracle starts and commits a transacion every time you start or stop an sql*plus session, respectfully
    -- the transaction may also be manually rolled back, committed or given a savepoint
    -- with autocommit on, sql*plus commits after every query

-- b. Can we implement any of the ACID properties using START-TRANSACTION/SAVEPOINT/ROLLBACK/COMMIT?
    -- Starting a transaction can lock the database during mutable transactions, for example when you
    -- try to delete with two parallel sessions, one will hang and not be able to delete.
