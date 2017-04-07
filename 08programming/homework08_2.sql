-- Exercise 8.2
-- Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify an actor ID and that actor’s Bacon number.
    --An actor’s bacon number is the length of the shortest path between the actor and Kevin Bacon (KB) in the “co-acting” graph. 
    --That is, KB has bacon number 0; all actors who acted in the same movie as KB have bacon number 1; all actors who acted in the same movie as some actor with Bacon number 1 but have not acted with Bacon himself have Bacon number 2, etc. 
    --Actors who have never acted with anyone with a bacon number should not have a record in the table. 
    --Stronger solutions will be configured so that the number can be based on any actor, not just Kevin Bacon.

-- Rules:
-- If you are indeed Kevin Bacon, 
    -- your Bacon number is 0.
-- If an actor works in a movie with Kevin Bacon, 
    -- that actor's Bacon number is 1.
-- If an actor works with another actor who worked with Kevin Bacon in a movie,
    -- the first actor's Bacon number is 2, and so forth.

-- Algo:
--base: set baconNum of the actual bacon to 0
--
--for each actorId in movieIds,
--check if baconNum is already set for that actor
--         also check if the baconNum is greater than the current degree
--             mark baconNum as current degree
--     if baconNum is not set
--         mark baconNum as current degree
--and
--get new movieIds that the actor has been in
--recursive call (for each actorid in movieIds...)

-- Note: before calling, run this on the system user:
   -- ALTER SYSTEM SET open_cursors = 65535 SCOPE=BOTH;  
---------------------------------------------------------------------------------

DROP TABLE Bacon;
CREATE TABLE Bacon (
    actorId NUMBER(38),
    baconNum NUMBER(38),
    FOREIGN KEY (actorId) REFERENCES Actor(id) ON DELETE CASCADE,
    PRIMARY KEY (actorId)
);

-- Note: default baconId is that of Kevin Bacon
    -- default degreesFromBacon is recursive level 0
CREATE OR REPLACE PROCEDURE ComputeBaconNum (currentActorId NUMBER, baconId NUMBER, degreesFromBacon NUMBER)
IS
    -- select the actorids from the movieids that kevin bacon has been in 
    -- that arent in the bacon table
    -- or are already kevin bacon
    CURSOR newactors IS
    (SELECT DISTINCT r.actorId
    FROM Role r
    WHERE r.movieId IN (SELECT r2.movieId 
                        FROM Role r2 
                        WHERE r2.actorId = ComputeBaconNum.currentActorId)        
    AND NOT EXISTS (SELECT *
                    FROM Bacon b
                    WHERE b.actorId = r.actorId)
    AND r.actorId != ComputeBaconNum.currentActorId
    );

--    CURSOR existingactors IS
--    (SELECT DISTINCT r.actorId
--    FROM Role r
--    WHERE r.movieId IN (SELECT r2.movieId 
--                        FROM Role r2 
--                        WHERE r2.actorId=ComputeBaconNum.currentActorId)
--    AND EXISTS (SELECT *
--                FROM Bacon b
--                WHERE b.actorId = r.actorId
--                AND b.baconNum > ComputeBaconNum.degreesFromBacon)
--    AND r.actorId != ComputeBaconNum.currentActorId
--    );
    newDegreesFromBacon NUMBER;
BEGIN
--    FOR existingactor in existingactors
--    LOOP
--        -- if the current Degree is closer than the actor's current baconNum, overwrite it with the better baconNum
--        -- The actor's existence in this table means we've already done our recursive call on their movies and don't need to again
--        UPDATE Bacon SET baconNum = degreesFromBacon WHERE actorId = existingactor.actorId;
--    END LOOP;
--    CLOSE existingactors;
    newDegreesFromBacon := degreesFromBacon + 1;
    IF(newDegreesFromBacon > 5)
    THEN
        RETURN;
    END IF;
    FOR newactor in newactors
    LOOP
        -- if the actor doesn't have a baconNum, create one
        INSERT INTO Bacon VALUES (newactor.actorId, newDegreesFromBacon);
        ComputeBaconNum(newactor.actorId, baconId, newDegreesFromBacon);
    END LOOP;
--    CLOSE newactors;
END ComputeBaconNum;
/

-----------------------------------
    --TEST--
