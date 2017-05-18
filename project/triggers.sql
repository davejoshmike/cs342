-- Enforces IncomeTax to only use valid years
CREATE OR REPLACE TRIGGER ValidateYears
    BEFORE UPDATE OR INSERT ON IncomeTax
    REFERENCING NEW AS new
    FOR EACH ROW
DECLARE
    year NUMBER;
    year_not_found EXCEPTION;
BEGIN
    -- make sure year inserted or updated is in the taxyear table
    (SELECT year into ValidateYears.year FROM TAXYEAR WHERE year = new.year);
    IF (ValidateYears.year IS NULL) THEN
        RAISE year_not_found;
    EXCEPTION
        WHEN year_not_found THEN
            RAISE_APPLICATION_ERROR(-20001, 'Invalid Year.');
END;
/

-- calls ComputePersonTaxRate Procedure to recompute the taxrate in the Tax table
-- when any wage or location changes
CREATE OR REPLACE TRIGGER UpdateTaxRate
    AFTER INSERT ON Person
    REFERENCING OLD AS old NEW AS new
    FOR EACH ROW
DECLARE
       CURSOR tax IS
        SELECT * FROM Tax WHERE personid=new.id;
BEGIN
    ComputePersonTaxRate(tax.id, tax.who, tax.why, tax.year);
END;
/
