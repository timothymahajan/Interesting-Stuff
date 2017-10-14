--100 doors

--Problem:
--You have 100 doors in a row that are all initially closed. 
--You make 100 passes by the doors. 
--You make odd passes left to right and even passes right to left.
--The first time through, you visit every door and toggle the door
--(if the door is closed, you open it; if it is open, you close it). 
--The second time you only visit every 2nd door (door #2, #4, #6, ...). 
--The third time, every 3rd door (door #3, #6, #9, ...), etc, until you only visit the 100th door. 

--Question: What state are the doors in after the last pass? Which are open, which are closed? 

with 

number100 AS
(
	SELECT 
		1 as num 
	UNION ALL 
	SELECT 
		num + 1 
	FROM number100 
	WHERE num < 100 
),

passes_left_to_right_ as
(
select 
	1 as cnt, 
	cast('1' as varchar(max)) as base, 
	cast(replicate('1', 100) as varchar(max)) as passes
union all 
select 
	cnt + 1, 
	'0' + base, 
	left(replicate(cast('0' as varchar(max)) + base, 100), 100)
from passes_left_to_right_
where cnt < 100
),

passes_right_to_left_ as
(
select 
	cnt, 
	REVERSE(passes) as passes
from passes_left_to_right_
),

passes_left_to_right as
(
select  
	cnt, 
	passes
from passes_left_to_right_
where cnt%2 = 1
),

passes_right_to_left as
(
select 
	cnt, 
	passes 
from passes_right_to_left_
where cnt%2 = 0
),

passes as
(
select  
	cnt, 
	passes  
from passes_left_to_right
union all
select  
	cnt, 
	passes  
from passes_right_to_left
),

passes100 as
(
select 
passes.cnt, 
passes, 
Number100.num 
from passes 
cross join number100
),

sums as 
(
select 
	num, 
	SUM(cast(SUBSTRING(passes, num, 1) as int)) as sums 
from passes100 
group by num
)

select num as 'Opened Doors' from sums where sums%2 = 1

