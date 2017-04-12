CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

-- execute incrementRank(movieId, smallIncrementValue);
-- execute incrementRank(movieId, smallIncrementValue);

-- Determine if ran correctly: if id does explain how. If it doesn;t identify the problem and modify the code to fix it.
