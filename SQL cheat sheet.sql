-- COMMENTS: Double-dash syntax

----------------------
-- Terminology
---------------------

-- Column = Attribute 
-- Row    = Entry
-- Filter = "WHERE" keyword results
-- Filter 


----------------------
-- COMMON MISTAKES
---------------------

-- Confusing , and ; (comma separates arguments, semicolon terminates a query)

-- Forgetting ; ... not terminating queries

-- CASE INSENSITIVITY for names....don't forget!

-- SELECT before you UPDATE to make sure you have the right target!

-- Confusing '' and ""
    -- Single quotes '' are used for text strings
    -- Double Quotes "" are for NAMES in Tables with capitalizations (to get around the case-insensitivity)
    -- SQL is CASE INSENSITIVE

-- Using '==', no double equals in SQL, only '='

-- (10 / 3) = 3 in SQL!  Integer division yields an integer!  (10.0 / 3.0 = 3.3333) 

-- WHERE cannot be used after GROUP BY, must use HAVING instead

-- Aliases (AS new_name) CANNOT be referenced later...the original statement must be copied

-- Using invalid names

-- When FROM on multiple tables, the "implicit join" (CROSS JOIN) occurs, yielding potentially surprising results.

-- if you try to SELECT a field that is not in your GROUP BY clause,
-- without using it to calculate some kind of value about the entire group
-- SQL will return an error

-- Use INTO to name the results of a query as a new table, not AS.

-- All data in a single table column MUST have the same data type.

-- to insert a string with quotation marks included, you must:
    -- 'Alternate "between" single and double', or
    -- 'Use the backslash to \'escape\' the symbols'

-- NO COMMAS in CASE statements

-- WHERE cannot be used after grouping...HAVING must be used for the same purpose.


-----------------------------------
--*******  NULLs  !!!!   *******

-- When trying to select or reject tuples with NULL values,
-- You CANNOT use '= NULL' as a comparison.  For some reason the equals sign can't be used with NULL.
-- Instead you must use

IS NULL
--OR
IS NOT NULL


----------------------
-- CONVENTIONS / BEST PRACTICES
---------------------

-- Indentations (2 spaces) are not necessary, but help readability

-- Alias table names as their first character, where possible.

-- Use snake_case (all lowercase) for table names.

-- Table names should be PLURAL


----------------------------
-- MySQL Shell
---------------------------

-- The shell usually has ONLY ONE (1) connection established at a time
-- If you try to open a new connection session, the previous one will be closed.

-- ...Unless you use Javascript or Python modes, and mysqlx.getSession()
-- In which case you can have MULTIPLE session objects, one for each server connection

-- IMPORTANT INSTRUCTION:
-- To start local instance: 
-- - Ctrl + Alt + Delete
-- - Select "Services"
-- - Find "MySQL80", right click, and "Start"

--------------------------------------------------
-- In terminal window, start MySQL shell with command:
mysqlsh
-- Or start the shell with the connection:
mysqlsh --mysqlx -u root -h localhost -P 33060    
mysqlsh --uri mysqlx://root@localhost:33060       -- Alternate command (same)
mysqlsh --mysqlx --uri root@localhost:33060       -- Alternate command (same)

mysqlsh --sqlx          -- Open in SQL mode
mysqlsh --py            -- Open in Python mode
mysqlsh --py < code.py  -- Execute Python file from within shell


---------------------------------------------------
-- In MySQL Shell, connect to active database server with:
\connect --mysqlx root@localhost:33060  -- start Session with newer "X Protocol"
\connect root@localhost:33060           -- Same, "--mysqlx" is implicit with port 33060

-- Or in Javascript or Python mode:
shell.connect('mysqlx://root@localhost:33060')  -- Use in 
shell.connect( {scheme:'mysqlx', user:'root', host:'localhost', port:33060} )

\connect --mysql root@localhost:3306     -- use older "ClassicSession" protocol
\connect root@localhost:3306             -- Same, "--mysql" is implicit with port 3306 

-- When you make the first connection to a MySQL Server instance,
-- a MySQL Shell global object named session is created to represent this connection. 
-- This particular session object is global because once created, it can be used in all of the MySQL Shell execution modes: 
-- SQL mode, JavaScript mode, and Python mode.
-- view "session" details with
session
\status OR shell.status()

