use employees;

-- Find all the current employees with the same hire date 
-- as employee 101010 using a subquery.

select *
from employees
where emp_no = '101010';


select *
from employees
	join dept_emp
		using (emp_no)
where to_date > now()
and hire_date = 
	(
    select hire_date
	from employees
	where emp_no = '101010'
	)
;

-- Find all the titles ever held by all current employees with the first name Aamod.

select emp_no
from employees
where first_name = 'Aamod';

select title, count(*) as cnt
from dept_emp
	join titles
		using (emp_no)
where dept_emp.to_date > now()
and emp_no in 
	(
	select emp_no
	from employees
	where first_name = 'Aamod'
	)
group by title
;


-- How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.

select emp_no,
from dept_emp 
where to_date > now();

-- this is checking that all the employees no longer work there
select emp_no, max(to_date) as max_date
from employees
	join dept_emp
		using (emp_no)
where emp_no not in 
	(
    select emp_no
	from dept_emp 
	where to_date > now()
    )
group by emp_no
order by max_date desc
;

-- real answer: 59,900
select count(emp_no)
from employees
where emp_no not in 
	(
    select emp_no
	from dept_emp 
	where to_date > now()
    )
;

-- Find all the current department managers that are female. 
-- List their names in a comment in your code.

select emp_no
from dept_manager
where to_date > now();

select first_name, last_name, gender
from employees
where gender = 'F'
	and emp_no in 
		(
        select emp_no
		from dept_manager
		where to_date > now()
        )
;


-- Find all the employees who currently have a higher salary than the companies overall
-- historical average salary.

select avg(salary)
from salaries;

select first_name, last_name, salary, to_date
from salaries
	join employees
		using (emp_no)
where to_date > now()
and salary > 
	(
    select avg(salary)
	from salaries
    )
order by salary
;

-- How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

select max(salary)
from salaries
where to_date > now();

select stddev(salary)
from salaries
where to_date > now();

select count(*)
from salaries
where to_date > now()
and salary > 
	(
	( -- max salary
    select max(salary)
	from salaries
	where to_date > now()
    )
    -
    ( -- one standard deviation 
    select stddev(salary)
	from salaries
	where to_date > now()
    )
    )
; -- 83 returned salaries



-- What percentage of all salaries is this?

select 
(
select count(*)
from salaries
where to_date > now()
and salary > 
	(
	( -- max salary
    select max(salary)
	from salaries
	where to_date > now()
    )
    -
    ( -- one standard deviation 
    select stddev(salary)
	from salaries
	where to_date > now()
    )
    )
)
/ 
(
select count(*) from salaries where to_date > now()
) * 100
;

-- BONUS
-- Find all the department names that currently have female managers.
-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.