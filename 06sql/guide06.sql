-- Inner Join
-- Select the movies that harrison ford was the star 
    SELECT title, year, score
    FROM ((Casting JOIN Performer ON performerId=id 
            AND status='star' 
            AND firstName='Harrison' 
            AND lastName='Ford')
        JOIN Movie m ON movieId=m.id)
    ;

-- Outer Join
    select *
        from (casting c LEFT OUTER JOIN movie m on c.movieid = m.id)
        ;

    select *
        from (casting c RIGHT OUTER JOIN movie m on c.movieid = m.id)
        ;

-- Aggregate
    -- Oldest Movie
    select min(year)
        from movie
        ;

    -- Best Rated Movie
    select max(score)
        from movie
        ;

    -- Avg score
    select avg(score)
        from movie
        ;

-- Grouping
    select count(*)
        from casting
        group by performerid
        ;