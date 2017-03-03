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

-- Person
-- data generated from: http://generatedata.com/
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (0, 'David','Michel','Michigan', 'Grand Rapids', 'single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (1,'Darius','Martin','Kentucky','Hofheim am Taunus','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (2,'Alec','Ferrell','Kentucky','Hoogstraten','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (3,'Kyle','Hayden','New York','Donstiennes','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (4,'Nathaniel','Burris','Indiana','New Westminster','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (5,'Kim','Colon','Kentucky','Tregaron', 'single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (6,'Francesca','Carpenter','New York','Hamilton','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (7,'Armando','Atkinson','Michigan','Mödling','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (8,'Raven','Garza','Indiana','Bahawalpur','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (9,'Jarrod','Haynes','Indiana','Tucapel','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (10,'Clark','Blanchard','New York','Pastena','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (11,'Cadman','Fernandez','Michigan','Gretna','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (12,'Lysandra','Wise','Kentucky','Scarborough','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (13,'Tarik','Hines','Michigan','March','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (14,'Nevada','Duran','Michigan','Wiener Neustadt','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (15,'Yoshi','Montoya','Kentucky','Molina','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (16,'Cheyenne','Brady','Michigan','Cannalonga','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (17,'Signe','Larsen','Michigan','Vancouver','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (18,'Allistair','William','Michigan','IJlst','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (19,'Gail','Frederick','Michigan','Söderhamn','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (20,'Andrew','Patterson','New York','Villers-sur-Semois','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (21,'May','Vasquez','Kentucky','Poitiers','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (22,'Illiana','Anthony','Kentucky','Bochum','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (23,'Dominic','Oneil','New York','Sachs Harbour','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (24,'Tamekah','Cline','Michigan','Gatineau','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (25,'Unity','Mercado','New York','Ourense','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (26,'Macon','Lindsey','Kentucky','Montrose','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (27,'Imani','Gentry','Illinois','Joondalup','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (28,'Jelani','Odonnell','New York','Bilbo','joint');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (29,'Avye','Herring','Illinois','Dubuisson','single');
INSERT INTO Person (Id,firstname,lastname,state,city,filingtype) VALUES (30,'Moses','Owen','New York','Westkerke','joint');


-- Tax
INSERT INTO Tax VALUES (0, 'state', 'income', 
    (SELECT itb.rate FROM incometaxbracket itb WHERE
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

-- Loan
INSERT INTO Loan VALUES(0,'student', 'Y', .04);
	
INSERT INTO WAGE VALUES (0, 19.00, 30000,0);
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (1,10,53018,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (2,133,48344,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (3,82,97643,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (4,42,70966,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (5,69,73509,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (6,125,41713,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (7,146,56679,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (8,62,36959,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (9,24,72384,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (10,109,15502,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (11,127,92783,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (12,112,10764,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (13,48,98817,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (14,105,85190,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (15,4,76377,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (16,15,1985,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (17,5,15057,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (18,96,27900,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (19,91,20454,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (20,10,25201,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (21,128,91458,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (22,108,79927,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (23,100,74461,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (24,121,34948,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (25,33,34941,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (26,83,92603,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (27,144,92778,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (28,5,58828,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (29,77,66521,'NULL');
INSERT INTO Wage (Id,hourlywage,yearlywage,bonus) VALUES (30,24,51718,'NULL');

-- remember to use constraints: 
    -- date, not null, unique, check, foreign key, cardinality
-- also 
    -- COMPUTED BY columns
-- also 
    -- id integer AUTOMATIC INSERT AS GET_NEW_ID () PRIMARY KEY,
    -- CREATE UNIQUE INDEX Person_Index ON Person(id);

-- Display
-- SELECT * FROM PERSON;
-- SELECT * FROM TAX ;
-- Select * FROM LOAN;
-- Select * FROM IncomeTax;

-- Note: we know that personId = 0
-- we are grabbing the rate of an income tax bracket
-- where year is 2016
-- and filing type is single,
-- and the person is from michigan
-- and the persons wage falls in the specified tax bracket

-- SELECT itb.rate from incometaxbracket itb where
    -- (SELECT w.yearlywage FROM wage w WHERE w.personid=0) 
        -- >= itb.bmin
    -- AND (SELECT w.yearlywage FROM wage w WHERE w.personid=0)
        -- <= itb.bmax
    -- AND itb.id =
    -- (SELECT it.id 
            -- FROM IncomeTax it 
            -- WHERE to_date('2016', 'YYYY') 
                -- = it.year
            -- AND (SELECT per.filingtype FROM Person per WHERE per.id=0)
                -- = it.filingtype
            -- AND (SELECT state FROM Person WHERE id=0)
                -- = it.state);