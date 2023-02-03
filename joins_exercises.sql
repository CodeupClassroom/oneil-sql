-- USE the employees database.
USE employees;

-- Using the example in the associative 
-- Table Joins section AS a guide, write a query that 
-- shows each department along with the name of the 
-- current manager for that department.

-- Let's scope out the initial fields of the tables
-- that we will need to link employees to department managers.
SELECT * FROM employees LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM departments LIMIT 10;

SELECT dept.dept_name, 
CONCAT(emp.first_name, ' ', emp.last_name) AS emp_name
-- I use departments as dept and employees as emp
-- We don't need to specify the table that the field comes from
-- *as long* as that field is unique to the collection
-- of fields in the joined tables.
FROM departments AS dept
-- start with my first table departments
-- this alias allows me to reference dept.dept_name above.
	JOIN dept_manager AS dm 
		USING (dept_no)
-- we link our second table dept_manager, which
-- contains the information for the manager's employee number.
	JOIN employees AS emp
		USING (emp_no)
-- we want to link the name to that employee number from
-- the employees table.
-- aliasing emp here is what allows me to use emp.first_name etc above.
WHERE to_date > NOW();
-- now that I have my tables, specify that I only want
-- instances where the employee is the current one.

-- Results:
--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang

-- ==========================================
-- ==========================================
-- ==========================================

-- Find the name of all departments currently 
-- managed by women.

-- Note the case of USING in the last example above 
-- and following.
-- USING(shared_field) is an appropriate use when
-- the field name between the two joined tables is the same. 
-- (ON table1.field_x = table2.field_x) == USING(field_x)
SELECT departments.dept_name, 
CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM departments
	JOIN dept_manager 
		USING (dept_no)
	-- ON departments.dept_no = dept_manager.dept_no
	JOIN employees
		USING (emp_no)
	-- ON dept_manager.emp_no = employees.emp_no
WHERE to_date > NOW()
-- current employees only
AND gender = 'F';
-- girls club, no boys allowed

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- ==========================================
-- ==========================================
-- ==========================================

-- Find the current titles of employees currently 
-- working in the Customer Service department.

-- ~Roadmap~: I want two things:
-- 1. the titles of employees
-- 2. the count of employees for each title
-- conditions: i want to specify the department 'Customer Service'
-- i want current employees
-- relationship: title table has an emp no ==> dept_emp does too
-- dept_emp has a department_no ==> departments does too
-- note: dept_emp and titles both have to_date fields.

-- grab the two things: title (from title table, 
-- unique to that table)
-- COUNT(*), an aggregate function that will 
-- require us to group by the titles.
SELECT title, COUNT(*)
-- from our first table:
FROM titles
-- first link via emp_no:
JOIN dept_emp ON titles.emp_no = dept_emp.emp_no
-- second link via dept_no:
JOIN departments ON departments.dept_no = dept_emp.dept_no
-- current employees only:
WHERE dept_emp.to_date > NOW()
AND titles.to_date > NOW()
-- customer service only:
AND dept_name = 'Customer Service'
-- GROUP BY to accomodate our COUNT(*)
GROUP BY title;

-- Results:
-- Title              | Count
-- -------------------+------
-- assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

-- ==========================================
-- ==========================================
-- ==========================================

-- Find the current salary of all current managers.
-- dept_manager only has numbers for employees and department 
-- if we want to expound on that, we need:
-- salaries to get the current sal via emp_no
-- employees to link via emp_no to salaries.
SELECT * FROM dept_manager LIMIT 5;

SELECT CONCAT(first_name, ' ',  last_name) AS full_name,
salary,
dept_name
FROM departments
	JOIN dept_manager AS dm
		USING (dept_no)
	JOIN salaries AS s
-- join to salaries using the emp_no
		USING (emp_no)
	JOIN employees
-- grab the employee names via emp_no
		USING (emp_no)
-- current employees only:
WHERE dm.to_date > NOW() 
AND s.to_date > NOW();


-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

-- ==========================================
-- ==========================================
-- ==========================================

-- Find the number of current employees in each department.
-- Similar to our earlier department question regarding
-- customer service.
-- map it out:
-- we want:
-- department, name and/or number, and the count of employees
-- Let's try a new trick: aliasing without the use of AS!
SELECT dept_no, dept_name, COUNT(*) num_employees
-- sneaky alias removal of AS after COUNT(*)
FROM employees
	JOIN dept_emp de 
    -- sneaky removal to alias as de ^
		USING (emp_no)
	JOIN departments
		USING (dept_no)
