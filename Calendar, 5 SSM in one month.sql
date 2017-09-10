--5 Fridays, 5 Saturdays, and 5 Sundays in a month – happens only every 823 years?
--Can SQL help us take a look at this?



with calendar1 as 
(
select	1 as num, 
		CAST(1 as datetime) as dt, 
		datename(WEEKDAY,  CAST(1 as datetime)) as wd
union all
select	num + 1, 
		CAST(num + 1 as datetime), 
		datename(WEEKDAY, CAST(num + 1 as datetime)) 
		from calendar1 where num < 73413 --num < 2958463
),
calendar2 as
(
select 
YEAR(dt) as year,
MONTH(dt) as month,
SUM(case wd when 'Saturday' then 1 else 0 end) as Saturday,
SUM(case wd when 'Sunday' then 1 else 0 end) as Sunday,
SUM(case wd when 'Monday' then 1 else 0 end) as Monday
from calendar1
group by YEAR(dt), MONTH(dt) 
)
select * from calendar2
where 
1=1
and Saturday = 5
and Sunday = 5
and Monday = 5
order by year, month
option (maxrecursion 0)