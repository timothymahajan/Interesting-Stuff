-- The Tower of Hanoi  

-- The Tower of Hanoi consists of three rods, and a number of disks of different sizes which can slide onto any rod. 
-- The puzzle starts with the disks in a neat stack in ascending order of size on one rod, 
-- the smallest at the top, thus making a conical shape.
 
-- The objective of the puzzle is to move the entire stack to another rod, obeying the following rules:
-- Only one disk may be moved at a time.
-- Each move consists of taking the upper disk from one of the rods and sliding it onto another rod, 
-- on top of the other disks that may already be present on that rod.
-- No disk may be placed on top of a smaller disk.
 
-- With three disks, the puzzle can be solved in seven moves.
with 
rodes as (select 1 as rode union all select 2 union all select 3), 
position1 as 
(
select r1.rode as d1, r2.rode as d2, r3.rode as d3, r4.rode as d4, r5.rode as d5
from 
rodes r1 cross join rodes r2 cross join rodes r3 cross join rodes r4 cross join rodes r5
), 
position as
(
select d1, d2, d3, d4, d5,
case d1 when 1 then '1' else '' end + case d2 when 1 then '2' else '' end + 
case d3 when 1 then '3' else '' end + case d4 when 1 then '4' else '' end + case d5 when 1 then '5' else '' end as t1,
case d1 when 2 then '1' else '' end + case d2 when 2 then '2' else '' end + 
case d3 when 2 then '3' else '' end + case d4 when 2 then '4' else '' end + case d5 when 2 then '5' else '' end as t2,
case d1 when 3 then '1' else '' end + case d2 when 3 then '2' else '' end + 
case d3 when 3 then '3' else '' end + case d4 when 3 then '4' else '' end + case d5 when 3 then '5' else '' end as t3,
ROW_NUMBER() over (order by d1, d2, d3, d4, d5) as pos_num 
from position1 
), 
moves as 
(
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '1->2' as move
from position pos1 cross join position pos2
where 
len(pos1.t1) > 0 and (LEN(pos1.t2) = 0 or SUBSTRING(pos1.t1, LEN(pos1.t1), 1) > SUBSTRING(pos1.t2, LEN(pos1.t2), 1)) and pos1.t3 = pos2.t3 and pos2.t1 = SUBSTRING(pos1.t1, 1, LEN(pos1.t1) - 1) and pos2.t2 = pos1.t2 + SUBSTRING(pos1.t1, LEN(pos1.t1), 1)
UNION ALL
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '2->1' as move
from position pos1 cross join position pos2
where 
len(pos1.t2) > 0 and (LEN(pos1.t1) = 0 or SUBSTRING(pos1.t2, LEN(pos1.t2), 1) > SUBSTRING(pos1.t1, LEN(pos1.t1), 1)) and pos1.t3 = pos2.t3 and pos2.t2 = SUBSTRING(pos1.t2, 1, LEN(pos1.t2) - 1) and pos2.t1 = pos1.t1 + SUBSTRING(pos1.t2, LEN(pos1.t2), 1)
UNION ALL
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '1->3' as move
from position pos1 cross join position pos2
where
len(pos1.t1) > 0 and (LEN(pos1.t3) = 0 or SUBSTRING(pos1.t1, LEN(pos1.t1), 1) > SUBSTRING(pos1.t3, LEN(pos1.t3), 1)) and pos1.t2 = pos2.t2 and pos2.t1 = SUBSTRING(pos1.t1, 1, LEN(pos1.t1) - 1) and pos2.t3 = pos1.t3 + SUBSTRING(pos1.t1, LEN(pos1.t1), 1)
UNION ALL
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '3->1' as move
from position pos1 cross join position pos2
where
len(pos1.t3) > 0 and (LEN(pos1.t1) = 0 or SUBSTRING(pos1.t3, LEN(pos1.t3), 1) > SUBSTRING(pos1.t1, LEN(pos1.t1), 1)) and pos1.t2 = pos2.t2 and pos2.t3 = SUBSTRING(pos1.t3, 1, LEN(pos1.t3) - 1) and pos2.t1 = pos1.t1 + SUBSTRING(pos1.t3, LEN(pos1.t3), 1)
UNION ALL
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '2->3' as move
from position pos1 cross join position pos2
where
len(pos1.t2) > 0 and (LEN(pos1.t3) = 0 or SUBSTRING(pos1.t2, LEN(pos1.t2), 1) > SUBSTRING(pos1.t3, LEN(pos1.t3), 1)) and pos1.t1 = pos2.t1 and pos2.t2 = SUBSTRING(pos1.t2, 1, LEN(pos1.t2) - 1) and pos2.t3 = pos1.t3 + SUBSTRING(pos1.t2, LEN(pos1.t2), 1)
UNION ALL
select 
pos1.t1 as t11, pos1.t2 as t12, pos1.t3 as t13, pos2.t1 as t21, pos2.t2 as t22, pos2.t3 as t23,
pos1.pos_num as pos_num_1, pos2.pos_num as pos_num_2, '3->2' as move
from position pos1 cross join position pos2
where
len(pos1.t3) > 0 and (LEN(pos1.t2) = 0 or SUBSTRING(pos1.t3, LEN(pos1.t3), 1) > SUBSTRING(pos1.t2, LEN(pos1.t2), 1)) and pos1.t1 = pos2.t1 and pos2.t3 = SUBSTRING(pos1.t3, 1, LEN(pos1.t3) - 1) and pos2.t2 = pos1.t2 + SUBSTRING(pos1.t3, LEN(pos1.t3), 1)
),
path as 
(
select 1 as move_num, 
pos_num_1, pos_num_2, 
cast(move as varchar(max)) + ';' as move, 
cast(pos_num_1 as varchar(max)) + '->' as move_map,
0 as cycle 
from moves where pos_num_1 = 1
union all 
select move_num + 1, 
moves.pos_num_1, moves.pos_num_2, 
cast(path.move as varchar(max)) + cast(moves.move as varchar(max)) + ';', 
move_map + cast(moves.pos_num_1 as varchar(max)) + '->',
case when move_map like '%' + cast(moves.pos_num_1 as varchar(max)) + '%' then 1 else 0 end
from moves inner join path on path.pos_num_2 = moves.pos_num_1 where cycle = 0 and move_num < 31
)

select * from path where pos_num_2 = 243 --order by move_num

--select * from moves
--where t23 = '12345'

