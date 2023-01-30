-- GROUP BY -- 

-- let's use the chipotle db
show databases;

use chipotle;

show tables;

select * from orders;

-- find all unique items with chicken
select item_name
from orders
where item_name like '%chicken%'
;

select distinct item_name
from orders
where item_name like '%chicken%'
;


select item_name
from orders
where item_name like '%chicken%'
group by item_name
;


-- can group by multiple variables
-- find all unqiue combinations of items with chicken and their quantity


select item_name, quantity
from orders
where item_name like '%chicken%'
group by quantity, item_name
order by item_name
;


-- AGGREGRATE FUNCTIONS -- 

-- count
-- how many chicken bowls have been ordered?

select count(item_name)
from orders
where item_name like '%chicken bowl%';


-- for each chicken item, how many times was it ordered?

select item_name, count(item_name)
from orders
where item_name like '%chicken%'
group by item_name
;

select item_name, quantity, count(item_name)
from orders
where item_name like '%chicken%'
group by item_name, quantity
order by item_name
;

-- min, max



select item_name,quantity
from orders
where item_name like '%chicken%'
group by item_name, quantity
order by item_name;

select *
from orders
where item_name like '%chicken%';

select item_name, min(quantity), max(quantity)
from orders
where item_name like '%chicken%'
group by item_name
;

-- HAVING -- 

-- find all orders items that have been ordered over 100 times
select item_name, count(item_name) as count_items
from orders
where item_name like '%chicken%'
group by item_name
having count_items  > 100;


