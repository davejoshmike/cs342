-- alter SESSION set NLS_DATE_FORMAT = 'YYYY';

-- TAX BRACKETS -- https://www.tax-brackets.org/
-- Michigan income tax
INSERT INTO IncomeTax VALUES (0, 's', 'Michigan', 'single', to_date('2016', 'YYYY'));
INSERT INTO IncomeTax VALUES (1, 's', 'Michigan', 'joint', to_date('2016', 'YYYY'));

INSERT INTO IncomeTaxBracket VALUES (0, 1, 0.0425, 'Y', 0, 5000000000);
INSERT INTO IncomeTaxBracket VALUES (1, 1, 0.0425, 'Y', 0, 5000000000);

-- Illinois income tax
INSERT INTO IncomeTax VALUES (2, 's', 'Illinois', 'single', to_date('2016', 'YYYY'));
INSERT INTO IncomeTax VALUES (3, 's', 'Illinois', 'joint', to_date('2016', 'YYYY'));

INSERT INTO IncomeTaxBracket VALUES (2, 1, 0.0375, 'Y', 0, 5000000000);
INSERT INTO IncomeTaxBracket VALUES (3, 1, 0.0375, 'Y', 0, 5000000000);

-- Indiana income tax
INSERT INTO IncomeTax VALUES (4, 's', 'Indiana', 'single', to_date('2016', 'YYYY'));
INSERT INTO IncomeTax VALUES (5, 's', 'Indiana', 'joint', to_date('2016', 'YYYY'));

INSERT INTO IncomeTaxBracket VALUES (4, 1, 0.033, 'Y', 0, 5000000000);
INSERT INTO IncomeTaxBracket VALUES (5, 1, 0.033, 'Y', 0, 5000000000);

-- Kentucky income tax
-- bmin of tax bracket 2 should be higher than bmin of tax bracket 1
INSERT INTO IncomeTax VALUES (6, 's', 'Kentucky', 'single', to_date('2016', 'YYYY'));
INSERT INTO IncomeTaxBracket VALUES (6, 1, 0.020, 'N', 0.00, 2999.99);
INSERT INTO IncomeTaxBracket VALUES (6, 2, 0.030, 'N', 3000.00, 3999.99);
INSERT INTO IncomeTaxBracket VALUES (6, 3, 0.040, 'N', 4000.00, 4999.99);
INSERT INTO IncomeTaxBracket VALUES (6, 4, 0.050, 'N', 5000.00, 7999.99);
INSERT INTO IncomeTaxBracket VALUES (6, 5, 0.058, 'N', 8000.00, 74999.99);
INSERT INTO IncomeTaxBracket VALUES (6, 6, 0.060, 'N', 75000.00, 5000000000);

INSERT INTO IncomeTax VALUES (7, 's', 'Kentucky', 'joint', to_date('2016', 'YYYY'));
INSERT INTO IncomeTaxBracket VALUES (7, 1, 0.020, 'N', 0.00, 2999.99);
INSERT INTO IncomeTaxBracket VALUES (7, 2, 0.030, 'N', 3000.00, 3999.99);
INSERT INTO IncomeTaxBracket VALUES (7, 3, 0.040, 'N', 4000.00, 4999.99);
INSERT INTO IncomeTaxBracket VALUES (7, 4, 0.050, 'N', 5000.00, 7999.99);
INSERT INTO IncomeTaxBracket VALUES (7, 5, 0.058, 'N', 8000.00, 74999.99);
INSERT INTO IncomeTaxBracket VALUES (7, 6, 0.060, 'N', 75000.00, 5000000000);

