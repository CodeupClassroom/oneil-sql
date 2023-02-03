-- Use the chipotle database/schema
USE chipotle;
SHOW TABLES;
-- Grab a preview of the only table here
SELECT * FROM orders LIMIT 10;
DESCRIBE orders;

-- Grab just the item_name from the orders table
SELECT item_name FROM orders LIMIT 5;
-- Grab True values for any instance in item_names
-- Where that specific instance is a chicken item

-- Previously we have used logic statements to
-- narrow down the filter of what we want to select
SELECT 
item_name 
FROM orders 
WHERE 
item_name LIKE '%chicken%';

-- In this case, I want to change the output of the cells
-- This calls for a different application of logic!
SELECT item_name,
-- IF acts like a function call, use parens
IF( item_name LIKE '%chicken%', 1, 0) AS chicken_type
-- IF ( <truth condition>, 
-- <value if case is true>,
-- <value if case is false>)
FROM orders
LIMIT 25;

-- Change the output of that IF statement:
SELECT IF(
-- our initial IF statement
item_name LIKE '%steak%',
-- first condition => if this value inside of item_name
-- has something in it that looks like the string value steak
-- If steak is there, let's make a new condition to see
-- if its a steak bowl or just another steak item
IF ( item_name LIKE '%bowl%',
	'steak bowl',
    'other steak item'
),
-- If it didnt have steak in it at all, we are just going
-- to go directly to not_steak and not even mess with the
-- nested condition
'not_steak') AS steak_col
FROM orders;

-- Use a case stament if we want to throw in some extra
-- conditions in the mix
-- Case statements are like IF statements,
-- but they are structured a little different 
-- CASE statements allow for multiple logic checks in a row

-- STRUCTURE of a CASE statement:
-- Let's build out our first case:

SELECT item_name,
quantity,
CASE item_name
	WHEN 'chicken bowl' THEN 1
    ELSE 0
END AS chicken_bowls
FROM orders;

-- adding an extra layer:
SELECT item_name,
quantity,
CASE item_name
-- set up a case where we look at the item name
	WHEN 'chicken bowl' THEN 'bowl'
-- when its a chicken bowl, give me bowl
    WHEN 'chicken burrito' THEN 'burrito'
-- when its a chicken burrito give me burrito
    ELSE 'not chicken that I care about'
-- all other cases give me this
END AS chicken_bowls
FROM orders;

-- Limitations of what I just did above:
-- it can only check for direct equivalence!!
-- the following will break!!
-- SELECT item_name,
-- CASE item_name
-- WHEN LIKE '%chicken%' THEN 'chickeny'
-- ELSE 'not chicken'
-- END AS chicken_type_beat
-- FROM orders;

SELECT item_name,
CASE
WHEN item_name LIKE '%chicken%' THEN 'chicken type'
WHEN item_name LIKE '%steak%' THEN 'steak type'
ELSE 'other thing'
END AS 'meat check'
FROM orders;

USE join_example_db;
SELECT * FROM users;

SELECT role_id,
CASE
	WHEN role_id > 2 THEN  'high roller'
    WHEN role_id = 1 THEN 'some role'
    WHEN role_id IS NULL THEN 'idk'
    ELSE 'will you see this?'
END AS 'case_results'
FROM users;

-- Let's talk about the first thing with ifs a little bit more
-- wrap the count function around an if:
SELECT COUNT(
IF(role_ID = 3, 1, 0)) AS role_3 FROM users;

-- we dont even need to use an if statement there!
SELECT (role_id > 2) FROM users;


-- check out this mess!
USE employees;
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;


-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;
