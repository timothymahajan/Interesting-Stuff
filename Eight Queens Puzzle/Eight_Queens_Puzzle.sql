--Eight queens puzzle

--The eight queens puzzle is the problem of placing eight chess queens on an 8×8 chessboard 
--so that no two queens attack each other. 
--Thus, a solution requires that no two queens share the same row, column, or diagonal. 

with 
letter as (select 97 as num, CHAR(97) as letter union all select num + 1, CHAR(num+1) from letter where num < 104),
number as (select 1 as num union all select num + 1 from number where num < 8),
board1 as (select letter, number.num from letter cross join number),
board2 as (select row_number() over (order by num, letter) as rn, letter, num from board1), 
board3 as (select rn, letter, num, case((rn+num)%2) when 0 then 'black' else 'white' end as color, rn%9 as d1, rn%7 as d2 from board2),
board4 as (select rn, letter, num, color, d1, d2, dense_rank() over (partition by d1 order by color) as rk1, dense_rank() over (partition by d2 order by color) as rk2 from board3),
board5 as (select rn, letter, num, color, case(rk1) when 1 then d1 + 1 else d1 + 7 end as d1, case(rk2) when 1 then d2 + 1 else d2 + 8 end as d2 from board4),
board as (select rn, letter, num, color, d1, case(rn) when 64 then 15 else d2 end as d2 from board5),
b1 as (select rn, letter, num, color, d1, d2 from board where num = 1), 
b2 as (select rn, letter, num, color, d1, d2 from board where num = 2), 
b3 as (select rn, letter, num, color, d1, d2 from board where num = 3), 
b4 as (select rn, letter, num, color, d1, d2 from board where num = 4), 
b5 as (select rn, letter, num, color, d1, d2 from board where num = 5), 
b6 as (select rn, letter, num, color, d1, d2 from board where num = 6), 
b7 as (select rn, letter, num, color, d1, d2 from board where num = 7), 
b8 as (select rn, letter, num, color, d1, d2 from board where num = 8)
select 
b1.letter+CAST(b1.num as varchar(max)) as [1], b2.letter+CAST(b2.num as varchar(max)) as [2],
b3.letter+CAST(b3.num as varchar(max)) as [3], b4.letter+CAST(b4.num as varchar(max)) as [4], 
b5.letter+CAST(b5.num as varchar(max)) as [5], b6.letter+CAST(b6.num as varchar(max)) as [6],
b7.letter+CAST(b7.num as varchar(max)) as [7], b7.letter+CAST(b7.num as varchar(max)) as [8]
from b1 cross join b2 cross join b3 cross join b4 
cross join b5 cross join b6 cross join b7 cross join b8
where 
1=1
and b1.letter <> b2.letter
and b1.letter <> b3.letter
and b1.letter <> b4.letter
and b1.letter <> b5.letter
and b1.letter <> b6.letter
and b1.letter <> b7.letter
and b1.letter <> b8.letter
and b2.letter <> b3.letter
and b2.letter <> b4.letter
and b2.letter <> b5.letter
and b2.letter <> b6.letter
and b2.letter <> b7.letter
and b2.letter <> b8.letter
and b3.letter <> b4.letter
and b3.letter <> b5.letter
and b3.letter <> b6.letter
and b3.letter <> b7.letter
and b3.letter <> b8.letter
and b4.letter <> b5.letter
and b4.letter <> b6.letter
and b4.letter <> b7.letter
and b4.letter <> b8.letter
and b5.letter <> b6.letter
and b5.letter <> b7.letter
and b5.letter <> b8.letter
and b6.letter <> b7.letter
and b6.letter <> b8.letter
and b7.letter <> b8.letter

and b1.d1 <> b2.d1
and b1.d1 <> b3.d1
and b1.d1 <> b4.d1
and b1.d1 <> b5.d1
and b1.d1 <> b6.d1
and b1.d1 <> b7.d1
and b1.d1 <> b8.d1
and b2.d1 <> b3.d1
and b2.d1 <> b4.d1
and b2.d1 <> b5.d1
and b2.d1 <> b6.d1
and b2.d1 <> b7.d1
and b2.d1 <> b8.d1
and b3.d1 <> b4.d1
and b3.d1 <> b5.d1
and b3.d1 <> b6.d1
and b3.d1 <> b7.d1
and b3.d1 <> b8.d1
and b4.d1 <> b5.d1
and b4.d1 <> b6.d1
and b4.d1 <> b7.d1
and b4.d1 <> b8.d1
and b5.d1 <> b6.d1
and b5.d1 <> b7.d1
and b5.d1 <> b8.d1
and b6.d1 <> b7.d1
and b6.d1 <> b8.d1
and b7.d1 <> b8.d1

and b1.d2 <> b2.d2
and b1.d2 <> b3.d2
and b1.d2 <> b4.d2
and b1.d2 <> b5.d2
and b1.d2 <> b6.d2
and b1.d2 <> b7.d2
and b1.d2 <> b8.d2
and b2.d2 <> b3.d2
and b2.d2 <> b4.d2
and b2.d2 <> b5.d2
and b2.d2 <> b6.d2
and b2.d2 <> b7.d2
and b2.d2 <> b8.d2
and b3.d2 <> b4.d2
and b3.d2 <> b5.d2
and b3.d2 <> b6.d2
and b3.d2 <> b7.d2
and b3.d2 <> b8.d2
and b4.d2 <> b5.d2
and b4.d2 <> b6.d2
and b4.d2 <> b7.d2
and b4.d2 <> b8.d2
and b5.d2 <> b6.d2
and b5.d2 <> b7.d2
and b5.d2 <> b8.d2
and b6.d2 <> b7.d2
and b6.d2 <> b8.d2
and b7.d2 <> b8.d2

order by b1.rn




