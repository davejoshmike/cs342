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

-- Old Algo:
-- base: set baconNum of the actual bacon to 0
--
-- for each actorId in movieIds,
-- check if baconNum is already set for that actor
--         also check if the baconNum is greater than the current degree
--             mark baconNum as current degree
--     if baconNum is not set
--         mark baconNum as current degree
-- and
-- get new movieIds that the actor has been in
-- then do a recursive call (for each actorid in movieIds...)

-- basically, go to the farthest left node and go from there

-- new algo:
-- only select actors who are not in the bacon table yet
    -- and are in a movie with kevin bacon (or in a movie with the lower degree
    -- person)
-- then for the whole depth, insert those nodes into the bacon table.
    -- then we don't need to worry about updating or finding the lowest bacon number
    -- and the amount of actors selected will diminish as more people are added
    -- to the bacon table
-- then for each actorid in the current depth
    -- do the recursive call and once again updating the whole depth at once (for
    -- the calling actor's movies)
---------------------------------------------------------------------------------

-- make the Bacon table
DROP TABLE Bacon;
CREATE TABLE Bacon (
    actorId NUMBER(38),
    baconNum NUMBER(38),
    FOREIGN KEY (actorId) REFERENCES Actor(id) ON DELETE CASCADE,
    PRIMARY KEY (actorId)
);

-- compute all actors for current depth... wait till all are finished... then call recursive call of all actors from level 1
CREATE OR REPLACE PROCEDURE computeForCurrentDepth (baconId NUMBER, degreesFromBacon NUMBER)
IS
    CURSOR newactors IS
    (SELECT DISTINCT r.actorId
    FROM Role r
    WHERE r.movieId IN (SELECT r2.movieId 
                        FROM Role r2 
                        WHERE r2.actorId = computeForCurrentDepth.baconId)        
    AND NOT EXISTS (SELECT *
                    FROM Bacon b
                    WHERE b.actorId = r.actorId)
    AND r.actorId != baconId
    );
BEGIN
    FOR newactor in newactors
    LOOP
        INSERT INTO Bacon VALUES (newactor.actorid, degreesFromBacon);
    END LOOP;
END;
/

-- calls ComputeForCurrentDepth and recursively calls itself to compute a bacon number
-- for each actor in the Actor table.
CREATE OR REPLACE PROCEDURE ComputeBaconNum (currentActorId NUMBER, baconId NUMBER, degreesFromBacon NUMBER)
IS
    --base:
    -- select the actorids from the movieids that kevin bacon has been in 
        -- that arent in the bacon table
        -- or are kevin bacon himself

    -- gets the cursor of actors we are going to compute the bacon numbers for
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

    newDegreesFromBacon NUMBER;
    l_actorid role.actorId%type;
BEGIN
    newDegreesFromBacon := degreesFromBacon + 1;
    
    -- stop at depth 5
    IF(newDegreesFromBacon > 5)
    THEN
        RETURN;
    END IF;

    -- compute entire depth at once
    computeForCurrentDepth(baconId, newDegreesFromBacon);

    --get the new actors for the next depth to compute
    OPEN newactors;

    LOOP
        FETCH newactors INTO l_actorId;
        -- compute actors degrees from bacon
        computeForCurrentDepth(l_actorId, newDegreesFromBacon);
        EXIT WHEN l_actorId%notfound;
    END LOOP;
    CLOSE newactors;
END ComputeBaconNum;
/

-- does the base case and calls ComputeBaconNum
CREATE OR REPLACE PROCEDURE PopulateBaconProc (baconId NUMBER DEFAULT 22591)
IS      
BEGIN
    -- The one true Bacon. Base case.
    INSERT INTO Bacon VALUES (baconId, 0);
    ComputeBaconNum(baconId, baconId, 0);
END PopulateBaconProc;
/

-- call our stored procedure
DECLARE
    baconId NUMBER;
BEGIN
    SELECT id INTO baconId FROM Actor WHERE firstname='Kevin' AND lastname='Bacon';
    PopulateBaconProc(baconId);
END;
/

--useful queries
--DELETE FROM BACON;
--select baconnum, count(*) From BACON GROUP BY baconnum;
--select count(*) from bacon;
