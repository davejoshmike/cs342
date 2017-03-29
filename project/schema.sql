-- Schema for the personalfinance database
@drop

CREATE TABLE State (
    state varchar(15) PRIMARY KEY
    );

CREATE TABLE TaxYear (
    year date PRIMARY KEY CHECK (year>to_date('01-JAN-1900','DD-MON-YYYY'))
    );

CREATE TABLE IncomeTax (
    id integer,
    type varchar(15) CHECK (type IN ('state', 'federal','medicare','medicade', 'social security')) not null,
    state varchar(15) not null,
    filingType varchar(15) CHECK (filingType IN ('single', 'joint', 'head')) not null,
    flat char(1) CHECK (flat IN ('Y','N')) not null,
    year date not null,
    FOREIGN KEY (state) REFERENCES State(state),
    FOREIGN KEY (year) REFERENCES TaxYear(year),
    PRIMARY KEY (id)
    );
-- PRIMARY KEY (state, filingtype, year, bracketlevel)
-- TODO update this primary key
-- bmax float CHECK (bmax > bmin OR bmax IS NULL),
-- bmax computed by ((select st2.bmin from statetax st1, statetax st2 where st2.bracketlevel=st1.bracketlevel+1 AND st2.state=st1.state AND st2.type=st1.type AND st2.year=st1.year)-.01),

-- REMOVED in favor of a state table
-- state varchar(15) CHECK (state IN ('Michigan', 'Illinois','Indiana','Kentucky','New York')) not null,


CREATE TABLE IncomeTaxBracket (
    id integer,
    bracketLevel integer CHECK (bracketLevel > 0),
    rate float not null,
    bmin float,
    bmax float,
    FOREIGN KEY (id) REFERENCES IncomeTax(id),
    PRIMARY KEY (id, bracketLevel)
    );

CREATE TABLE Person (
	id integer PRIMARY KEY,
	firstName varchar(15),
	lastName varchar(15),
	state varchar(15) not null,
	city varchar(25),
	filingType varchar(15) CHECK (filingType in ('single','joint', 'head')) not null,
	FOREIGN KEY (state) REFERENCES State(state)
    );
--id integer AUTOMATIC INSERT AS GET_NEW_ID () PRIMARY KEY,
--CREATE UNIQUE INDEX Person_Index ON Person(id);

CREATE TABLE Tax (
	personId integer,
	who varchar(25) CHECK (who IN ('state','medicare','social security','federal')),
	why varchar(25) CHECK (why IN ('income', 'medical')),
	rate float,
	taxYear date not null,	
	FOREIGN KEY (personId) REFERENCES Person(ID),
    FOREIGN KEY (taxYear) REFERENCES TaxYear(year),
    PRIMARY KEY (personId)
	);
--For rates column:
-- FOREIGN KEY (staterate) REFERENCES StateTaxRate(rate),
-- FOREIGN KEY (fedrate) REFERENCES FederalTaxRate(rate),
-- MedicareTaxRate(rate, taxyear)	

CREATE TABLE Wage (
	personId integer,
	hourlyWage float,
	yearlyWage float,
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
    monthlyRate float,
    FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
    );

CREATE TABLE Savings (
    personId integer,
    monthlyRate float,
    cap float,
    FOREIGN KEY (personId) REFERENCES Person(ID),
    PRIMARY KEY (personId)
    );
