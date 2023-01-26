-- ORDER BY, LIMIT, OFFSET

-- Reasons behind these:
-- ORDER BY: a clause to sort by columns
-- LIMIT: cut off our values at a certain point
-- OFFSET: skip a number of values

-- ORDER BY will arrange a table by sorting the values
-- from the field(s) specified
-- we can clarify if we want to go ascending with ASC
-- or descending with desc
-- ASC will happen by default but you can still specify
USE fruits_db;
SELECT * FROM fruits ORDER BY quantity ASC;

USE albums_db;
SELECT * FROM albums;
SELECT * FROM albums ORDER BY artist, 
release_date DESC;
-- We can order by two different fields,
-- the first will assume ascending by default here
-- as we specified previously, and the second will descend
-- When we get to Celine Dion, We now see her albums presented
-- Counting down in years in those instances where her artist 
-- name is present

SELECT * FROM albums LIMIT 4;
-- Limit will tell the table to inclusively stop at the num
-- that we specify.  This is the first four rows

-- Comining a order by with a limit
SELECT * FROM albums ORDER BY id DESC LIMIT 4;

-- Current layout for query needs:
-- SELECT
-- what field(s)
-- FROM
-- what table?
-- optional: WHERE (what condition do I want to specify)
-- optional: ORDER BY (what field(s) do I want to sort?)
-- optional: LIMIT (do I want to cut off results?)

SELECT * FROM albums LIMIT 10 OFFSET 5;
-- OFFSET will work in conjunction with a LIMIT
-- with the potential to paginate information
-- LIMIT 10 OFFSET 5 will skip the first 5 results
-- and serve us the next 10 rows

