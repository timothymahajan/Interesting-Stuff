--100 doors

--Problem:
--You have 100 doors in a row that are all initially closed.
--You make 100 passes by the doors.
--All passes are made left to right.
--The first time through, you visit every door and toggle the door
--(if the door is closed, you open it; if it is open, you close it).
--The second time you only visit every 2nd door (door #2, #4, #6, ...).
--The third time, every 3rd door (door #3, #6, #9, ...), etc, until you only visit the 100th door.

--Question: What state are the doors in after the last pass? Which are open, which are closed?

declare @n int = 100;

with

doors as

(
select 1 as step, cast('1' + replicate('0', @n-1 ) as varchar(100)) as door
union all select step + 1,
cast(stuff(door,  step%@n + 1, 1, case when (step%@n + 1)%(step/@n + 1) = 0 then (case substring(door, step%@n + 1, 1) when '0' then '1' else '0' end) else cast(substring(door, step%@n + 1, 1) as varchar(max)) end) as varchar(100))
from doors where step < @n*@n
)

select step
from doors
where
step <= @n
and substring((select top 1 door from doors order by step desc), step, 1)  = '1'
option (maxrecursion 0)