DECLARE
    PROCEDURE test (currentActorId NUMBER, baconId NUMBER, degreesFromBacon NUMBER)
    IS
        CURSOR newactors IS
        (SELECT DISTINCT r.actorId
        FROM Role r
        WHERE r.movieId IN (SELECT DISTINCT r2.movieId 
                            FROM Role r2 
                            WHERE r2.actorId = test.currentActorId)        
        AND NOT EXISTS (SELECT *
                        FROM Bacon b
                        WHERE b.actorId = r.actorId)
        AND r.actorId != test.currentActorId        
        );
    
    --    CURSOR existingactors IS
    --    (SELECT DISTINCT r.actorId
    --    FROM Role r
    --    WHERE r.movieId IN (SELECT r2.movieId 
    --                        FROM Role r2 
    --                        WHERE r2.actorId=ComputeBaconNum.currentActorId)
    --    AND EXISTS (SELECT *
    --                FROM Bacon b
    --                WHERE b.actorId = r.actorId
    --                AND b.baconNum > ComputeBaconNum.degreesFromBacon)
    --    AND r.actorId != ComputeBaconNum.currentActorId
    --    );
        newDegreesFromBacon NUMBER;
    BEGIN
        newDegreesFromBacon := degreesFromBacon + 1;
        IF(newDegreesFromBacon > 8)
        THEN
            RETURN;
        END IF;
--        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
--        DBMS_OUTPUT.PUT_LINE('ActorId: ' || TO_CHAR(test.actorId));
--        DBMS_OUTPUT.PUT_LINE('Degrees From Bacon: ' || TO_CHAR(test.degreesFromBacon));

--        FOR existingactor in existingactors
--        LOOP
--            DBMS_OUTPUT.PUT_LINE('Existing Actor: ' || TO_CHAR(existingactor.actorId));
--        END LOOP;

        FOR newactor in newactors
        LOOP
            
            BEGIN
                INSERT INTO Bacon VALUES (newactor.actorId, newDegreesFromBacon); 
            EXCEPTION
                WHEN OTHERS
                THEN --DBMS_OUTPUT.PUT_LINE('PK violation on: ' || newactor.actorId);
                NULL;
            END;
            test(newactor.actorId, baconId, newDegreesFromBacon);
        END LOOP;
    END;
BEGIN
--    baconId := 225014;
    DBMS_OUTPUT.PUT_LINE('---------------START----------------');
    DBMS_OUTPUT.PUT_LINE('BaconId: ' || TO_CHAR(225014));
    INSERT INTO Bacon VALUES (225014, 0); 
    test(225014,225014,0);
    DBMS_OUTPUT.PUT_LINE('---------------DONE----------------');
END;
/
    delete from bacon;
    Select count(*) from Bacon;
    select baconnum, count(*) from bacon group by baconnum;

    select movieid, count(*) from role group by movieid; --37 movies
    select count(*) from actor where id in (select DISTINCT actorId from role); --1909 distinct actors
------------------------------------

CREATE OR REPLACE PROCEDURE PopulateBaconProc (baconId NUMBER DEFAULT 22591)
IS      
--    Iterator NUMBER := 1;     
--    baconNum NUMBER;
BEGIN
--    -- for loooooooops yaaaaaaaaaaaaaaaaay
--        FOR actor in (SELECT id FROM ACTOR)
--        LOOP
--            -- go through each actor and compute bacon number for each actor
--            baconNum := ComputeBaconNum(actor.Id);
--            --INSERT INTO Bacon VALUES (actor.Id, baconNum);
--        END LOOP;

    -- The one true Bacon. Base case.
    INSERT INTO Bacon VALUES (baconId, 0);
    ComputeBaconNum(baconId, baconId, 0);
END PopulateBaconProc;
/

DECLARE
    baconId NUMBER;
BEGIN
--    SELECT id INTO baconId FROM Actor WHERE firstname='Kevin' AND lastname='Bacon';
    baconId := 225014;
    PopulateBaconProc(baconId);

--    SELECT id INTO baconId FROM Actor WHERE firstname='Samuel L.' AND lastname='Jackson';
--    BaconProc(baconId);
--    Select * From Bacon;
END;
/
DELETE FROM BACON;
Select * From Bacon WHERE ROWNUM <= 10;
select baconnum, count(*) From BACON GROUP BY baconnum;
select count(*) from bacon;
select count(*) from Actor;

--SELECT id FROM Actor WHERE firstname='Kevin' AND lastname='Bacon';