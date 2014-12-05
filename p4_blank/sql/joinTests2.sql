-- Create the Datamations type of relations (note these tuples are smaller than that 
--  speficied in the Datamation benchmark).

-- NOTE:
-- 1. The queries are at the bottom of the file
-- 2. Be sure have tested SELECT and INSERT before testing the joins
-- 3. This test is by no means comprehensive 


CREATE TABLE DA (serial INTEGER, ikey INTEGER, filler CHAR(80), dkey DOUBLE);
CREATE TABLE DB (serial INTEGER, ikey INTEGER, filler CHAR(80), dkey DOUBLE);

-- load 100 tuples into the DA table
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (0, 11618, '00000 string record',  0.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (1, 15378, '00001 string record',  1.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (2, 17233, '00002 string record',  2.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (3, 19052, '00003 string record',  3.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (4, 24069, '00004 string record',  4.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (5, 17188, '00005 string record',  5.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (6, 28769, '00006 string record',  6.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (7, 15168, '00007 string record',  7.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (8, 578, '00008 string record',  8.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (9, 21055, '00009 string record',  9.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (10, 7648, '00010 string record', 11.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (11, 10153, '00011 string record', 12.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (12, 31851, '00012 string record', 13.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (13, 25573, '00013 string record', 14.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (14, 23765, '00014 string record', 15.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (15, 8758, '00015 string record', 16.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (16, 18243, '00016 string record', 17.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (17, 26285, '00017 string record', 18.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (18, 32157, '00018 string record', 19.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (19, 21879, '00019 string record', 20.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (20, 27960, '00020 string record', 22.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (21, 18894, '00021 string record', 23.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (22, 3976, '00022 string record', 24.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (23, 24943, '00023 string record', 25.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (24, 14177, '00024 string record', 26.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (25, 18028, '00025 string record', 27.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (26, 15920, '00026 string record', 28.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (27, 9143, '00027 string record', 29.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (28, 20534, '00028 string record', 30.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (29, 29094, '00029 string record', 31.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (30, 10397, '00030 string record', 33.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (31, 22130, '00031 string record', 34.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (32, 22033, '00032 string record', 35.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (33, 25436, '00033 string record', 36.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (34, 3610, '00034 string record', 37.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (35, 12788, '00035 string record', 38.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (36, 6504, '00036 string record', 39.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (37, 32193, '00037 string record', 40.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (38, 27861, '00038 string record', 41.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (39, 32049, '00039 string record', 42.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (40, 65, '00040 string record', 44.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (41, 8612, '00041 string record', 45.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (42, 28218, '00042 string record', 46.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (43, 14567, '00043 string record', 47.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (44, 23696, '00044 string record', 48.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (45, 23421, '00045 string record', 49.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (46, 15628, '00046 string record', 50.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (47, 20875, '00047 string record', 51.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (48, 31859, '00048 string record', 52.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (49, 21818, '00049 string record', 53.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (50, 8520, '00050 string record', 55.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (51, 1013, '00051 string record', 56.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (52, 2219, '00052 string record', 57.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (53, 6343, '00053 string record', 58.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (54, 32185, '00054 string record', 59.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (55, 24778, '00055 string record', 60.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (56, 21758, '00056 string record', 61.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (57, 28512, '00057 string record', 62.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (58, 2906, '00058 string record', 63.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (59, 6829, '00059 string record', 64.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (60, 4978, '00060 string record', 66.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (61, 27030, '00061 string record', 67.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (62, 28272, '00062 string record', 68.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (63, 2853, '00063 string record', 69.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (64, 21711, '00064 string record', 70.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (65, 23586, '00065 string record', 71.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (66, 356, '00066 string record', 72.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (67, 6732, '00067 string record', 73.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (68, 5337, '00068 string record', 74.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (69, 23917, '00069 string record', 75.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (70, 29025, '00070 string record', 77.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (71, 30013, '00071 string record', 78.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (72, 20042, '00072 string record', 79.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (73, 4059, '00073 string record', 80.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (74, 2226, '00074 string record', 81.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (75, 16187, '00075 string record', 82.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (76, 21137, '00076 string record', 83.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (77, 17627, '00077 string record', 84.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (78, 17113, '00078 string record', 85.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (79, 10658, '00079 string record', 86.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (80, 24909, '00080 string record', 88.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (81, 17583, '00081 string record', 89.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (82, 1646, '00082 string record', 90.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (83, 7822, '00083 string record', 91.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (84, 15240, '00084 string record', 92.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (85, 18172, '00085 string record', 93.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (86, 8382, '00086 string record', 94.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (87, 97, '00087 string record', 95.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (88, 11955, '00088 string record', 96.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (89, 26641, '00089 string record', 97.9);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (90, 24351, '00090 string record', 99.0);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (91, 3973, '00091 string record', 100.1);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (92, 21349, '00092 string record', 101.2);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (93, 9975, '00093 string record', 102.3);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (94, 25108, '00094 string record', 103.4);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (95, 12837, '00095 string record', 104.5);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (96, 31700, '00096 string record', 105.6);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (97, 14397, '00097 string record', 106.7);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (98, 1574, '00098 string record', 107.8);
INSERT INTO DA (serial, ikey, filler, dkey) VALUES (99, 17676, '00099 string record', 108.9);

-- load 102 tuples into the DB table
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (0, 23798, '00000 string record',  0.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (1, 24529, '00001 string record',  1.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (2, 1440, '00002 string record',  2.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (3, 20441, '00003 string record',  3.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (4, 8210, '00004 string record',  4.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (5, 31830, '00005 string record',  5.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (6, 18816, '00006 string record',  6.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (7, 22849, '00007 string record',  7.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (8, 28448, '00008 string record',  8.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (9, 27189, '00009 string record',  9.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (10, 1479, '00010 string record', 11.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (11, 15016, '00011 string record', 12.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (12, 2632, '00012 string record', 13.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (13, 8696, '00013 string record', 14.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (14, 20075, '00014 string record', 15.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (15, 30886, '00015 string record', 16.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (16, 18654, '00016 string record', 17.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (17, 32734, '00017 string record', 18.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (18, 28521, '00018 string record', 19.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (18, 28521, '00018 string record', 19.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (18, 28521, '00018 string record', 19.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (19, 7696, '00019 string record', 20.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (20, 16717, '00020 string record', 22.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (21, 11093, '00021 string record', 23.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (22, 17557, '00022 string record', 24.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (23, 17870, '00023 string record', 25.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (24, 964, '00024 string record', 26.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (25, 31289, '00025 string record', 27.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (26, 16930, '00026 string record', 28.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (27, 26235, '00027 string record', 29.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (28, 21406, '00028 string record', 30.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (29, 19402, '00029 string record', 31.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (30, 31217, '00030 string record', 33.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (31, 15295, '00031 string record', 34.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (32, 2962, '00032 string record', 35.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (33, 5999, '00033 string record', 36.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (34, 10650, '00034 string record', 37.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (35, 26988, '00035 string record', 38.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (36, 6303, '00036 string record', 39.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (37, 11053, '00037 string record', 40.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (38, 7483, '00038 string record', 41.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (39, 13401, '00039 string record', 42.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (40, 14260, '00040 string record', 44.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (41, 21990, '00041 string record', 45.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (42, 29443, '00042 string record', 46.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (43, 27906, '00043 string record', 47.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (44, 25123, '00044 string record', 48.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (45, 31057, '00045 string record', 49.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (46, 2940, '00046 string record', 50.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (47, 26588, '00047 string record', 51.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (48, 5316, '00048 string record', 52.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (49, 16317, '00049 string record', 53.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (50, 12956, '00050 string record', 55.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (51, 8057, '00051 string record', 56.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (52, 24041, '00052 string record', 57.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (53, 29061, '00053 string record', 58.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (54, 19851, '00054 string record', 59.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (55, 23648, '00055 string record', 60.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (56, 24069, '00056 string record', 61.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (57, 9810, '00057 string record', 62.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (58, 6451, '00058 string record', 63.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (59, 32426, '00059 string record', 64.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (60, 10011, '00060 string record', 66.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (61, 19988, '00061 string record', 67.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (62, 17801, '00062 string record', 68.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (63, 17756, '00063 string record', 69.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (64, 9960, '00064 string record', 70.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (65, 19902, '00065 string record', 71.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (66, 31133, '00066 string record', 72.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (67, 12168, '00067 string record', 73.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (68, 1999, '00068 string record', 74.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (69, 11204, '00069 string record', 75.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (70, 3170, '00070 string record', 77.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (71, 21282, '00071 string record', 78.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (72, 13449, '00072 string record', 79.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (73, 2133, '00073 string record', 80.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (74, 32318, '00074 string record', 81.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (75, 17827, '00075 string record', 82.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (76, 27273, '00076 string record', 83.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (77, 23896, '00077 string record', 84.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (78, 32593, '00078 string record', 85.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (79, 29279, '00079 string record', 86.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (80, 1840, '00080 string record', 88.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (81, 16936, '00081 string record', 89.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (82, 3717, '00082 string record', 90.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (83, 31399, '00083 string record', 91.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (84, 31669, '00084 string record', 92.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (85, 12048, '00085 string record', 93.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (86, 32090, '00086 string record', 94.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (87, 31646, '00087 string record', 95.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (88, 5074, '00088 string record', 96.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (89, 31877, '00089 string record', 97.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (90, 25710, '00090 string record', 99.0);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (91, 21980, '00091 string record', 100.1);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (92, 31535, '00092 string record', 101.2);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (93, 6694, '00093 string record', 102.3);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (94, 21711, '00094 string record', 103.4);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (95, 21188, '00095 string record', 104.5);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (96, 11663, '00096 string record', 105.6);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (97, 14708, '00097 string record', 106.7);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (98, 20993, '00098 string record', 107.8);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (99, 17318, '00099 string record', 108.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (99, 18318, '00099 string record', 108.9);
INSERT INTO DB (serial, ikey, filler, dkey) VALUES (100, 15805, '00100 string record', 110.0);

--
-- START JOIN TESTS
-- 

-- SNL TEST

--SNL1
SELECT DA.serial, DA.ikey, DA.filler FROM DA, DB WHERE DA.serial < DB.serial; 

--SNL2
SELECT DA.ikey, DB.serial FROM DA, DB WHERE DA.ikey <> DB.serial; -- use SNL - test not equal

--SNL3
SELECT DA.ikey, DB.serial FROM DA, DB WHERE DA.ikey < DB.serial; -- use SNL - test less than

--SNL4
SELECT DA.ikey, DB.serial FROM DA, DB WHERE DA.ikey <= DB.serial; -- use SNL - test less than or equal to

--SNL5
SELECT DA.ikey, DB.serial FROM DA, DB WHERE DA.ikey > DB.serial; -- use SNL - test greater than

--SNL6
SELECT DA.ikey, DB.serial FROM DA, DB WHERE DA.ikey >= DB.serial; -- use SNL - test greater than or equal to

--SNL7
SELECT * FROM DA, DB WHERE DA.ikey < DB.serial; -- use SNL - test less than with selecting all

--SNL8
SELECT * FROM DA, DB WHERE DA.ikey <= DB.serial; -- use SNL - test less than or equal to with selecting all

--SNL9
SELECT * FROM DA, DB WHERE DA.ikey > DB.serial; -- use SNL - test greater than with selecting all

--SNL10
SELECT * FROM DA, DB WHERE DA.ikey >= DB.serial; -- use SNL - test greater than or equal to with selecting all

-- SMJ TEST

--SMJ1
SELECT DA.serial, DA.ikey, DA.filler FROM DA, DB WHERE DA.serial = DB.serial; 

--SMJ2
SELECT * FROM DA, DB WHERE DA.ikey = DB.ikey; -- use SMJ - select all


-- INL TEST

CREATE INDEX DA (serial); 
CREATE INDEX DB (serial); 

--INL1
SELECT DA.serial, DA.ikey, DA.filler FROM DA, DB WHERE DA.serial = DB.serial; 

--INL2
CREATE INDEX DA (ikey);
SELECT * FROM DA, DB WHERE DA.ikey = DB.ikey; -- use INL

DROP TABLE DA; 
DROP TABLE DB;