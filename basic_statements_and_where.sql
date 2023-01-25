-- WHERE, LIMIT, and other clauses
-- LIMIT
-- use my fruits database
USE fruits_db;
SHOW TABLES;
SELECT * FROM fruits;
SELECT * FROM fruits LIMIT 5;
USE employees;
SELECT * from employees LIMIT 10;
-- I did not change my schema here.  I'm still living within
-- the database employees at this point,
-- BUT! I've used dot notation to point out a more absolute path
SELECT * FROM fruits_db.fruits;
-- to actually move there:
USE fruits_db;
-- Note that there is a table called employees inside of the schema employees
SELECT * FROM employees.employees LIMIT 5;
SELECT * FROM fruits;
-- where
SELECT * FROM fruits WHERE name = 'cantelope';
-- In this case, I have selected every field inside the table,
-- and only the specific instance where the field called name
-- matched the name 'cantelope'
SELECT quantity FROM fruits WHERE name = 'apple';
-- when looking at text/string values, we can use LIKE
SELECT * FROM fruits;
SELECT * FROM fruits WHERE name LIKE '%fruit';
-- If we want to find an instance where the word not only ends
-- in the word fruit, but perhaps is anywhere in the field, what do?
SELECT * FROM fruits WHERE name LIKE 'fruit%';
-- Note: wildcard can be used to pad for zero or more characters
-- IN!
-- Show me fruits that are only apples or dragonfruits:
SELECT * FROM fruits WHERE name IN(LIKE '%apple','dragonfruit');

-- SELECT field(s)
-- FROM table
-- WHERE clause 1, clause 2, etc;
SELECT * FROM fruits 
WHERE name IN('apple','dragonfruit') 
AND name LIKE '%apple';

SELECT * FROM fruits;
DESCRIBE fruits;
-- Where comparison operators change by what we are comparing!
-- numbers can use < > =, etc
-- all fruits where quant was greater than five?
SELECT * FROM fruits WHERE quantity > 5;
-- all fruits where quant was greater than or equal to five?
SELECT * FROM fruits WHERE quantity >= 5;
-- everything not equal to five?
SELECT * FROM fruits WHERE quantity != 5;
-- != or <> both valid as inequality operators
-- all fruit where the quantity is between one and 4
SELECT * FROM fruits WHERE quantity BETWEEN 1 AND 4;
-- note inclusivity of range
SELECT * FROM fruits WHERE name IS NOT NULL;