-- Using the example from the lesson, 
-- create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name 
-- for employees currently with that department. 

select database();

use employees; -- switching to the employees db to make my temp table

-- copied code from curriculum 
CREATE TEMPORARY TABLE bayes_811.employees_with_departments AS -- added my database name since im in the employees db
SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees
		JOIN dept_emp 
			USING(emp_no)
		JOIN departments 
			USING(dept_no)
LIMIT 100;

select * from employees_with_departments; -- doesn't work in since im in the employees db

use bayes_811; -- switching to my db

select * from employees_with_departments; -- table properly created


-- Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the 
-- sum of the lengths of the first name and last name columns

select max(length(concat(first_name, last_name))) + 1 
from employees_with_departments; -- find the max length of full name

alter table employees_with_departments
add full_name varchar(21) -- hardcode the length of the full name string
;

select * from employees_with_departments; -- verify column created

-- Update the table so that full name column contains the correct data
update employees_with_departments
set full_name = concat(first_name, ' ', last_name)
;

select * from employees_with_departments; -- verify it worked

-- Remove the first_name and last_name columns from the table.
alter table employees_with_departments
drop column first_name, 
drop column last_name -- can drop both column with separate drop column commands
;

select * from employees_with_departments; -- verify it worked


-- What is another way you could have ended up with this same table?
-- A: created the table i wanted in my initial query and then turn it into a temp table

-- Create a temporary table based on the payment table from the sakila database.
use sakila;

show tables;

select * from payment;

drop table if exists bayes_811.payments; -- only drop the table if it exists, it not, no error

create temporary table bayes_811.payments as -- saving temp table to my db
	select *
    from payment
;

use bayes_811; -- switching back to my db

select * from payments; -- verify table was created in my db

-- Write the SQL necessary to transform the amount column 
-- such that it is stored as an integer 
-- representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

update payments
set amount =  amount * 100; -- tried updating but it errors

describe payments; -- look at the datatype, notice that it only accepts an decimal that is five chars long

alter table payments
modify amount decimal(10,2) -- use modify command to all the decimal datatype to hold up to 10 chars
; 

describe payments; -- verify modified datatype

update payments
set amount =  amount * 100; -- now update amount value

select * from payments; -- verify

alter table payments
modify amount int; -- now change it to an int to retain the 99

select * from payments; -- verify


# another way 
create temporary table payments_another_way as 
	select
		payment_id
        , customer_id
        , staff_id
        , rental_id
        , (amount * 100) as amount -- multipying this value before i save it into the temp table
        , payment_date
        , last_update
    from sakila.payment
;

select * from payments_another_way; -- verify

alter table payments_another_way -- now just change it into an integer
modify amount int 
;

select * from payments_another_way; -- verify

-- Find out how the current average pay in each department 
-- compares to the overall current pay 
-- for everyone at the company. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? The worst?

-- z-score = (x - mean) / standard deviation
-- z-score = (each department average salary - overall average salary) 
--                   / overall standard deviation of salaries

use employees; -- switch back to employees to build my query

-- first i will determine the average salary for each department
select dept_name, round(avg(salary),2) as avg_salary 
	from departments
		join dept_emp
			using (dept_no)
		join salaries
			using (emp_no)
	where salaries.to_date > now()
		and dept_emp.to_date > now()
	group by dept_name;
    
drop table if exists bayes_811.avg_dept_salaries; -- drop if the table exists

-- create table in my db
create temporary table bayes_811.avg_dept_salaries as
	( 
	select dept_name, round(avg(salary),2) as avg_salary
	from departments
		join dept_emp
			using (dept_no)
		join salaries
			using (emp_no)
	where salaries.to_date > now()
		and dept_emp.to_date > now()
	group by dept_name
    )
;

-- verify table in my db
select * 
from bayes_811.avg_dept_salaries; 


-- reminder: 
-- z-score = (each department average salary - overall average salary) / overall standard deviation 

-- i need the overall average salary
select avg(salary) from employees.salaries
where to_date > now()
;
-- i need the overall average standard deviation
select stddev(salary) from employees.salaries
where to_date > now()
;

-- i will save these values into my temp table

-- switching over to my db to expand on my temp table
use bayes_811;

-- add new column for the overall average salary 
-- add new column for overall average standard deviation 
alter table avg_dept_salaries
add overall_avg_salary float;

alter table avg_dept_salaries
add overall_std_salary float;

-- verify & see that all columns are created and empty rn 
select *
from avg_dept_salaries; 


-- add in data to my newly created columns
-- using my select statements from earlier
update avg_dept_salaries
set overall_avg_salary = 
	(select round(avg(salary),2) from employees.salaries where to_date > now())
;

update avg_dept_salaries
set overall_std_salary = 
	(select round(std(salary),2) from employees.salaries where to_date > now())
;

-- verify 
select *
from avg_dept_salaries
;


-- reminder to calculate: 
-- z-score = (each department average salary - overall average salary) 
--                    / overall standard deviation 

-- add new z-score columns
alter table avg_dept_salaries
add zscore float;

update avg_dept_salaries
set zscore = (avg_salary - overall_avg_salary) / overall_std_salary
;

-- verify 
select *
from avg_dept_salaries
;

-- order by to get best and worst departments 
select *
from avg_dept_salaries
order by zscore desc
;
    
    