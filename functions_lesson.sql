-- FUNCTIONS -- 
-- format to call: name_of_function(input)

-- SQL has built in functions. Yay! 
-- Let's investigate
   -- numberic functions
   -- string functions
   -- datetime functions
   -- casting


-- Let's use the ablums db for demo
show databases;

use albums_db;

show tables;


-- Count 
select count(name) from albums;


-- NUMERICAL FUNCTIONS -- 

-- min, max, avg

select min(release_date) as min_release_date
	, max(release_date)
	, round(avg(release_date) ,1) -- chained two functions
from albums;


-- STRING FUNCTIONS -- 

-- Concat: combines things together
-- format: CONCAT(expression1, expression2, expression3,...)

select concat('hello', 'world', '!') as helloworld;


select concat('my favorite artist is ', artist, '!')
from albums;

select concat(artist, ' -- ', name) as artist_album
	, release_date
from albums; 


-- Substr: extracts a portion of element 
-- format: SUBSTR(string, start, length)


select substr('hello oneil class', 7, 5);
select substr('hello oneil class', 7); -- dont need to enter length

select substr(release_date, 3, 2), release_date 
from albums;

select release_date, 
	substr(release_date, -2)  -- you can send negative values!
from albums;

select substr('123-456-7890', -4);


-- Case conversation
select artist, upper(artist), lower(artist), release_date
from albums;



-- Replace: replace an element with something else
-- format: REPLACE(string, from_string, new_string)

select replace('hello oneil class!', 'oneil','O\'Neil');

select genre, 
	replace(lower(genre), 'rock', '****ROCK***') as genre_ROCK
    , genre
from albums;



-- TIME AND DATE FUNCTIONS -- 

select now(), CONVERT_TZ(now(),'+00:00','-06:00'); -- converted to central time

select now(), CONVERT_TZ(now(),'GMT','MET'); -- did not work

select current_date();

select curdate();

select curtime();

select now(), current_date(), curtime();

select UNIX_TIMESTAMP();



-- CASTING: change datatype of variable 
-- format: CAST(value AS)

select 1 + '2'; -- generally dont need to case in mysql

select month('2023-01-23');

select 1 + cast('2' as unsigned);

