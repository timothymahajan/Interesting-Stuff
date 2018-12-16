-- Lily-pad lunacy. 
-- Eleven lily pads are numbered from 0 to 10. 
-- A frog starts on pad 0 and wants to get to pad 10. 
-- At each jump, the frog can move forward by one or two pads, so there are many ways it can get to pad 10. 
-- For example, it can make 10 jumps of one pad, 1111111111, or five jumps of two pads, 22222, or go 221212 or 221122, and so on. 
-- We'll call each of these ways different, even if the frog takes the same jumps in a different order. 
-- How many different ways are there of getting from 0 to 10?

-- Solution

-- The frog can make at the most 10 jumps.
-- To model this situation, we will assume that every time it makes excactly 10 jumps, however, some of the jumps are of length 0.
-- We will eliminate 0-length jumps after we are done modeling.
-- This solution is a dynamic parameter that takes the number of pads as a parameter.

declare @n int = 15;
declare @sql varchar(max) = '';
declare @sql1 varchar(max) = '';
declare @sql2 varchar(max) = '';
declare @sql3 varchar(max) = '';

with numbers as
(
select 1 as number
union all select number + 1 from numbers where number < @n
)

select 
@sql1 = @sql1 + ' cast(num' + cast(number as varchar(max)) + '.number as varchar(max)) + ',
@sql2 = @sql2 + ' cross join numbers as num' + cast(number as varchar(max)),
@sql3 = @sql3 + ' num' + cast(number as varchar(max)) + '.number + '

from numbers;
set @sql = 
'
with

numbers as
(select 0 as number union select 1 union select 2),

jump_patterns as
(
select distinct
replace(
'
+ @sql1 +

'
+ '''',
''0'', '''') as number
from numbers as num1'

+

@sql2 + ' where ' + @sql3 + ''''' = ' + cast(@n as varchar(max)) + ') select count(1) as answer from jump_patterns';

set @sql = replace(@sql, 'from numbers as num1 cross join numbers as num1', 'from numbers as num1')

exec(@sql)
