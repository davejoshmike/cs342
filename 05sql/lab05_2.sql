-- Exercise 5.2
-- a.
    SELECT * FROM PERSON WHERE BIRTHDATE IS NOT NULL AND ROWNUM <=1 ORDER BY To_char(BIRTHDATE, 'YYYY') DESC;
    --incomplete
	SELECT * FROM PERSON WHERE to_char(BIRTHDATE, 'YYYY')=(SELECT Min(to_char(Birthdate,'YYYY')) from person) AND ROWNUM <=1;
	
-- b.
    select DISTINCT p1.FIRSTNAME, p1.id, p1.LASTNAME, p2.id, p2.LASTNAME from Person p1, Person p2 WHERE p1.FIRSTNAME = p2.FIRSTNAME AND p1.id <> p2.id; 
    -- incomplete   
	
--c.
    select p.FIRSTNAME||' '||p.LASTNAME, pt.TEAMNAME from PERSON p, PERSONTEAM pt, TEAM t where p.id=pt.personid AND pt.TEAMNAME='Music' AND p.homegroupid<>(select p.homegroupid from homegroup h where p.homegroupid = h.id AND h.NAME='Byl');
    
	-- incomplete