WHERE de.to_date > NOW()
-- current employees only^
GROUP BY dept_name;
-- dept names and numbers are one-to-one, so groupby is only
-- needed once here!

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

-- ==========================================
-- ==========================================
-- ==========================================

-- Which department has the highest average salary? 
-- Hint: USE current not historic information.
-- AVG instead of count this time!
-- salaries to departments via dept_emp!
SELECT dept_name, AVG(salary) AS avg_sal
FROM salaries s 
	JOIN dept_emp de 
		USING (emp_no)
	JOIN departments
		USING (dept_no)
WHERE de.to_date > NOW()
and s.to_date > NOW()
GROUP BY dept_name
-- order by avg_sal and limit 1
-- we could do this with a subquery, stay tuned!
ORDER BY avg_sal desc 
LIMIT 1;

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

-- ==========================================
-- ==========================================
-- ==========================================

-- Who is the highest paid employee in 
-- the Marketing department?
-- We need salaries as well as names and departments this time!
SELECT first_name, last_name, salary, dept_name
FROM employees e 
	-- from employees
	JOIN dept_emp de 
		USING (emp_no)
	-- to dept_emp
	JOIN departments d 
		USING (dept_no)
	-- to departments
	JOIN salaries s 
    -- to salaries
		USING (emp_no)
-- limit to marketing
WHERE dept_name = 'Marketing'
-- current emps only:
and de.to_date > NOW()
and s.to_date > NOW()
-- order and limit for the max
order by salary desc
LIMIT 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

-- ==========================================
-- ==========================================
-- ==========================================

-- Which current department manager has 
-- the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM dept_manager dm
	JOIN employees
		USING (emp_no)
	JOIN salaries s 
		USING (emp_no)
	JOIN departments
		USING (dept_no)
WHERE dm.to_date > NOW()
AND s.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

-- ==========================================
-- ==========================================
-- ==========================================

-- Determine the average salary for each department. 
-- USE all salary information and round your results.
SELECT dept_name, 
ROUND(AVG(salary), 0) AS avg_sal
FROM salaries
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		USING (dept_no)
GROUP BY dept_name;

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- BONUS QUESTIONS!!!!!
-- 
-- ==========================================
-- ==========================================
-- ==========================================
-- 11. Find the names of all current employees, 
-- their department name, 
-- and their current manager's name.

select concat(managers.first_name, " ", managers.last_name) as "manager_name", 
dept_name, 
concat(employees.first_name, " ", employees.last_name) as "Employee Name"
-- I know I need the names of my department managers.
-- Where are names? they're in the employees table
from employees as managers #aliasing here allows us to "self join" the employees table.
-- join in department manager to get the managerial status of the employees
join dept_manager using(emp_no)
-- join in departments from there to get the department name
join departments using(dept_no)
-- join in dept_emp to get the link back to employees
join dept_emp using(dept_no)
-- join back into employees to get the names of the employees this time
join employees on dept_emp.emp_no = employees.emp_no
where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate();


-- 12:

-- SELECT d.dept_name, d.dept_no, max(s.salary) AS sal
-- FROM salaries s
-- JOIN dept_emp de USING(emp_no)
-- JOIN departments d USING(dept_no)
-- WHERE de.to_date > NOW() AND s.to_date > NOW()
-- GROUP BY dept_name;


-- I'm going to make two queries here, that I call dmock and salmock.
-- dmock will give me my left table, with department names and max salaries.

-- salmock will be my current employees with departments and salaries.alter

-- I will then LEFT join dmock with salmock and establish that the salary and 
-- department match for each of those.
 
 -- The outer select will take from dmock and salmock.
SELECT dmock.dept_name, dmock.sal, salmock.namebo FROM

(
-- First query: dmock.
SELECT d.dept_name, d.dept_no, max(s.salary) AS sal
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_name) dmock
-- join dmock to our second query.
LEFT JOIN 
(SELECT CONCAT(e.first_name, ' ', e.last_name) namebo, s.salary, d.dept_name
FROM employees e
JOIN salaries s USING (emp_no)
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
WHERE de.to_date > NOW()
AND s.to_date > NOW()) salmock
-- how do we want to join dmock with salmock?
-- well, I want to get the names of the current employees that belong to those
-- specific salary and department names that I pulled from dmock
ON dmock.dept_name = salmock.dept_name AND dmock.sal = salmock.salary;
-- woo!
