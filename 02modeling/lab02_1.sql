-- Try adding records to the movie relation that cause these intra-relation issues:
	-- i. repeated primary key value
		insert into movie values (1, 'The Empire Strikes Back', 1979, 9.1);
		-- Error: unique constraint violated.
		-- if a table has an entry with more than one primary key, it will not be able to distinguish an entry, since there is not a unique identifier

	-- ii. NULL primary key value
		insert into movie values (NULL, 'The Kid', 1921, 8.3);
		-- Error: cannot insert NULL
		-- same reason as above, not being able to distinguish an entry, as there is not a unique identifier

	-- iii. violation of a CHECK constraint
		alter table Movie
		add check (Score>9);
		-- Error: check constraint violated
		-- the check constraints are there to help normalize your data and make it consistent with the standards you set

	-- iv. violation of an SQL datatype constraint
		insert into movie values (3, 'The Kid', 1921, '~8.5');
		-- Error: invalid number
		-- oracle does a really good job with type cohercion, which is kind of scary to me
		-- i.e insert into movie values (3.5, 743714, 1921.0, '8.5');
		-- ^this query still runs fine, converting float to int, int to string, float to decimal, and string to float

	-- v. negative score value
		insert into movie values (4, 'The Kid', 1921, -8.5);
		-- It works fine. there are no constraints on the score value

