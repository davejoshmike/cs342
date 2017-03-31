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
	AFTER INSERT OR UPDATE ON Role FOR EACH ROW
	DECLARE
		PROCEDURE check_multi_roles (actorID NUMBER, movieID NUMBER, role VARCHAR2(100))
			AS
				actorExist NUMBER;
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
						DBMS_OUTPUT.PUT_LINE("Duplicate Role: Actor can't be cast more than once in the same movie");
						RAISE_APPLICATION_ERROR(-20001);
			END;
		
		PROCEDURE check_castings (movieID NUMBER) 
			AS
				castingLimit NUMBER := 230;
				castingAmt NUMBER;
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
					DBMS_OUTPUT.PUT_LINE("Movie Full: Casting limit reached.");
					RAISE_APPLICATION_ERROR(-20001,);
			END;
----------------------
-- Start of Trigger --
----------------------
	BEGIN
		-- Insert
		IF (INSERTING OR UPDATING)
		THEN
			EXECUTE check_castings(:new.movieID);
			EXECUTE check_multi_roles(:new.actorID, :new.movieID, :new.role);
		END IF;
	END;
/
	
-- Cast actor into role
CREATE OR REPLACE PROCEDURE cast_actor (actorID NUMBER(38), movieID NUMBER(38), role VARCHAR2(100))
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
	-- a. Cast George Clooney (# 89558) as “Danny Ocean” in Oceans Eleven (#238072). N.b., he’s already cast in this movie
	EXECUTE cast_actor(89558, 238072, "Danny Ocean");

	-- b. Cast George Clooney as “Danny Ocean” in Oceans Twelve (#238073). N.b., he’s not currently cast in this movie.
	EXECUTE cast_actor(89558, 238073, "Danny Ocean");

	-- c. Cast George Clooney as “Danny Ocean” in JFK (#167324). N.b., this movie already has 230 castings.
	EXECUTE cast_actor(89558, 167324, "Danny Ocean");
END;
/