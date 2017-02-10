-- Try adding records to the movie relation that cause these intra-relation issues:
	-- i. repeated primary key value
		insert into movie values (1, 'The Empire Strikes Back', 1979, 9.1, 2000);
		-- Error: unique constraint violated.
		-- if a table has an entry with more than one primary key, it will not be able to distinguish an entry, since there is not a unique identifier

	-- ii. NULL primary key value
		insert into movie values (NULL, 'The Kid', 1921, 8.3, 3000);
		-- Error: cannot insert NULL
		-- same reason as above, not being able to distinguish an entry, as there is not a unique identifier

	-- iii. violation of a CHECK constraint
		alter table Movie
		add check (Score>9);
		-- Error: check constraint violated
		-- the check constraints are there to help normalize your data and make it consistent with the standards you set

	-- iv. violation of an SQL datatype constraint
		insert into movie values (3, 'The Kid', 1921, '~$8.5', 3000);
		-- Error: invalid number
		-- oracle does a really good job with type cohercion, which is kind of scary to me
		-- i.e insert into movie values (3.5, 743714, 1921.0, '8.5', '3000.0');
		-- ^this query still runs fine, converting float to int, int to string, float to decimal, string to float, and string to float to int

	-- v. negative score value
		insert into movie values (3, 'The Kid', 1921, -8.5, 3000);
		-- lets you add a negative score since there are no constraints on the score value

-- b. Try adding records that cause these inter-relation issues:

		-- i. new record with a NULL value for a foreign key value	
		insert into Casting values (2, NULL, 'extra');
		-- lets you add a null foreign key value
		
		-- ii. a foreign key value in a referencing (aka child) table that doesn’t match any key value in the referenced (aka parent) table
		insert into Casting values (3, 5, 'star');
		-- Error: integrity constraint. while the database will let you have a null foreign key, when you set the key it has to be to a real parent value
		
		-- iii. a key value in a referenced table with no related records in the referencing table
		insert into Performer (5, 'Charlie Chaplin');
		-- lets you create it just fine.
		
	-- c. Try deleting/modifying records as follows:
		-- i. Delete a referenced record that is referenced by a referencing record.
		delete from movie where Title='Star Wars';
		-- it deletes successfully, also removing every record that referenced it with a foreign key.
		
		-- ii. Delete a referencing record that references a referenced record.
		delete from casting where Status='star' and performerid=1 and movieid=2;
		-- only the record deleted is changed or affected.
		
		-- iii. Modify the ID of a movie record that is referenced by a casting record.
		update movie set id=5 where id=2;
		-- Error: integrity constraint violated - child record found. An id referenced by a foreign key cannot be changed unless the child record is changed first