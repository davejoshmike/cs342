CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		-- SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=rank+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

    -- Usage:
        -- incrementRank(movieId, smallIncrementValue);

    SELECT * FROM Movie WHERE id=350425;
    UPDATE Movie Set rank=8 where id=350425;

    -- First Run (original):
        -- EXECUTE incrementRank(350425, .01);
        -- Expected: 1008.00 (two incrementRanks)
                  -- 508 (one incrementRank)
        -- Actual: 511.74
        
        --Explanation:
            -- Lost update problem where T1 selects, then T2 selects, then t1 updates and t2 updates,
                -- and there is a missing update. In this case there were 374 out of 100,000 updates that weren't lost updates
        -- Solution:
            -- Make the select and the update one query

    -- Second Run (with changes):
        -- EXECUTE incrementRank(350425, .01);
        -- Expected: 1008
        -- Actual: 1008

        -- Explanation:
            -- Moving the select and the update queries into one query disallows the chance for race conditions and lost updates.