-- New York income tax
INSERT INTO IncomeTax VALUES (8, 's', 'New York', 'single', to_date('2016', 'YYYY'));
INSERT INTO IncomeTaxBracket VALUES (8, 1, 0.0400, 'N', 0.00, 8449.99);
INSERT INTO IncomeTaxBracket VALUES (8, 2, 0.0450, 'N', 8450.00, 11649.99);
INSERT INTO IncomeTaxBracket VALUES (8, 3, 0.0525, 'N', 11650.00, 13849.99);
INSERT INTO IncomeTaxBracket VALUES (8, 4, 0.0590, 'N', 13850.00, 21299.99);
INSERT INTO IncomeTaxBracket VALUES (8, 5, 0.0645, 'N', 21300.00, 80149.99);
INSERT INTO IncomeTaxBracket VALUES (8, 6, 0.0665, 'N', 80150.00, 213999.99);
INSERT INTO IncomeTaxBracket VALUES (8, 7, 0.0685, 'N', 214000.00, 1070349.99);
INSERT INTO IncomeTaxBracket VALUES (8, 8, 0.0882, 'N', 1070350.00, 5000000000);

INSERT INTO IncomeTax VALUES (9, 's', 'New York', 'joint', to_date('2016', 'YYYY'));
INSERT INTO IncomeTaxBracket VALUES (9, 1, 0.0400, 'N', 0.00, 17049.99);
INSERT INTO IncomeTaxBracket VALUES (9, 2, 0.0450, 'N', 17050.00, 23490.99);
INSERT INTO IncomeTaxBracket VALUES (9, 3, 0.0525, 'N', 23450.00, 27749.99);
INSERT INTO IncomeTaxBracket VALUES (9, 4, 0.0590, 'N', 27750.00, 42749.99);
INSERT INTO IncomeTaxBracket VALUES (9, 5, 0.0645, 'N', 42750.00, 160499.99);
INSERT INTO IncomeTaxBracket VALUES (9, 6, 0.0665, 'N', 160500.00, 321049.99);
INSERT INTO IncomeTaxBracket VALUES (9, 7, 0.0685, 'N', 321050.00, 2140899.99);
INSERT INTO IncomeTaxBracket VALUES (9, 8, 0.0882, 'N', 2140900.00, 5000000000);

Update IncomeTaxBracket Set bmax=5000000000 where bmax IS NULL;

-- Person
INSERT INTO Person VALUES (0, 'David','Michel','Michigan', 'Grand Rapids', 'single');

-- Tax
INSERT INTO Tax VALUES (0, 'state', 'income', 
    (SELECT itb.rate from incometaxbracket itb where
    (SELECT w.yearlywage FROM wage w WHERE w.personid=0) 
        >= itb.bmin
    AND (SELECT w.yearlywage FROM wage w WHERE w.personid=0)
        <= itb.bmax
    AND itb.id =
    (SELECT it.id 
            FROM IncomeTax it 
            WHERE to_date('2016', 'YYYY') 
                = it.year
            AND (SELECT per.filingtype FROM Person per WHERE per.id=0)
                = it.filingtype
            AND (SELECT state FROM Person WHERE id=0)
                = it.state)),
    to_date('2016', 'YYYY'));

--Note: we know that personId = 0
    --we are grabbing an income tax bracket
    -- where year is 2016, filing type is single,
    -- and the person is from michigan
    --also the persons wage is in the specified tax bracket

SELECT itb.rate from incometaxbracket itb where
    (SELECT w.yearlywage FROM wage w WHERE w.personid=0) 
        >= itb.bmin
    AND (SELECT w.yearlywage FROM wage w WHERE w.personid=0)
        <= itb.bmax
    AND itb.id =
    (SELECT it.id 
            FROM IncomeTax it 
            WHERE to_date('2016', 'YYYY') 
                = it.year
            AND (SELECT per.filingtype FROM Person per WHERE per.id=0)
                = it.filingtype
            AND (SELECT state FROM Person WHERE id=0)
                = it.state);

-- Loan
INSERT INTO Loan VALUES(0,'student', 'Y', .04);
	
INSERT INTO WAGE VALUES (0, 19.00, 30000,0);

-- remember to use constraints: 
    -- date, not null, unique, check, foreign key, cardinality
-- also 
    -- COMPUTED BY columns
-- also 
    -- id integer AUTOMATIC INSERT AS GET_NEW_ID () PRIMARY KEY,
    -- CREATE UNIQUE INDEX Person_Index ON Person(id);

-- Display
SELECT * FROM PERSON
;
SELECT * FROM TAX 
;
Select * FROM LOAN
;
Select * FROM IncomeTax
    ;
