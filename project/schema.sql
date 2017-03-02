-- Schema for the personalfinance database
@drop

CREATE TABLE IncomeTax (
    id integer,
    who char(1) CHECK (who IN ('state', 'federal','medicare','medicade', 'social security')) not null,
    state varchar(15) CHECK (state IN ('Michigan', 'Illinois','Indiana','Kentucky','New York')) not null,
    filingtype varchar(15) CHECK (filingtype IN ('single', 'joint', 'head')) not null,
    year date not null,
    PRIMARY KEY (id)
    );
-- PRIMARY KEY (state, filingtype, year, bracketlevel)
-- TODO update this primary key
-- bmax float CHECK (bmax > bmin OR bmax IS NULL),
-- bmax computed by ((select st2.bmin from statetax st1, statetax st2 where st2.bracketlevel=st1.bracketlevel+1 AND st2.state=st1.state AND st2.type=st1.type AND st2.year=st1.year)-.01),

CREATE TABLE IncomeTaxBracket (
    id integer,
    bracketlevel integer CHECK (bracketlevel > 0),
    rate float not null,
    flat char(1) CHECK (flat IN ('Y','N')) not null,
    bmin float,
    bmax float,
    FOREIGN KEY (id) REFERENCES IncomeTax(id),
    PRIMARY KEY (id, bracketlevel)
    );

CREATE TABLE Person (
	id integer PRIMARY KEY,
	firstName varchar(15),
	lastName varchar(15),
	state varchar(15) CHECK (state IN ('Michigan', 'Illinois','Indiana','Kentucky','New York')) not null,
	city varchar(25),
	filingtype varchar(15) CHECK (filingtype in ('single','joint', 'head')) not null
	);
--id integer AUTOMATIC INSERT AS GET_NEW_ID () PRIMARY KEY,
--CREATE UNIQUE INDEX Person_Index ON Person(id);

CREATE TABLE Tax (
	personId integer,
	who varchar(25) CHECK (who IN ('state','medicare','social security','federal')),
	why varchar(25) CHECK (why IN ('income', 'medical')),
	rate float,
	taxyear date,	
	FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
	);
--For rates column:
-- FOREIGN KEY (staterate) REFERENCES StateTaxRate(rate),
-- FOREIGN KEY (fedrate) REFERENCES FederalTaxRate(rate),
-- MedicareTaxRate(rate, taxyear)	

CREATE TABLE Wage (
	personId integer,
	hourlywage float,
	yearlywage float,
	bonus float,
	FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
	);
	-- should a person be able to have more than one wage?
	-- yes probably. 

CREATE TABLE Loan (
    personId integer,
    type varchar(15) CHECK (type IN ('auto','mortgage','student')),
    subsidized char(1) CHECK (subsidized IN ('Y', 'N')),
    monthyrate float,
    FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
    );

CREATE TABLE Savings (
    personId integer,
    monthlyrate float,
    cap float,
    FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
    );
