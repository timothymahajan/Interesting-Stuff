--100 people standing in a circle.

--100 people standing in a circle in an order 1 to 100. 
--No.1 has a sword. 
--He kills next person (i.e.no. 2 )and gives sword to next to next (i.e no.3). 
--All person does the same until only 1 survives. 
--Which number survives at the last? 
--http://puzzles4you.blogspot.com/


declare @num int = 5;
with 
people0 as 
(
select 
1 as orig_num, 1 as num
union all 
select 
orig_num + 1, num + 1 from people0
where num < @num
),
people1 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people0
where num%2 = 1
),
people2 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people1
where num%2 = case (select COUNT(*) from people1) when 1 then 1 else (select COUNT(*) from people1)%2 end
),
people3 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people2
where num%2 = case (select COUNT(*) from people2) when 1 then 1 else (select COUNT(*) from people2)%2 end
), 
people4 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people3
where num%2 = case (select COUNT(*) from people3) when 1 then 1 else (select COUNT(*) from people3)%2 end 
),
people5 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people4
where num%2 = case (select COUNT(*) from people4) when 1 then 1 else (select COUNT(*) from people4)%2 end 
),
people6 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people5
where num%2 = case (select COUNT(*) from people5) when 1 then 1 else (select COUNT(*) from people5)%2 end 
),
people7 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people6
where num%2 = case (select COUNT(*) from people6) when 1 then 1 else (select COUNT(*) from people6)%2 end 
),
people8 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people7
where num%2 = case (select COUNT(*) from people7) when 1 then 1 else (select COUNT(*) from people7)%2 end 
),
people9 as
(
select 
orig_num, ROW_NUMBER() over (order by orig_num) as num
from people8
where num%2 = case (select COUNT(*) from people8) when 1 then 1 else (select COUNT(*) from people7)%2 end 
)
select * from people6
option (maxrecursion 0)
