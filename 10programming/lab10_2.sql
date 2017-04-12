SPOOL lab10_2_script.txt
SET AUTOCOMMIT ON;
-- Re-enacting the well-known concurrency problems
    -- should be 8.5
    SELECT rank FROM MOVIE WHERE id=238071;
    UPDATE Movie SET rank=8.7 WHERE id=238071;
    
    -- should be 8.7
    SELECT rank FROM MOVIE WHERE id=238071;
    UPDATE Movie SET rank=8.4 WHERE id=238071;
    
    -- should be 8.4
    SELECT rank FROM movie WHERE id=238071;
SPOOL OFF

SPOOL lab10_2a_script2.txt
-- Problems:
    --a. Lost update problem (Figure 20.3.b)

    -- T1
    read_item(X);
    X := X - N;
    write_item(X);
    
    -- T2
    read_item(X);
    X:= X + M;
    write_item(X);

    -- T1
    read_item(Y);

    -- T1 fails and must change the value of X back to its old value; meanwhile T2 has read the temporary incorrect value of X
SPOOL OFF
