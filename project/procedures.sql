-- Create taxrate materialized view procedure
-- This mat view gets the tax rate from the incometax/incometaxbracket 
-- table based on a Person's yearly wage and year/type/state
CREATE OR REPLACE PROCEDURE PERSONALFINANCE.CreateTaxRateView 
AS
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW TaxRate';
        EXCEPTION 
            WHEN OTHERS THEN
                NULL;
    END;
    EXECUTE IMMEDIATE 'CREATE MATERIALIZED VIEW TaxRate AS
        (SELECT p.id "PERSONID", itb.rate 
                FROM (incometaxbracket itb JOIN (Person p JOIN Wage w ON p.id=w.personId) 
                    ON w.yearlywage >= itb.bmin AND w.yearlywage <= itb.bmax)
                WHERE itb.id =
                    (SELECT it.id 
                        FROM IncomeTax it 
                        WHERE 2016 = it.year
                        AND p.filingType = it.filingtype
                        AND p.state = it.state)
    )';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Compute/Get the Rate for everyone in the Person table,
-- upserting the rate into the tax table given the who, 
-- why and year to compute the rate for.
CREATE OR REPLACE PROCEDURE PopulateTaxTable(who VARCHAR2, why VARCHAR2, year NUMBER)
IS
    CURSOR personids IS
        SELECT id FROM Person;
    computedRate NUMBER;
BEGIN
    FOR id in personids
    LOOP    
        SELECT itb.rate INTO computedRate
        FROM (incometaxbracket itb JOIN (Person p JOIN Wage w ON id.id=w.personId) 
            ON w.yearlywage >= itb.bmin
            AND w.yearlywage <= itb.bmax)
        WHERE itb.id =
            (SELECT it.id 
                FROM IncomeTax it 
                WHERE 2016 = it.year
                AND p.filingType = it.filingtype
                AND p.state = it.state);
    
        IF (computedRate IS NOT NULL) THEN
            -- upsert logic
            BEGIN 
                INSERT INTO Tax (personid, who, why, rate, taxyear) 
                VALUES (id.id, PopulateTaxTable.who, PopulateTaxTable.why, computedRate, PopulateTaxTable.year);
            EXCEPTION
                WHEN OTHERS THEN
                    UPDATE Tax SET WHO=PopulateTaxTable.who, WHY=PopulateTaxTable.why, Rate=computedRate, TaxYear=PopulateTaxTable.year 
                    WHERE personid=id.id;
            END;
        END IF;
    END LOOP;
END;
/

-- Compute/Get the Rate for a single person based on yearly wage and income tax brackets
CREATE OR REPLACE PROCEDURE ComputePersonTaxRate(id NUMBER, who VARCHAR2, why VARCHAR2, year NUMBER)
IS
    computedRate NUMBER;
BEGIN
    SELECT itb.rate INTO computedRate
    FROM (incometaxbracket itb JOIN (Person p JOIN Wage w ON ComputePersonTaxRate.id=w.personId) 
        ON w.yearlywage >= itb.bmin
        AND w.yearlywage <= itb.bmax)
    WHERE itb.id =
        (SELECT it.id 
            FROM IncomeTax it 
            WHERE 2016 = it.year
            AND p.filingType = it.filingtype
            AND p.state = it.state);

    -- upsert logic
    IF (computedRate IS NOT NULL) THEN
        BEGIN 
            INSERT INTO Tax (personid, who, why, rate, taxyear) 
            VALUES (ComputePersonTaxRate.id, ComputePersonTaxRate.who, ComputePersonTaxRate.why, computedRate, ComputePersonTaxRate.year);
        EXCEPTION
            WHEN OTHERS THEN
                UPDATE Tax SET WHO=ComputePersonTaxRate.who, WHY=ComputePersonTaxRate.why, Rate=computedRate, TaxYear=ComputePersonTaxRate.year 
                WHERE personid=ComputePersonTaxRate.id;
        END;
    END IF;
END;
/

-- Project Deliverable 4 (Application):	
	-- procedure.sql 
        -- X stored proc that implements a multi-step transaction (i.e. more than one commit)

    -- trigger.sql
        -- trigger that enforces integrity constraint (i.e. something that is not easy to implement using normal table constraints)
	
	-- optimizations.txt
        -- 1. make a copy of a complex query
		-- 2. explain why the query is appropriate
		-- 3. add/explain which indexes you use
		-- 4. explain which optimizaitons you've made
		
	-- personalFinance.dmp/par 
        -- make a datapump loader that:
            -- 1. loads the database
            -- 2. runs the database queries
    
    -- create.sql
        -- 1. build a dmbs user
        -- 2. define dump directory
	