-- With SQL shell open, or in SQL file....(make sure it is in SQL mode)

SELECT @@GLOBAL.sql_mode;   -- View current modes that are set
SET GLOBAL sql_mode = '';   -- Explicitly clear the modes globally, affecting all sessions (requires ADMIN privileges)

SELECT @@sql_mode;
SET SESSION sql_mode = '';  -- Explicitly clear the modes for this session

-- Possible modes in MySQL 8.0: 
-- ANSI, STRICT_TRANS_TABLES, TRADITIONAL
-- NO_ENGINE_SUBSTITUTION, ONLY_FULL_GROUP_BY,  
-- NO_ZERO_IN_DATE, NO_ZERO_DATE, ERROR_FOR_DIVISION_BY_ZERO,
-- among many others

source \PATH\script_filename.sql

\reconnect
\disconnect

\quit OR \q OR \exit  -- Exit MySQL shell


----------------------------
----------------------------
-- DDL : Data Definition Language

-- Create/Edit/Delete Databases & Tables
---------------------------
----------------------------

SHOW DATABASES;   -- View all databases on server

-- snake_case recommended
-- All lowercase to distinguish from SQL COMMANDS
-- DO NOT use spaces

CREATE DATABASE DB_Name;  -- DO NOT use spaces
SELECT DATABASE(); -- View which database is currently active
USE DB_name; -- Select database to be currently active
-- USE DATABASE DB_name;  -- In some other systems
DROP DATABASE DB_name;  -- Delete

SHOW TABLES;      -- View all tables in database

-- Describe
DESC table_name;  -- View all column names in table
SHOW COLUMNS FROM table_name;   -- another way view all column names

CREATE TABLE people           -- Table name
  (
    first_name VARCHAR(20),       -- first column name & type
    last_name VARCHAR(20),        -- next column name & type
    num_children INT NOT NULL,    -- specifically constrains 'id' col to disallow NULLs
    divide_by NOT NULL DEFAULT 1, -- specifies the "default" value if not specified.
    age INT,                      -- ...and so on
    username VARCHAR(50) UNIQUE,
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- PRIMARY KEY (id)              -- alt. way to specify which col is Primary Key of Table
    country_id INT NOT NULL,
    FOREIGN KEY(country_id) 
      REFERENCES countries(country_id),
      -- Very critical option
      ON DELETE CASCADE           -- If a country is deleted that has people associated with it, delete those people also
  );

CREATE TABLE likes (
    photo_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(photo_id, user_id)    -- Can use a combination of variables as a primary key
);

DROP TABLE table_name;  -- Delete table

  ----------------------
-- MySQL Data Types
---------------------

-- Numeric Types
INT, BIGINT -- INT +/- 2.14e9, BIGINT +/- 1.84e19
--Never Used: TINYINT, SMALLINT, MEDIUMINT

DECIMAL(max_num_digits <= 65, num_decimal_places <= 30) -- exact precision, no error, such as for financial data

-- Rarely Used: NUMERIC,  BIT 

-- Approximate, NOT exact
--FLOAT     -- 4 bytes, inexact after ~7 digits
DOUBLE      -- 8 bytes, inexact after ~15 digits   


-- String Types
-- MUST be declared WITH the max length that you want to store.

VARCHAR(max_length)      -- Primary, max length 65,535 
-- CHAR(fixed_length),   -- faster, all entries SAME length, max length 255, right padded with spaces
                         -- when retrieved, right padding spaces REMOVED.
BINARY, VARBINARY
TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB -- binary, lengths 256, 65536, 16.77e6, 2.49e9
TEXT, TINYTEXT, MEDIUMTEXT, LONGTEXT -- text,   lengths 256, 65536, 16.77e6, 2.49e9
ENUM 


-- Date Types

-- Most used
DATETIME      -- YYYY-MM-DD HH:MM:SS
DATE          -- YYYY-MM-DD, no time
TIME          -- HH:MM:SS, no date
TIMESTAMP     -- same as datetime, but much less space
              -- AND LIMITED to '1970-01-01 00:00:01.000000' to '2038-01-19 03:14:07.999999' 

