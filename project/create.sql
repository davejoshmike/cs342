-- Creates the PersonalFinance user and Database

DROP USER personalfinance CASCADE;
CREATE USER personalfinance
	IDENTIFIED BY BuyMe8
	QUOTA 5M ON System;

GRANT
		CONNECT,
		CREATE TABLE,
		CREATE SESSION,
		CREATE SEQUENCE,
		CREATE VIEW,
		CREATE MATERIALIZED VIEW,
		CREATE PROCEDURE,
		CREATE TRIGGER,
		UNLIMITED TABLESPACE
		to personalfinance;
		
-- Connects
CONNECT personalfinance/BuyMe8

-- Create the database
DEFINE personalfinance=C:\Users\OrangeJuice\Documents\cs342\cs342\project

-- Set up the Oracle directory for the dump database feature.
-- Use Oracle directories for input/output files to avoid permissions problems. (?)
-- This is needed both to create and to load the *.dmp files.
DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\OrangeJuice\Documents\cs342\cs342\project\datapump';
GRANT READ, WRITE ON DIRECTORY exp_dir to personalfinance;

-- Load the database from the dump file using:
-- impdp personalfinance/BuyMe8@localhost parfile=personalfinance.par