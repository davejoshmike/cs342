-- Exercise 7.1
    -- a.
    DROP VIEW MovieAndStar;
    CREATE VIEW MovieAndStar
    AS SELECT m.title, m.year, m.score, m.votes, p.firstname || ' ' || p.lastname "STARNAME"
    FROM (Performer p JOIN Casting c ON c.movieid = p.id AND c.status='star') JOIN Movie m ON m.id = c.movieid
    ORDER BY m.year
    ;
    
    SELECT title, year, score, votes, starname
    FROM MOVIEANDSTAR mas
    ;
    
    -- b.
        -- i. Base Tables
            -- the base tables are previously defined views, or the view of the physical table at
            -- its lowest form
        -- ii. Join Views
            -- a view that joins two or more base tables or views

        -- iii. Updateable Join Views
            -- a view with joins that allows update, insert and delete operations (generally 
            -- not recommended)

        -- iv. Key Preserved
            -- a table is key preserved if the view(s) containing the table are joined into 
            -- their outer views.
            -- the keys do not necessarily have to be selected for the keys to be preserved
        
        -- v. query modification vs materialization
            -- Query Modification: will take the original view query and fit your query into
            -- that query, which is the original query is very long and expensive (multiple
            -- table joins with huge tables) then this can be very expensive.

            -- Materialization: will run the view query once and perserve the view table for
            -- you. The view table can then have queries run on it and it is very fast,
            -- however, it needs to update every once it while, especially when the tables
            -- joined in the view query are updated. There are a couple different methods
            -- for handling this issue.          
                -- 1. immediate update (most expensive, max reliability): as soon as changes
                    -- are made to the underlying (base) table, immediately rerun the view 
                    --query, updating the view
                
                -- 2. lazy update (more expensive, max reliablility, also annoying): 
                    --when someone wants to run a query on the view, update the view before
                    --the query is ran

                -- 3. periodic update (less expensive, bad-to-decent reliablility depending on 
                    -- how often the update is ran): will update at a set interval determined
                    -- by the user. Whether or not this method is used depends on whether or 
                    -- not a query relys on information being up-to-date and whether old 
                    -- information is acceptable. In this method, a query may get old data.

        -- Note: WITH CHECK OPTION Disallows Insert, Update, Delete

-- Exercise 7.2
    -- a.         
        -- for Movies database    
        PERFORMERCAST <- (CASTING)THETAJOIN_performerid=id(PERFORMER)
        STAR_PERFORMERS <- OMEGA_status='star'(PERFORMERCAST)           
        RESULT <- PI_firstname,lastname(STAR_PERFORMERS)

        
        select firstname, lastname
        from (Casting JOIN Performer ON performerid=p.id AND status='star');

       --from company database (Query 1)
        select fname, lname, address
        from Employees e JOIN Department d ON e.dno=d.dnumber AND dname='Research';

    -- b. 
        select firstname, lastname
        from Performer
        where status='star';
        
        {t.firstname, t.lastname | Performer(t) AND t.status='star'}
        
    -- c.
        -- i.
            -- (universal quantifier t)(F) is TRUE if all of the tuples would evaluate to true for F
            -- not used as much
    
            -- (existential quantifier t)(F) is TRUE if one or more of the tuples would evaluate to true for F
            -- i.e. exists, not exists

        -- ii. an expression is deemed "safe" if it can be shown to return a finite number of values.
            --i.e. not (Movie(t)) will return an infinite amount of tuples outside of Movie.
            -- since the amount of information is expandable and not static, it is unable to be
            -- deemed a safe expression.