-- Use strings to manually enter
INSERT INTO times (datetime1, date1, time1)
VALUES ('1941-12-07 08:00:00', '1941-12-07', '08:00:00')

TIMESTAMP
YEAR
-----------------------


-- CRUD: Create Data
INSERT INTO people(first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13),       -- inserts the values in the ORDER listed above!
       ('Bob', 'Belcher', 42),
       ('Calvin', 'Schadenfreude', -1);

INSERT INTO people(last_name, age, first_name)
VALUES ('Belcher', 45, 'Linda')

-- CRUD: Update
UPDATE cats SET breed='Shorthair', comments='boring' 
WHERE breed='Tabby';

-- CRUD: Delete
SELECT * FROM cats WHERE name='Egg';  -- BEST PRACTICE...Select First to verify correct target data
DELETE FROM cats WHERE name='Egg';

-- WARNING
DELETE FROM cats;  -- Deletes all rows from table


----------------------------
----------------------------
-- DQL: Data Queries
----------------------------
----------------------------

SELECT * FROM table_name; -- Retrieve all data from table

SELECT col1, col2, attr3, attr4 FROM table_name; -- Retrieve specified columns from table, all rows


--------------------------------------------
-- Comparison Operators

=  -- equal to
<> -- not equal to, != is supported by some  
<, >, <=, >= -- greater than, less than, + equal to

--Logical Operators (used in the WHERE clause)
AND &&, OR ||, NOT !, XOR
ALL
ANY
IN -- test that a value exists in some other "set" of values (subquery or manually defined)
SOME
BETWEEN value1 AND value2;  -- inclusive of limits
EXISTS -- checks whether a subquery "set" is empty or not

LIKE -- CASE INSENSITIVE ... used for string comparisons / regular expressions via PSQL standard
NOT LIKE
SIMILAR TO -- SQL99 standard used for string comparisons / regular expressions

_ -- single char wildcard
% -- multiple char wildcard
\_-- Search for actual underscore character
\%-- search for actual percent-sign character

--------------------------------------------
-- Other Operators

ORDER BY
LIMIT 5
LIMIT start_index_opt, num_rows   -- start_index is 0-indexed and optional, num_rows is the total num rows to return
LIMIT 99, 999999999999999999      -- to select row 100 to the END of table, use gigantic num_rows arg.
DISTINCT col1, col2, etc   -- Will only return where the combination of all columns are distinct
FETCH

---------------------------
-- FILTERS : The "WHERE" keyword (must be after the FROM statement)

-- Retrieve specified columns with a content filter
SELECT col1, attr2 FROM table_name
  WHERE attr2 = 'spec_str';       -- Filter for exact match

SELECT col1, attr2 FROM table_name
  WHERE attr2 > 100;              -- Filter for numeric value

-- BETWEEN
SELECT col1, year, FROM Table1_name
  WHERE year BETWEEN 1990 AND 1999;       -- Filter within a range using BETWEEN keyword

-- IN /NOT IN
SELECT col1, year, FROM Table1_name
  WHERE year IN (1990, 1992, 1994, 1996); -- Filter only values within a specify set

SELECT col1, language, FROM Table1_name
  WHERE language IN ('English', 'Spanish', 'French'); -- Filter only values within a specify set

SELECT * FROM Table1
  WHERE var1 IN (SELECT var1 FROM Table2 WHERE col2 = 'Value'); -- Common condition (IN | NOT IN ) to select only rows where one row exists in 

-- LIKE - For string comparisons & RegEx
SELECT name FROM Table1_name
  WHERE name LIKE 'A%';            -- Find all names starting with 'A'

SELECT name FROM Table1_name
  WHERE name NOT LIKE '_on%';      -- Exclude Don, Ron, Connie, etc.

SELECT * /*or*/ A1, table1_name.col1name, table2_name.col2name -- Column / Attribute
  FROM Table1, Table2  -- Table/Relation
  WHERE (condition) table1_name.col1_ID = table2_name.col1_ID 
    AND (condition1) AND (condition2);

-- Common condition (IN | NOT IN ) to select only rows where one row exists in 
SELECT * FROM Table1
  WHERE var1 IN (SELECT var1 FROM Table2 WHERE col2 = 'Value')

