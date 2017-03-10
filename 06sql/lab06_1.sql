-- Exercise 6.1
    --a. Get the names and mandate statements of all teams along with the ID of their “chair” member. If a chair member does not exist, include NULL for the ID.
    select t.name, t.mandate, pt.personid "CHARID"
    from (Team t LEFT OUTER JOIN PersonTeam pt 
        ON pt.role='chair' 
        AND t.name = pt.teamname);      

    -- b.
    select t.name, t.mandate, p.firstname || ' ' || p.lastname FULLNAME, pt.personid "CHARID"
    from (Team t LEFT OUTER JOIN PersonTeam pt 
        ON pt.role='chair' 
        AND t.name = pt.teamname) 
        LEFT OUTER JOIN Person p 
        ON p.id=pt.personid;