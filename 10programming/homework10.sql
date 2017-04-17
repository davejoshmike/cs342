--

CREATE OR REPLACE PROCEDURE transferRank (movieId1 NUMBER, movieId2 NUMBER, rankToTransfer NUMBER)
    Rank_Below_Zero_Exception EXCEPTION;
    Movie_Not_Found_Exception EXCEPTION;
    dummy1 NUMBER;
    dummy2 NUMBER;
BEGIN
    SELECT Rank INTO dummy FROM Movies WHERE id=movieId1;
    SELECT Rank INTO dummy2 FROM Movies WHERE id=movieId2;
    IF (dummy1 < 0 OR dummy2 < 0)
    THEN
        RAISE Rank_Below_Zero_Exception;
    END IF;
    
    IF (dummy1 IS NONE OR dummy2 IS NONE)
    THEN
        RAISE Movie_Not_Found_Exception;
    END IF;

    LOCK Movies;    
    Update Movies SET Rank=() WHERE id=movieid1;

EXCEPTION
    WHEN Rank_Below_Zero_Exception
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'Rank below zero');
    WHEN Movie_Not_Found_Exception
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'Movie not found');
END;



-- test query
BEGIN
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, 0.1);
		COMMIT;
		transferRank(176711, 176712, 0.1);
		COMMIT;
	END LOOP;
END;
/