--------------------------
-- The "implicit join" [FROM Table1, Table2] is the CROSS PRODUCT, or CROSS JOIN of the tables!!!!
-- Thus, if Table1 has 20 rows, and Table2 has 50 rows, the resulting table will have 1000 rows!!!!

--------------------------
-- SQL is natively UN-ORDERED!!
-- To order the table that is returned....

SELECT * /*or*/ A1, table1_name.A2, table2_name.A3 -- Column / Attribute
  FROM table1_name, table2_name  -- Table/Relation
  WHERE (condition) table1_name.col1_ID = table2_name.col1_ID
  ORDER BY col1 ASC, col2 DESC
-- first arg is primary ordering, and second arg is...within matching values of col1, order by col2

SELECT * /*or*/ A1, table1_name.A2, table2_name.A3 -- Column / Attribute
  FROM table1_name, table2_name  -- Table/Relation
  WHERE (condition) table1_name.col1_ID = table2_name.col1_ID
  ORDER BY 1 ASC, 2 DESC
-- 1 and 2 are shortcuts for 1st and 2nd SELECT args, A1, and table1_name.A2


--------------------------------------
-------------------------------------
-- AGGREGATION

------------------------------------
-- GROUP BY

-- A Type of Aggregation
-- Always AFTER FROM 
-- "Collapses" the resulting table by common values in a single column

SELECT release_year, country, COUNT(*) AS films_in_year, AVG(budget) 
  FROM films
  GROUP BY release_year, country
  ORDER BY release_year, country;   

-- HAVING Allows you to subset/filter results of groupings, essentially a "WHERE" condition for groups, 
HAVING  [condition]

aggregate()

SELECT DISTINCT *  -- Eliminates any duplicate rows from returned table
  FROM table_name; 
  LIMIT 5

FETCH

SELECT DISTINCT col1name FROM table_name;       -- Return only the unique values (eliminate duplicates) among col1 values in 


----------------------------
-- String Matching -- 

SELECT col1 from table1_name
WHERE col1 LIKE '%string%';  -- Returns all instances where cell contains the characters 'string'


-------------------------------------
-- AGGREGATION FUNCTIONS

-- COUNT(), MAX(), MIN(), AVG(), ABS(), SUM()

-- COUNT
COUNT()         --DOES NOT COUNT "NULL"s.  Any value that is NULL is disregarded from a count.
SELECT COUNT(*) FROM table1;                        -- Count the total number of rows in table
SELECT COUNT(employee_num) FROM employee_table;     -- Count number of non-NULLs in employee_num
SELECT COUNT(DISTINCT birthdate) FROM employee_table;-- Count the number of unique birthdates in employee_table

-- MAX, MIN, AVG
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT AVG(salary) FROM employees WHERE name LIKE 'A%';


-- AVG(ALL /*Default*/ | DISTINCT)
SELECT AVG(salary) FROM salaries_table

SUM()

-- Retrieve data with temporarily different column names
SELECT col1 AS 'New Column Name', (minutes/60.0) AS 'hours' 
FROM table_name;

-- Concatenating Columns

SELECT CONCAT(col1, 'can insert text', attr2, "col3 Name") as "New Title of concatenated Column" 
FROM table_name;
-- use single quotes '' when you want to insert new text between data elements in output
-- use double quotes "" when you want to reference an EXACT Column/Attribute name

-- LIMIT X: Only return the first X number of results 


SELECT DISTINCT col2, COUNT(*) FROM Table1   -- Returns unique values in col2, and the counts of each unique value that appear

---------------------------
-- EXAMPLES:

SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY avg_gross DESC;

SELECT country, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
GROUP BY country
HAVING COUNT(title) > 10
ORDER BY country
LIMIT 5;

-- "Scalar" Functions

ROUND(value, num_decimal_places)




---------------------------
-- Set Operators  (Union, Intersect, Except)

-- When you have two different queries with separate results, and you want to combine/compare the resultant tables.

-- Create Table "variables" in-line

SELECT T1.col1, T2.col2
FROM Table1_name T1, Table2_name T2  -- Allows you to just refer to the Tables as T1 and T2!
WHERE T1.col1 = T2.col2; 

-- UNION: Merge Columns/Attributes into single row/fewer rows (columns MUST have mergeable data types)

