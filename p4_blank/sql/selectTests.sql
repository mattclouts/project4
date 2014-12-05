-- NOTE:
-- This file performs sanity checks for INSERT and SELECT
-- Since you are testing INSERT using SELECT, you will have
-- to think carefully about the source of your bug.

-- Create relations
CREATE TABLE soaps(soapid integer, name char(32), 
                   network char(4), rating double);

-- Create index on all three datatypes
CREATE INDEX soaps (soapid);
CREATE INDEX soaps (rating);

-- insert with attributes in order
INSERT INTO soaps (soapid, name, network, rating) 
	VALUES (100, 'Gilmore Girls', 'CBS', 9.67);
INSERT INTO soaps (soapid, name, network, rating) 
	VALUES (99, 'Happy', 'NBC', 5.67);


-- insert with attributes out of order:
INSERT INTO soaps (network, rating, name, soapid)
	VALUES ('ABC', 3.35, 'Loving', 101);

-- Test file scan
-- SELECT1
SELECT * FROM soaps;

-- Test Index Select 
-- SELECT2
SELECT * FROM soaps WHERE soaps.soapid = 100;

-- Test to make sure we get a file scan with non-eq 
--SELECT 3
SELECT * FROM soaps WHERE soaps.soapid > 100;
--SELECT 4
SELECT * FROM soaps WHERE soaps.soapid < 100;
--SELECT 5
SELECT * FROM soaps WHERE soaps.soapid <= 100;
--SELECT 6
SELECT * FROM soaps WHERE soaps.soapid >= 100;
--SELECT 7
SELECT * FROM soaps WHERE soaps.soapid <> 100;


-- Test Projections 
--SELECT 8
SELECT soaps.soapid, soaps.name, soaps.network FROM soaps WHERE soaps.soapid = 100;
--SELECT 9
SELECT soaps.soapid, soaps.network FROM soaps WHERE soaps.soapid = 101;
--This one we have a projection that differs from the condition
--SELECT 10
SELECT soaps.name FROM soaps WHERE soaps.soapid = 100;


CREATE TABLE professor(name char(32), overallquality double, 
                   clarity double, easiness double);
--Test select on empty table
--SELECT 11
SELECT * FROM professor;

INSERT INTO professor(name, overallquality, clarity, easiness)
	VALUES ('Atul Prakash', 5.0, 5.0, 2.0);
--SELECT nothing
--SELECT 12
SELECT professor.name FROM professor WHERE professor.clarity < 3.0;

--SELECT Atul
--SELECT 13
SELECT professor.name FROM professor WHERE professor.overallquality = 5.0;

DROP TABLE professor;
DROP TABLE soaps;
