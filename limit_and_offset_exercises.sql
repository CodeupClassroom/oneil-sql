 -- Find all employees with first names 
 -- 'Irena', 'Vidya', or 'Maya', and order 
 -- your results returned by first name. 
 USE employees;
 SELECT *
 FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY first_name;
 
 -- In your comments, answer: 
 -- What was the first and last name in the 
 -- first row of the results? 
SELECT first_name, last_name
 FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY first_name
 LIMIT 1;
 
 -- What was the first and last name of the last
 -- person in the table?
 SELECT first_name, last_name
 FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya')
 ORDER BY first_name DESC
 LIMIT 1;

-- Find all employees with first names 'Irena', 
-- 'Vidya', or 'Maya', and order your results returned 
-- by first name and then last name. In your comments, 
-- answer: 
-- What was the first and last name in 
-- the first row of the results? 
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name
LIMIT 1;
 
-- What was the first and last name of the last person?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC
LIMIT 1;

-- Find all employees with first names 'Irena', 'Vidya', 
-- or 'Maya', and order your results returned by last 
-- name and then first name. In your comments, answer: 
-- What was the first and last name in the first row?

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name
LIMIT 10;

-- What was the first and last name of the last person?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC
LIMIT 1;

-- Write a query to to find all employees whose last name
-- starts and ends with 'E'. Sort the results by their
-- employee number. 
-- Enter a comment with the number of employees returned, 
-- the first employee number and their first and last name, 
-- and the last employee number with their first and 
-- last name.

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no;
-- 899
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no
LIMIT 1;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no DESC
LIMIT 1;

-- Write a query to to find all employees whose last 
-- name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the 
-- newest employees are listed first. 
SELECT first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;

-- Enter a comment with the number of employees returned, 
-- the name of the newest employee, 
-- and the name of the oldest employee.
SELECT first_name, last_name, hire_date, birth_date
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC, birth_date;

-- Find all employees hired in the 90s and born on 
-- Christmas. Sort the results so that the oldest 
-- employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, 
SELECT * 
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC;

-- the name of the oldest employee who was hired last,
 
-- and the name of the youngest employee who was hired first.
SELECT * 
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date DESC, hire_date;

-- List the first 10 distinct last name sorted 
-- in descending order.
SELECT DISTINCT last_name 
FROM employees
ORDER BY last_name DESC
LIMIT 10;
-- Find all previous or current employees hired in the
-- 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by 
-- sorting by hire date and limiting your results to the 
-- first 5 records.
-- Write a comment in your code that 
-- lists the five names of the employees returned.
-- Conditions: 
-- first 5 listings (LIMIT 5)
-- sort by hire date (ORDER BY hire_date)
-- employees that were born on christmas and hired in the 90s
-- (where)
SELECT * FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5;

-- Try to think of your results as batches, 
-- sets, or pages. The first five results are 
-- your first page. The five after that would be your 
-- second page, etc. 
-- Update the query to find the tenth page of results.
-- first five results on first page
-- first page: rows 1-5
-- second page: rows 6-10
-- 5*2 = 10
-- the page i want: n
-- page length * n-1 == offset
-- 5*9 = 45
-- page length/number of rows returned by page : limit value
SELECT * FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;


-- LIMIT and OFFSET can be used to create multiple 
-- pages of data. What is the relationship 
-- between OFFSET (number of results to skip), 
-- LIMIT (number of results per page), and the page number?