-- !! MUST specify ALL to retain duplicates
SELECT col1 AS name FROM Table1_name
UNION ALL
SELECT col2 AS name FROM Table2_name;  -- Returns only one column

-- or DEFAULT to REMOVE duplicates
SELECT col1 AS name FROM Table1_name
UNION ALL
SELECT col2 AS name FROM Table2_name;

-- INTERSECT: return all MATCHING rows (results) from the two different queries

-- !! MUST specify ALL to retain duplicates
SELECT col1 FROM table1
INTERSECT ALL
SELECT col1 FROM table2;

-- or DEFAULT to REMOVE duplicates
SELECT col1 FROM table1
INTERSECT
SELECT col1 FROM table2;

-- EXCEPT / Difference / Minus: return all instances where rows/results of two different queries DO NOT match

-- !! MUST specify ALL to retain duplicates
SELECT col1 FROM table1
EXCEPT ALL 
SELECT col1 FROM table2;

-- or DEFAULT to REMOVE duplicates
SELECT col1 FROM table1
EXCEPT
SELECT col1 FROM table2;


------------------------------------
-- Other Methods

-- Nested Queries/Sub-queries

SELECT col1 FROM Table1_name
WHERE col1 in (SELECT col1 FROM Table2 WHERE col2 = value)

-- EXISTS: Check to see if a set is empty or not (from a subquery)

SELECT col1 FROM Table1
WHERE
EXISTS (SELECT * FROM TABLE1 WHERE col2 > col3)

-- ALL: used in the "where" clause, checks to see if the condition is satisfied for ALL members of a subset

SELECT col1 FROM table1
WHERE col2 > ALL (SELECT col3 FROM Table1)

-- ANY: used in the "where" clause, checks to see if the condition is satisfied for ANY members of a subset

SELECT col1 FROM table1
WHERE col2 > ALL (SELECT col3 FROM Table1)


------------------------------------
-- CASE WHEN ___ THEN : Case/Switch/Compound IF-THEN statements

-- CASE, WHEN, THEN, ELSE, END

SELECT name, continent, code, surface_area,

    CASE 
        WHEN surface_area > 2000000 THEN 'large'       -- First "IF-THEN"
        WHEN surface_area > 350000 THEN 'medium'        -- Second case, ELSE IF
        ELSE 'small' 
    END                                -- Else clause + end
    AS geosize_group    -- Alias name

FROM countries;


------------------------------------
-- INTO : Save the results of a query into a new table name

SELECT country_code, size,
    CASE 
        WHEN size > 50000000 THEN 'large'
        WHEN size > 1000000 THEN 'medium'
        ELSE 'small' 
    END
    AS popsize_group
-- Into table
INTO pop_plus
FROM populations
WHERE year = 2015;

SELECT * FROM pop_plus;     -- Select all columns of pop_plus



---------------------------------------
---------------------------------------
-- JOINS (Various)
---------------------------------------
-- Abbreviated ways to write expressions of longer (common) queries that can be expressed using more basic operators
---------------------------------------

-------------------------------------
-- CROSS JOIN (Cartesian Product, Cross Product)

-- Every combination of each row of each table. 
--If Table1 has 20 rows, and Table2 has 50 rows, the resulting table will have 1000 rows!

SELECT * FROM Table1, Table2;
--same as
SELECT * FROM Table1 CROSS JOIN Table2;

-------------------------------------
-- "STANDARD" JOIN, INNER JOIN

-- "Keep ONLY the data that is IN both tables (based on join condition)"
-- "while getting rid of any rows from tables NOT matching join condition"

-------------------------------------
-- INNER JOIN, JOIN (Default, Theta Join, Inner Join on Condition)
-- Computes the CROSS JOIN, but ONLY returns rows satisfying the condition

SELECT *
FROM Table1 JOIN Table2 
ON Table1name.Col1 = Table2name.Col1;
-- OR
SELECT *
FROM Table1 INNER JOIN Table2 
ON Table1.Col1 = Table2.Col1;
--OR
SELECT *
FROM Table1, Table2 
WHERE Table1.Col1 = Table2.Col1;

-- !! you can put conditions in ON or WHERE clauses, but ON is best for join condition

-- Often good to use table name AS Aliases for less typing
-- Common Practice is to use the the FIRST LETTER of the table name as alias name

