-- Copy the order by exercise and save it as functions_exercises.sql.

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
select concat(first_name, last_name) as full_name
from employees
where last_name like 'e%e';


-- Convert the names produced in your last query to all uppercase.
select upper(concat(first_name, last_name)) as full_name
from employees
where last_name like 'e%e';

-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),
select now(), curdate();

select datediff(now(), hire_date) as days_worked, hire_date
from employees
where birth_date like '%12-25'
	and hire_date between '1990-01-01' and '1999-12-31'
;

-- Find the smallest and largest current salary from the salaries table.
select min(salary), max(salary)
from salaries
where to_date >= now()
;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born, 
-- and the last two digits of the year that they were born. 
select
	lower(
    concat(
	substr(first_name, 1,1)
    , substr(last_name, 1,4)
    , '_'
    , substr(birth_date,6,2)
    , substr(birth_date, 3,2)
    )
    ) as username
from employees
limit 10
;





