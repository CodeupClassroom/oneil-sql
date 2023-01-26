-- SELECT exercises:
-- Use the albums_db database.
USE albums_db;

-- Explore the structure of the albums table.
DESCRIBE albums;
SELECT * FROM albums LIMIT 5;
-- Takeaways:
-- artist, name, release date stored as an int, sales in ambiguous units
-- each unique listing by PK id can have multiple genres

-- a. How many rows are in the albums table?
SELECT * FROM albums;
-- looking at the whole table, 
-- size of table is 31 based on returned rows
-- and ending primary key id

-- b. How many unique artist names are in the albums table?
-- Distinct will allow us to only view unique instances
SELECT DISTINCT artist FROM albums;

-- c. What is the primary key for the albums table?
DESCRIBE albums;
-- id is the primary key, displayed with key field in describe

-- d. What is the oldest release date for any album 
SELECT * FROM albums;
-- oldest release date is 1967
-- Ways to solve this: (min() function, ORDER BY, GUI sort*)

-- in the albums table? What is the most recent release date?
-- 2011 is the most recent
SELECT max(release_date) FROM albums;
SELECT min(release_date), max(release_date) FROM albums;

-- Write queries to find the following information:

-- a. The name of all albums by Pink Floyd
SELECT * FROM albums WHERE artist = 'Pink Floyd';

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums
WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- few options: 
-- check for WHERE name LIKE 'Sgt. Pepper%'
-- use an escape on the apostrophe using \ or another '
-- use double quotes on the outside and break madeleines heart

-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';

-- d. Which albums were released in the 1990s
SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;

-- e. Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20;

-- f. All the albums with a genre of "Rock".
SELECT * FROM albums WHERE genre = 'Rock'; 
SELECT * FROM albums WHERE genre LIKE '%Rock%'; 

-- Why do these query results not include albums with a genre 
-- of "Hard rock" or "Progressive rock"?
-- because it was checking for the exact string literal 'rock'!

-- Be sure to add, commit, and push your work.

-- WHERE exercises:
USE employees;
-- Find all current or previous employees with 
-- first names 'Irena', 'Vidya', or 'Maya' using IN. 
SELECT * FROM employees WHERE 
first_name IN ('Irena','Vidya','Maya');

-- Find all current or previous employees with first names 
-- 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
SELECT * FROM employees WHERE
first_name = 'Irena' OR
first_name = 'Vidya' OR
first_name = 'Maya';

-- Find all current or previous employees with first names 
-- 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
SELECT * FROM employees WHERE
(first_name = 'Irena' OR
first_name = 'Vidya' OR
first_name = 'Maya') AND gender = 'M';

-- Find all current or previous employees whose last name starts 
-- with 'E'. 
SELECT * FROM employees WHERE last_name LIKE 'E%';

-- Find all current or previous employees whose 
-- last name starts or ends with 'E'. 
SELECT * FROM employees WHERE
last_name LIKE 'E%'
OR 
last_name LIKE '%E';

-- Find all current or previous employees employees whose
--  last name starts and ends with 'E'.
SELECT * FROM employees WHERE
last_name LIKE 'E%e';


-- How many employees' last names end with E, 
-- regardless of whether they start with E?
SELECT first_name, last_name FROM employees
WHERE last_name LIKE '%e';

-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with the number of employees returned.
SELECT * FROM employees
WHERE hire_date LIKE '199%';

-- Find all current or previous employees born on Christmas. 
-- Enter a comment with the number of employees returned.
SELECT * FROM employees
WHERE birth_date LIKE '%12-25';

-- Find all current or previous employees hired in the 90s 
-- and born on Christmas. 
-- Enter a comment with the number of employees returned.
SELECT * FROM employees
WHERE (birth_date LIKE '%12-25')
AND (hire_date LIKE '199%');

-- Find all current or previous employees with a 'q' in 
-- their last name. 
-- Enter a comment with the number of records returned.
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%q%';

-- Find all current or previous employees with a 'q' in their 
-- last name but not 'qu'. How many employees are found?
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';