SELECT c.col2, c.col3, p.col3
FROM countries AS c
  INNER JOIN populations AS p
  ON c.col1 = p.col1;   -- Specify the table keys

-- MORE THAN TWO tables can be joined simultaneously

SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  FROM countries AS c INNER JOIN populations AS p
    ON c.code = p.country_code
  INNER JOIN economies AS e
    ON c.code = e.code AND e.year=p.year;

-------------------------------------
-- INNER JOIN USING 

-- MUST include parentheses!!
-- for JOINS, shorter equalivalent to ON when the columns already have the same name
-- and you don't want to write a.name = b.name

-- Can also be used for other operations on only one table

SELECT c.name AS country, continent, l.name AS language, official
  FROM countries c
  INNER JOIN languages l
    USING (code)


-------------------------------------
-- SELF JOIN  :  JOINing a table with itself

-- Used to compare values in a field to other values of the same field in the same table
-- REQUIRED to use an alias

SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       ((p2.size - p1.size)/p1.size * 100.0) AS growth_perc    -- Calculate growth_perc
FROM populations AS p1
  INNER JOIN populations AS p2
    ON p1.country_code = p2.country_code    -- Match on country code\
        AND p1.year = (p2.year - 5);        -- and year (with calculation)


-------------------------------------
-- NATURAL JOIN
-- NOT recommended to be used....it is best to directly specify "USING" just in case that you have columns with accidentally matching names
-- The same as "INNER JOIN USING", but where the system automatically picks which columns to use by finding common names of columns
-- Take the cross product/cross join
-- When the tables have one or more column names in common, 
-- only keep the rows for which the tuples have the same values in the columns with the same name 
-- (but keep only 1 copy of the common columns in the result)

SELECT *
FROM Table1 T1, Table2 T2
WHERE T1.col1 = T2.col1;
-- OR
SELECT *
FROM Table1 NATURAL JOIN Table2;

-------------------------------------
-- OUTER JOINS

-- "Reach OUT to another table to add information,"
-- "while retaining ALL of the information from the original table."
-- Likely will result in NULLs and maybe even duplicates.

-------------------------------------
-- LEFT OUTER JOIN (LEFT JOIN)

-- If there are tuples in the FROM table that do NOT exist in the other table, but you WANT them in the result
-- The rows from the "left" (FROM) Table will be padded with NULLs on the right for any columns from Table2 it does not contain.
-- NOT COMMUTITATIVE OR ASSOCIATIVE

SELECT *
FROM Table1 LEFT OUTER JOIN Table2 [USING ()];  -- Any tuples in Table1 that are NOT in Table2 (dangling tuple) will appear in the result
-- OR
SELECT *
FROM Table1 LEFT JOIN Table2 [USING ()]; -- The same thing

-------------------------------------
-- RIGHT OUTER JOIN (RIGHT JOIN)

-- Same as left outer join, but keeps unmatched tuples from the Table on the right
-- NOT COMMUTITATIVE OR ASSOCIATIVE

SELECT *
FROM Table1 RIGHT OUTER JOIN Table2 [USING ()];
--OR
SELECT * FROM Table1 RIGHT JOIN Table2 [USING ()];

-------------------------------------
-- FULL OUTER JOIN (FULL JOIN)

-- The UNION (Combination) of a Left and Right Outer Join
-- Keeps all tuples from all tables involved.
-- NOT ASSOCIATIVE....apply carefully

SELECT * FROM Table1 FULL OUTER JOIN Table2
-- OR
SELECT * FROM Table1 FULL JOIN Table2


---------------------------------------
---------------------------------------
-- USEFUL FUNCTIONS
---------------------------------------
---------------------------------------


IFNULL(arg, replace_with)   -- If arg is NULL, it will be replaced with replace_with


---------------------------------------
-- String Functions
---------------------------------------

CHAR_LENGTH(str_col_name)                     -- Return the number of characters in argument

-- "pos" indexes start at 1!!! (not 0 indexed)
SUBSTRING(str, pos)                           -- Return str[pos-1:]
SUBSTRING(str, pos, len)                      -- Return str[pos-1:pos-1+len]
SUBSTR()   -- shorthand                       -- 'pos' can be negative to index backward from end of string

