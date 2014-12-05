-- create relations
CREATE TABLE stars(starid integer, real_name char(20), 
                   plays char(12), soapid integer);

--
-- Insert Test w/o indices
-- 

-- Insert with attributes in order:
--INSERT 1
INSERT INTO stars(starid, real_name, plays, soapid) 
	VALUES (1, 'Graham, Laura', 'Lorelei', 100);

-- Run a simple SELECT
SELECT * FROM stars;

-- Insert with attributes out of order:
--INSERT 2
INSERT INTO stars (real_name, soapid, starid, plays) 
	VALUES ('Bonarrigo, Laura', 3, 101, 'Cassie');

-- Run a simple SELECT
SELECT * FROM stars;

-- Test relcat and attrcat are up to date
SELECT * FROM relcat;
SELECT * FROM attrcat;

-- Test error checking, with an insert without all fields
--INSERT 3
INSERT INTO stars(real_name, soapid, starid)
	VALUES ('Cloutier, Matthew', 3, 212);

--Should be unchanged from before
SELECT * FROM stars;

DROP TABLE stars;

