-- alter SESSION set NLS_DATE_FORMAT = 'YYYY';

-- TAX BRACKETS -- https://www.tax-brackets.org/
-- Michigan income tax
INSERT INTO StateTax VALUES ('Michigan', 'single', to_date('2016', 'YYYY'), 0, 0.0425, 'Y', NULL, NULL);
INSERT INTO StateTax VALUES ('Michigan', 'joint', to_date('2016', 'YYYY'), 0, 0.0425,'Y', NULL, NULL);

-- Illinois income tax
INSERT INTO StateTax VALUES ('Illinois', 'single', to_date('2016', 'YYYY'), 0, 0.0375, 'Y', NULL, NULL);
INSERT INTO StateTax VALUES ('Illinois', 'joint', to_date('2016', 'YYYY'), 0, 0.0375,'Y', NULL, NULL);

-- Indiana income tax
INSERT INTO StateTax VALUES ('Indiana', 'single', to_date('2016', 'YYYY'), 0, 0.033, 'Y', NULL, NULL);
INSERT INTO StateTax VALUES ('Indiana', 'joint', to_date('2016', 'YYYY'), 0, 0.033,'Y', NULL, NULL);

-- Kentucky income tax
-- bmin of tax bracket 2 should be higher than bmin of tax bracket 1
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 1, 0.020, 'N', 0.00, 2999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 2, 0.030, 'N', 3000.00, 3999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 3, 0.040, 'N', 4000.00, 4999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 4, 0.050, 'N', 5000.00, 7999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 5, 0.058, 'N', 8000.00, 74999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'single', to_date('2016', 'YYYY'), 6, 0.060, 'N', 75000.00, NULL);

INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 1, 0.020, 'N', 0.00, 2999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 2, 0.030, 'N', 3000.00, 3999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 3, 0.040, 'N', 4000.00, 4999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 4, 0.050, 'N', 5000.00, 7999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 5, 0.058, 'N', 8000.00, 74999.99);
INSERT INTO StateTax VALUES ('Kentucky', 'joint', to_date('2016', 'YYYY'), 6, 0.060, 'N', 75000.00, NULL);

-- New York income tax
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 1, 0.0400, 'N', 0.00, 8449.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 2, 0.0450, 'N', 8450.00, 11649.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 3, 0.0525, 'N', 11650.00, 13849.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 4, 0.0590, 'N', 13850.00, 21299.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 5, 0.0645, 'N', 21300.00, 80149.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 6, 0.0665, 'N', 80150.00, 213999.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 7, 0.0685, 'N', 214000.00, 1070349.99);
INSERT INTO StateTax VALUES ('New York', 'single', to_date('2016', 'YYYY'), 8, 0.0882, 'N', 1070350.00, NULL);

INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 1, 0.0400, 'N', 0.00, 17049.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 2, 0.0450, 'N', 17050.00, 23490.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 3, 0.0525, 'N', 23450.00, 27749.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 4, 0.0590, 'N', 27750.00, 42749.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 5, 0.0645, 'N', 42750.00, 160499.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 6, 0.0665, 'N', 160500.00, 321049.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 7, 0.0685, 'N', 321050.00, 2140899.99);
INSERT INTO StateTax VALUES ('New York', 'joint', to_date('2016', 'YYYY'), 8, 0.0882, 'N', 2140900.00, NULL);

-- Person
INSERT INTO Person VALUES (0, 'David','Michel','Michigan', 'Grand Rapids', 'single');

-- Tax
INSERT INTO Tax VALUES (0, 'state', 'income', (SELECT st.rate FROM StateTax st WHERE to_date('2016', 'YYYY') = st.year
        AND (SELECT p.filingtype FROM Person p WHERE p.id=0) = st.filingtype
        AND (SELECT p.state FROM Person p WHERE p.id=0) = st.state),
    to_date('2016', 'YYYY'));

-- Loan
INSERT INTO Loan VALUES(0,'student', 'Y', .04);
	
-- remember to use constraints: 
    -- date, not null, unique, check, foreign key, cardinality
-- also 
    -- COMPUTED BY columns
-- also 
    -- id integer AUTOMATIC INSERT AS GET_NEW_ID () PRIMARY KEY,
    -- CREATE UNIQUE INDEX Person_Index ON Person(id);

-- Display
SELECT * FROM PERSON WHERE ID=0
;
SELECT * FROM TAX WHERE ID=0
;
Select * FROM LOAN WHERE ID=0
;
