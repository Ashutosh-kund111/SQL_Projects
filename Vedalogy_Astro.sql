use b_projects;


select * from astrology_customer;

select gender,sum(amount) total_revenue
from astrology_customer
group by gender;

---- which plan has been opted maximum time by customers
select plan,count(*) as ordered from astrology_customer group by plan order by ordered desc limit 1;

select plan , max(count(plan)) as most_ordered from astrology_customer group by  plan , max(count(plan))  order by most_ordered desc limit 1;

with cte as (select plan, count(*) as ordered from astrology_customer group by plan)
select plan, ordered from cte order by ordered desc limit 1;
----- I want to find out the age group who have been ordered most of times or most order taken placed by age group


select distinct(age) from astrology_customer order by age asc;

select age, max(ordered) from(
select  age,count(age) as ordered from astrology_customer group by age order by count(age) DESC LIMIT 2) a
; 

WITH AgeCounts AS (
    SELECT 
        age,
        COUNT(*) AS ordered,
        RANK() OVER ( ORDER BY COUNT(*) DESC) AS rnk,
        DENSE_RANK() OVER ( ORDER BY COUNT(*) DESC) AS Drnk
    FROM astrology_customer
	group by age
)
SELECT 
    age,
    ordered
FROM AgeCounts
WHERE rnk = 1;

