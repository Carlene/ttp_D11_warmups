-- (northwind database)
-- On which day of the month are the most *orders* being placed (use only the 2 most recent years of data)?
-- which day has the lowest number of orders? Are you suprised? Why would this day have the least?

--- the most recent two years
WITH recent_year as (
select extract(year from orderdate) as two_year

from orders

group by 1

order by 1 DESC

limit 2)

select 
 extract(day from orderdate) as day
 ,count(orderid) as order_count

from 
 orders as o

where 
 extract(year from orderdate) = 2016
or extract(year from orderdate) = 2015

group by 
 1

order by
 2

-- The 31st has the least amount of days, probably because every month doesn't have a 31st.


-- On which day of the WEEK are the most *orders* being placed (use only the most recent year of data)?
-- What can you say about any trends in orders being placed? 





--How out of date is this database (ie the last order compared to today's date)
