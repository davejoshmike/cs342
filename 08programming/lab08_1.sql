-------------------------------------------------------------------------------------
-- Exercise 8.1:
-- implement the ability to allow programmers to cast a new actor (by id) to a movie 
-- (by ID). 
-- restrictions:
--		An actor can't be cast in multiple rows in the same movie
--		A movie can't have more than 230 castings
-------------------------------------------------------------------------------------
		
-- TRIGGER
CREATE OR REPLACE TRIGGER cast_actor_trigger 
	BEFORE INSERT OR UPDATE ON Role FOR EACH ROW
	DECLARE
		PROCEDURE check_multi_roles (actorID NUMBER, movieID NUMBER, role VARCHAR2)
			IS
				actorExist NUMBER(38);
				tooManyRoles EXCEPTION;
			BEGIN
				-- actors can't be cast more than once
				-- fk constraint: actorID, movieID, Role is primary key
				SELECT count(*) INTO actorExist
				FROM ROLE
				WHERE ActorID = actorID
				AND MovieID = movieID
				AND Role = role;
				
				IF actorExist > 0
				THEN
					--throw error
					RAISE tooManyRoles;
				END IF;
				EXCEPTION
					WHEN tooManyRoles
					THEN
						RAISE_APPLICATION_ERROR(-20002, 'Duplicate Role: Actor cant be cast more than once in the same movie');
			END;
		
		PROCEDURE check_castings (movieID NUMBER) 
			IS
				castingLimit CONSTANT NUMBER(3) := 230;
				castingAmt NUMBER(38);
				tooManyCastings EXCEPTION;
			BEGIN
				SELECT count(*) INTO castingAmt
				FROM Role
				WHERE MovieID = movieID;
				
			IF castingAmt > castingLimit
			THEN
				RAISE tooManyCastings;
			END IF;
			
			EXCEPTION 
				WHEN tooManyCastings
				THEN
					RAISE_APPLICATION_ERROR(-20001, 'Movie Full: Casting limit reached.');
			END;
----------------------
-- Start of Trigger --
----------------------
	BEGIN
		-- Insert
		IF (INSERTING OR UPDATING)
		THEN
            -- Note: EXECUTE is sql*plus syntax, not PLSQL
			check_castings(:new.movieID);
			check_multi_roles(:new.actorID, :new.movieID, :new.role);
		END IF;
	END;
/
	
-- Cast actor into role
CREATE OR REPLACE PROCEDURE cast_actor (actorID NUMBER, movieID NUMBER, role VARCHAR2)
	IS
	BEGIN		
		INSERT INTO Role (actorID, movieID, role) VALUES (actorID, movieID, role);
	END;
/

------------------
-- main program --
------------------
DECLARE	
-- nothing to declare
BEGIN
	-- a. Cast George Clooney (# 89558) as Danny Ocean' in Oceans Eleven (#238072). N.b., he’s already cast in this movie
	cast_actor(89558, 238072, 'Danny Ocean');
    -- Error: Duplicate Cast 

	-- b. Cast George Clooney as 'Danny Ocean' in Oceans Twelve (#238073). N.b., he’s not currently cast in this movie.
	cast_actor(89558, 238073, 'Danny Ocean');

	-- c. Cast George Clooney as 'Danny Ocean' in JFK (#167324). N.b., this movie already has 230 castings.
	cast_actor(89558, 167324, 'Danny Ocean');
    -- Error: Movie Full: Casting limit reached.
END;
/