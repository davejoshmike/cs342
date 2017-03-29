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