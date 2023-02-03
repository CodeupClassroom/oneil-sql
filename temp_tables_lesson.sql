show databases;

# use your database since it has write permissions 
use bayes_811;



# create a temporary table called my_numbers
# with two columns - n & name 
create temporary table my_numbers -- new table name
	(
    n int unsigned not null, -- one column with name and datatype
    named varchar(20) not null  -- another column 
    )
;

-- view table that i created 
select * from my_numbers;

show tables;


# insert data in my_numbers
insert into my_numbers(n, name)
values (1,'a'), (2,'b'), (3,'c'),(4,'d'),(5,'e')
;

# verify data was inserted
select * from my_numbers;

# update values in temp table
update my_numbers -- update table_name
set name = 'BIG' -- what you want to change
where n >=4  -- where you want to change it
;

select * from my_numbers;


# delete values from temp table
delete from my_numbers -- delete from table
where n = 2 -- what i want to delete
;

select * from my_numbers; -- the whole row is now gone

# -----------------------------------------------------
# switching to the employees database to create new temp table
use employees;


# find all current employees in customer service
# include their current salary

select first_name, last_name, salary, dept_name
from employees
	join dept_emp de  
		using (emp_no)
	join salaries as s
		using (emp_no)
	join departments 
		using (dept_no)
where de.to_date < now()
	and s.to_date < now()
	and dept_name = 'Customer Service'
;


# create a temporary table from the above query

create temporary table bayes_811.curr_employees as 
-- save table name in my database
	(
	select first_name, last_name, salary, dept_name
	from employees
		join dept_emp de  
			using (emp_no)
		join salaries as s
			using (emp_no)
		join departments 
			using (dept_no)
	where de.to_date > now()
	    and s.to_date >  now()
		and dept_name = 'Customer Service'
    )
;

-- if the table is already created, must drop table to recreate it 
drop table bayes_811.curr_employees;

select database( );

select * from bayes_811.curr_employees; -- since im still in the employees db, must specify my db


# switch back to my database & verify temp tables

use bayes_811;

show tables; -- our temp tables don't show up

select * from curr_employees; -- they do exist however


# What is the average salary for current employees in Customer service

select round(avg(salary), 2) as avg_salary
from curr_employees;


# Add a new column for avg salary in temp table

alter table curr_employees -- alter table table_name
add avg_dept_salary float -- add column_name data_type
; 

select * from curr_employees;


# update the average salary
select round(avg(salary),2) from curr_employees;

update curr_employees
set avg_dept_salary = 67285.23
;

select * from curr_employees;

select * from my_numbers; -- this table is still here

# delete table
drop table curr_employees; -- deleting the temp table

select * from curr_employees; -- this table no longer exists
