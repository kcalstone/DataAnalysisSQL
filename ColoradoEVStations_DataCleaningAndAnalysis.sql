SELECT *
FROM ColoradoData.alternative_fuels_and_ev_stationloc;

-- duplicating table to not alter raw data
CREATE TABLE ev_loc_staging
LIKE alternative_fuels_and_ev_stationloc;

-- checking table was created 
SELECT *
FROM ev_loc_staging;

-- table was created, now inserting data
INSERT ev_loc_staging
SELECT *
FROM alternative_fuels_and_ev_stationloc;

-- run to check data was inserted, confirmed all is correct
SELECT *
FROM ev_loc_staging;

-- check for duplicates
SELECT DISTINCT 'ID'
FROM ev_loc_staging;
-- no duplicates found by ID number

-- standardize text for stationName
SELECT stationName, UPPER(stationName)
FROM ev_loc_staging;

-- updating values to upper
UPDATE ev_loc_staging
SET stationName = UPPER(stationName);

-- run it to check update applied
SELECT stationName
FROM ev_loc_staging;
-- all caps standardization applied correctly

SELECT *
FROM ev_loc_staging;

-- sorting by openDate ASC
-- business question: focus on older stations that may need addt'l maintenance
SELECT openDate
FROM ev_loc_staging
ORDER BY openDate ASC;
-- the data returns wrong because it reads month as open date, regardless of the year

-- reformat to read yyyy/mm/dd and then try ASC order
SELECT openDate,
STR_TO_DATE(openDate, '%m/%d/%Y')
FROM ev_loc_staging;

-- update change to format with year first
UPDATE ev_loc_staging
SET openDate = STR_TO_DATE(openDate, '%m/%d/%Y');

-- openDate now correctly shows ascending order of station open date
SELECT openDate
FROM ev_loc_staging
ORDER BY openDate ASC;

-- one more look at the whole table to make sure everything looks correct
SELECT *
FROM ev_loc_staging;


