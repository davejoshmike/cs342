-- Exercise 9.1
SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;

	-- a. there is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting queries. 
		select count(1) from movie;
		select count(*) from movie;
		select sum(1) from movie;
		-- there is no difference between count(1), count(*) or sum(1). Both have the same amount of
		-- consistent gets, bytes sent and bytes received and rows processed
		
	-- b. the order of the tables listed in the FROM clause affects the way Oracle executes a join query.
		-- 00:00:00.05 sec faster
		SET AUTOTRACE TRACEONLY;
		select * from (Movie JOIN MovieDirector ON id=movieId);
		-- did 50 recursive calls
		-- did 4 sorts (memory)
		-- 00:00:01.02 sec
		
		select * from (MovieDirector JOIN Movie ON id=movieId);		
		-- did 1 recursive call
		-- did no sorts (memory)
		-- 00:00:01.07 sec
		
		-- select cost 1884
			--join cost 1884
				-- table access full cost 215
				-- table access full cost 498
	
	
	-- c. the use of arithmetic expressions in join conditions 
	-- (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) 
	-- affects a query’s efficiency. 
	-- without arithmetic expression
	-- 00.00 sec
	select count(*) from Movie JOIN MovieDirector ON Movie.id=MovieDirector.movieid;

	-- with arithmetic expression
	-- 00.18 sec
	-- plan:
	-- has an extra
	-- hash join
	--	index fast full scan using the sys_c007056 index
	
	-- stats:
	--	double the amount of consisten gets than the above query
	
	select count(*) from Movie JOIN MovieDirector ON Movie.id+0=MovieDirector.movieid+0;
	
	
	-- d.
	select count(*) from Actor;
	select count(*) from Actor;
	select count(*) from Actor;
	-- all subsequent calls after the first call have one less recursive call,
	-- meaning that the data is cached