USE website;

CREATE TABLE website_traffic
(
Product VARCHAR(100),
Category VARCHAR(100),
Browsingdate DATE,
Browsingmonth VARCHAR(50),
Browsinghour INT,
Department VARCHAR(100),
ip VARCHAR(500),
url VARCHAR(500));

SELECT * FROM website_traffic; 

FLUSH PRIVILEGES;

SHOW GLOBAL VARIABLES LIKE 'read_only';
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/Online Website sales.csv' 
INTO TABLE website_traffic
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

## THE DATA CLEANING/VALIDATION PROCESS BEGINS FROM HERE ON
SELECT `Product` FROM `online website sales`
WHERE `Product` = '' OR `Product` IS NULL;

SELECT * FROM `online website sales`
WHERE `Category` = '' OR `Category` IS NULL
OR `Browsingdate` = '' OR `Browsingdate` IS NULL;

SELECT * FROM `online website sales`
WHERE `Browsingmonth` = '' OR `Browsingmonth` IS NULL
OR `Browsinghour` = '' OR `Browsinghour` IS NULL;

SELECT * FROM `online website sales`
WHERE `Department` = '' OR `Department` IS NULL
OR `ip` = '' OR `ip` IS NULL
OR `url` = '' OR `url` IS NULL;

## AFTER CHECKING THE DATA FOR ERRORS OR INVALIDS, THE ANALYSIS PROCESS BEGINS HEREON

## JUST TO SHOW CASES OF SIMILAR IP ADDRESS BEING USED TO ASSESS A PRODUCT ON THE WEBSITE
SELECT * FROM `online website sales`
WHERE `ip` = '37.97.182.65';

## TO IDENTIFY UNIQUE PERSONS OR IP ADDRESSES ON THE SITE, 
## I'LL KEEP THE USE OF THE 'DISTINCT' FUNCTION IN SUCH CASES
SELECT COUNT(DISTINCT(`ip`)) FROM `online website sales`; 	# RESULTS SHOWED THAT THEY WERE 214 UNQIUE COUNTS OF IP ADDRESSES 
															# ON THE WEBSITE DURING THE SPECIFIED TIME OF OUR DATA RANGE
## TO COUNT TOTAL NO OF SITE ENTRIES
SELECT COUNT(*) FROM `online website sales`;  #RESULTS SHOWED 1860

## TO CALC DEPARTMENT WITH HIGHEST TRAFFIC
SELECT `Department`,
`Category`,
COUNT(`ip`) AS `ip Address`
FROM `online website sales`
GROUP BY `Department`
ORDER BY COUNT(`ip`) DESC
LIMIT 3;

## TO CALC DEPARTMENT WITH HIGHEST UNIQUE IP ADDRESS TRAFFIC
SELECT `Department`,
`Category`,
COUNT(DISTINCT(`ip`)) AS `ip Address`
FROM `online website sales`
GROUP BY `Department`
ORDER BY COUNT(DISTINCT(`ip`)) DESC
LIMIT 3;

## TO CALC TOP 10 PRODUCTS WITH HIGHEST TRAFFIC
SELECT `Product`, `Department`,
`Category`,
COUNT(DISTINCT(`ip`)) AS `ip Address`
FROM `online website sales`
GROUP BY `Product`
ORDER BY COUNT(DISTINCT(`ip`)) DESC
LIMIT 10;

