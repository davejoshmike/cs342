-- Exercise 9
    -- Current Indexes: 
        -- movie id
        -- director id
        -- actor id

    -- 1. Get the movies directed by Clint Eastwood.
        DROP INDEX md_index;
        CREATE INDEX md_index ON MovieDirector(directorid, movieid);
    --    DROP INDEX movie_index;
    --    CREATE INDEX movie_index ON Movie(id);
    
        SELECT id, name, year, rank
        FROM (Movie m JOIN MovieDirector md ON md.movieid=m.id)
        WHERE directorID=(SELECT id FROM Director WHERE firstname='Clint' AND lastname='Eastwood')
        ;
    
        --with index:
            -- 1 recursive call
            -- 403 consistent gets
            -- uses moviedirector index
            -- uses movie index
            -- speed: 00:00:00.03
    
        -- without index:
            -- 40 recursive calls
            -- 1213 consistent gets
            -- table access full moviedirector
            -- uses movie index
            -- speed: 00:00:00.05
    
        -- difference:
            -- 39 recursive calls
            -- 810 consistent gets
            -- speed: 00:00:00.02

        
        -- Optimization:
            -- indexing MovieDirector largely reduces the amount of recursive calls

    -- 2. Get the number of movies directed by each director who’s directed more than 200 movies.
        DROP INDEX md_index;
        CREATE INDEX md_index ON MovieDirector(directorid, movieid);
    
        SELECT directorid, sum(movieid)
        FROM MovieDirector
        GROUP BY directorid
        HAVING sum(movieid) > 200;
            
        -- with index:
            -- 1 recursive call
            -- 785 consistent gets    
            -- speed: 00:00:01.63
    
        -- without index:
            -- 40 recursive calls
            -- 813 consistent gets
            -- speed: 00:00:01.68
    
        -- difference:
            -- 39 recursive calls
            -- 28 consistent gets
            -- speed: 00:00:00.05

        -- Optimization:
            -- indexing MovieDirector largely reduces the amount of recursive calls
            -- sum instead of count is also a speed increase


    -- 3. Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.
    --    DROP INDEX movie_index;
    --    CREATE INDEX movie_index ON Movie(id);

    --    Note: too many indexes to make
    --    DROP INDEX role_index;
    --    CREATE INDEX role_index ON Role(actorid)
    
        SELECT actorid, avg(rank), count(id)
        FROM (Role JOIN Movie ON movieid=id)
        GROUP BY actorid 
        HAVING avg(rank) > 8.5 
            AND count(id) >= 10
        ;
            
        -- with index:
            -- 1 recursive call
            -- 13306 consistent gets
            -- 00:00:05.98
    
        -- without index:
            -- N/A (The movie index is not deletable and
            -- the role table is too big to be indexable)

        -- Optimization:
            -- Using JOIN .. ON syntax to reduce the amount of rows joined


-- Instructions:
    --For each query, include a short (one-paragraph) discussion that includes the following.
        --the alternate implementation forms you could have used and why you chose the one you did
        --the indexes your queries use (or don’t use) and why they help
        --the general SQL tuning heuristics you’ve deployed



-- Extra:
    -- 2. print the names of all directors who have over 200 movies
        DECLARE
        CURSOR directorids IS
            (SELECT directorid, count(*) moviesdirected
            FROM MovieDirector
            GROUP BY directorid
            HAVING count(movieid)>200
            );
        directorfname VARCHAR2(200);
        directorlname VARCHAR2(200);
            
    BEGIN
        FOR directorid in directorids
        LOOP
            SELECT firstname INTO directorfname FROM Director Where id=directorid.directorid;
            SELECT lastname INTO directorlname FROM Director Where id=directorid.directorid;
            dbms_output.put_line(directorfname || ' ' || directorlname || ' has directed over ' || directorid.moviesdirected || ' movies');
        END LOOP;
    END;
/

    -- 3. print the names of all the actors
    DECLARE
        CURSOR actorids IS
            (SELECT actorid, avg(rank) actorrank, count(id) moviecount
            FROM (Role JOIN Movie ON movieid=id)
            GROUP BY actorid 
            HAVING avg(rank) > 8.5 
                AND count(id) >= 10
            );
        actorfname VARCHAR2(100);
        actorlname VARCHAR2(100);
    BEGIN
        FOR actorid in actorids
        LOOP
            SELECT firstname INTO actorfname FROM actor Where id=actorid.actorid;
            SELECT lastname INTO actorlname FROM actor Where id=actorid.actorid;
            dbms_output.put_line(actorfname || ' ' || actorlname || ' has an avg rank of ' || actorid.actorrank || ' while being in ' || actorid.moviecount || ' movies');
        END LOOP;
    END;
