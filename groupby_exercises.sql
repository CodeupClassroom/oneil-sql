use employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
select distinct title
from titles; -- looking at number of rows returned

select count(distinct title)
from titles; -- using the count function
-- A: 7 unique titles

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
select last_name
from employees
where last_name like 'e%e'
group by last_name;


-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select first_name, last_name
from employees
where last_name like 'e%e'
group by first_name, last_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
select distinct last_name
from employees
where last_name like '%q%'
	and last_name not like '%qu%';

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
select last_name, count(*)
from employees
where last_name like '%q%'
	and last_name not like '%qu%'
group by last_name;

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
select first_name, gender, count(*)
from employees
where first_name in ('Irena','Vidya','Maya')
group by first_name, gender
order by first_name;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username.
select 
	lower(
		concat(
			substr(first_name, 1, 1)
			,substr(last_name, 1, 4)
			, '_'
			,lpad(month(birth_date),2,0)
			,substr(birth_date, 3,2)
			)
		) as username
	, count(*)
from employees
group by username;


-- From your previous query, are there any duplicate usernames? 
-- What is the higest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there from your previous query?
select 
	lower(
		concat(
			substr(first_name, 1, 1)
			,substr(last_name, 1, 4)
			, '_'
			,lpad(month(birth_date),2,0)
			,substr(birth_date, 3,2)
			)
		) as username
	, count(*)
from employees
group by username
having count(*) >= 2
order by count(*) desc;
-- A: yes, there are duplicate user names. And the highest number of times a username shows up is 6. 
