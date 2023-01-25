-- Welcome to MySQL!
-- Two --'s represent a single line comment
/* this
is
how
we do a mult-line comment */

-- Welcome to the library! How do we know where to go?
-- command: SHOW
-- DATABASES: the thing i want to see
-- ; ==> the end of the statement
-- hot keys: command + r to run a query in sql ace
-- command + return to run a query in mysqlworkbench
SHOW DATABASES;
-- If we want to know what the DDL (definition)
-- of any given database looks like, we can
-- ask mysql to tell us how it was created
SHOW CREATE DATABASE chipotle;
-- USE will tell mysql to zap us into a specific schema
USE chipotle;
-- I'm in! Now what?
SHOW TABLES;
-- give me information on the table's creation!
SHOW 
CREATE 
TABLE 
orders;
-- I'm lost, what schema are we in again?
SELECT DATABASE();
DESCRIBE orders;

SELECT 1+1;
-- lets examine what fields are present
DESCRIBE orders;
SELECT id, id + 1 FROM orders;
-- If I want to change the name of the output from 'id + 1' to something else a 
-- little more user friendly, I can use AS to alias this

-- change the order of the alias:
-- SELECT id, id + 1 FROM orders AS 'additive_id';

-- double alias:
SELECT id AS 'my_primary_key', id+1 AS 'additive' FROM orders;
SELECT id, id+1 FROM orders;

-- * : wildcard
-- switch to the fruits database/schema
USE fruits_db;
-- describe the one table here (we could view with SHOW TABLES)
DESCRIBE fruits;
SELECT id, 
name,
quantity
FROM fruits;
-- ooooooooor:
SELECT * FROM fruits;

