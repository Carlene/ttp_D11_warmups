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
 extract(year from orderdate) = 
	(select extract(year from orderdate) as two_year

	from orders

	group by 1

	order by 1 DESC

	limit 1)

or 

extract(year from orderdate) = 
	(select extract(year from orderdate) as two_year

	from orders

	group by 1

	order by 1 DESC

	offset 1

	limit 1)

group by 
 1

order by
 2

-- The 31st has the least amount of days, probably because every month doesn't have a 31st.


-- On which day of the WEEK are the most *orders* being placed (use only the most recent year of data)?
-- What can you say about any trends in orders being placed? 

select
extract(dow from orderdate) as day_of_week
,count(orderid) as ordercount

from orders

where extract(year from orderdate) = 
(select extract(year from orderdate) as two_year

from orders

group by 1

order by 1 DESC

limit 1)

group by 1

order by 2 DESC

--with named days

select
CASE 
WHEN extract(dow from orderdate) = 0 THEN 'Sunday'
WHEN extract(dow from orderdate) = 1 THEN 'Monday'
WHEN extract(dow from orderdate) = 2 THEN 'Tuesday'
WHEN extract(dow from orderdate) = 3 THEN 'Wednesday'
WHEN extract(dow from orderdate) = 4 THEN 'Thursday'
WHEN extract(dow from orderdate) = 5 THEN 'Friday'
WHEN extract(dow from orderdate) = 6 THEN 'Saturday'
END as day_of_week
,count(orderid) as ordercount

from orders

where extract(year from orderdate) = 
(select extract(year from orderdate) as two_year

from orders

group by 1

order by 1 DESC

limit 1)

group by 1

order by 2 DESC

-- sundays and tuesdays are pretty light for orders, otherwise they're pretty consistent with a spike in orders on fridays


--How out of date is this database (ie the last order compared to today's date)

select
current_date - max(orderdate) as days_since_last_order

from orders
