--Exercise 8.1
-- Implement a “shadow” log that records every update to the rank of any Movie record. Store your log in a separate table ( RankLog ) and include the ID of the user who made the change (accessed using the system constant user), the date of the change (accessed using sysdate) and both the original and the modified ranking values.
-- Rank Log Table
-- Opting to use Timestamp instead of Date because Timestamp seems much better suited for log keeping
DROP TABLE RankLog;
CREATE TABLE RankLog (
    username VARCHAR2(25),
    systemTime TIMESTAMP,
    original NUMBER(10,2),
    modified NUMBER(10,2)
);

-- Trigger
CREATE OR REPLACE TRIGGER RankLogTrigger
BEFORE UPDATE ON Movie
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
    DECLARE
        username VARCHAR2(25);
        systemTime TIMESTAMP;
        originalRank NUMBER(10,2);
        modifiedRank NUMBER(10,2);
    BEGIN
        SELECT User INTO username FROM DUAL;
        SELECT systimestamp INTO systemTime FROM DUAL;
        originalrank := :old.Rank;
        modifiedRank := :new.Rank;

        INSERT INTO RankLog VALUES (username, systemTime, originalRank, modifiedRank);
    END;
/

-- Testing Trigger
UPDATE Movie SET Rank=8.0 WHERE ID=17173;
UPDATE MOVIE SET Rank=8.5 WHERE ID=17173;
UPDATE MOVIE SET Rank=9.0 WHERE ID=17173;
SELECT * FROM RankLog;