CONCAT(col1_name, 'text', col2_name, 'text')
CONCAT_WS(' - ', col1_name, col2_name)        -- Concatenate with separator

-- Case-Sensitive!!
REPLACE(str, from_str, to_str)                -- returns 'str' with all instances of 'from_str' replaced with 'to_str'

REVERSE(str)                                  -- Return 'str' with order of characters reversed

LOWER(str)                                    -- Return str in all lower-case
UPPER(str)                                    -- Return str in all upper-case

FORMAT(number, num_decimal_places)            -- Return string of number with specified precision

---------------------------------------
-- Date/Time Functions
---------------------------------------

NOW()                     -- Current DATETIME
CURDATE(), CURRENT_DATE()
CURTIME(), CURRENT_TIME()
UTC_TIMESTAMP()           -- Current UTC DATETIME
UTC_DATE()
UTC_TIME()

DATE(datetime)    -- extract DATE only from datetime
TIME(datetime)    -- extract TIME of expression passed
DAYNAME(date)     -- datetime input also accepted.  Outputs Monday, Friday, etc
MONTHNAME(date)   -- datetime input also accepted.
YEAR()            -- return year
YEARWEEK()        -- return year and week
DAYOFMONTH(date)  -- datetime input also accepted.  Outputs 1-31
DAYOFWEEK(date)   -- datetime input also accepted.  Outputs 1-7 (Sun-Sat)
DAYOFYEAR(date)   -- datetime input also accepted.  Outputs 1-366

GET_FORMAT(input, region_str)   -- format date, time, datetime to 'USA', 'EUR', etc to ISO 9075

SELECT GET_FORMAT()

DATE_FORMAT(input, format_string)   -- Can accept date, time, datetime as inputs.

SELECT DATE_FORMAT('1941-12-07 08:00:00', '%M %e, %Y at %h:%i %p')   -- OUTPUT: 'December 7, 1941 at 08:00 AM'

-- Date Math

DATEDIFF(expr1, expr2)    -- Output: # days = expr1 - expr2
DATE_ADD(date, INTERVAL expr unit)    -- '2000-01-10' = DATE_ADD('2000-01-01', INTERVAL 9 DAY)
DATE_SUB(date, INTERVAL expr unit)    -- '1999-12-23' = DATE_SUB('2000-01-01', INTERVAL 9 DAY)

-- OR alternate +/- syntax
SELECT date1 + INTERVAL 13 DAY FROM table;
SELECT datetime1 - INTERVAL 2 YEAR + INTERVAL 10 HOUR FROM table;


---------------------------------------
-- Database Triggers
---------------------------------------

-- SQL statements that are automatically run when a specific table is changed

-- CAUTION: USE SPARINGLY...triggers occur "invisibly" in the background, making debugging of a server app very difficult

-- Often used to log specific events you want separate records for

SHOW TRIGGERS;  -- All triggers in all databases
SHOW TRIGGERS FROM database_name;
SHOW TRIGGERS LIKE pattern;

DROP TRIGGER trigger_name; -- Delete a trigger


-- Example 1 : Prevent users under 18 from signing up (probably should be done on client-side)

DELIMITER $$  -- Change the 'end of statement symbol' to '$$'

CREATE TRIGGER trigger_name
    trigger_time trigger_event ON table_name FOR EACH ROW [trigger_order other_trigger_name]
-- [BEFORE / AFTER] [INSERT / UPDATE / DELETE] ON table_name [FOLLOWS / PRECEDES] other_trigger name
-- trigger_order is only used when you have multiple triggers for the same event and want to sequence them
    BEGIN
    -- Write methods here
        IF NEW.age < 18 
            THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only users over age 18 are permitted.'; 
    END;
$$
DELIMITER ;   -- Change the 'end of statement symbol' back to default ';'


-- Example 2 : Prevent "instagram" users from following themselves

DELIMITER $$

CREATE TRIGGER prevent_self_follow
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.followee_id
            THEN 
                SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'You cannot follow yourself';
        END IF;
    END;
$$
DELIMITER ;


-- Example 3 : When an instagram user unfollows something, log event in separate table

DELIMITER $$

CREATE TRIGGER log_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
        SET
            follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
    END;
$$
DELIMITER ;