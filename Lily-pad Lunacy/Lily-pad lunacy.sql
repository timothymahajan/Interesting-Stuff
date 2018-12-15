-- Lily-pad lunacy. 
-- Eleven lily pads are numbered from 0 to 10. 
-- A frog starts on pad 0 and wants to get to pad 10. 
-- At each jump, the frog can move forward by one or two pads, so there are many ways it can get to pad 10. 
-- For example, it can make 10 jumps of one pad, 1111111111, or five jumps of two pads, 22222, or go 221212 or 221122, and so on. 
-- We'll call each of these ways different, even if the frog takes the same jumps in a different order. 
-- How many different ways are there of getting from 0 to 10?

-- Solution

-- The frog can make at the most 10 jumps.
-- To model this situation, we will assume that every time it makes excactly 10 jumps, however, someof the jumps are of length 0.
-- We will eliminate 0-length jumpa after we are done modeling.

with 

jump_length as
(select 0 as ln union select 1 union select 2),

jump_patterns as
(
select distinct
replace(
cast(num1.ln as varchar(max)) + cast(num2.ln as varchar(max)) + 
cast(num3.ln as varchar(max)) + cast(num4.ln as varchar(max)) + 
cast(num5.ln as varchar(max)) + cast(num6.ln as varchar(max)) + 
cast(num7.ln as varchar(max)) + cast(num8.ln as varchar(max)) + 
cast(num9.ln as varchar(max)) + cast(num10.ln as varchar(max)),
'0', '') as jump_pattern
from jump_length as num1
cross join jump_length as num2 
cross join jump_length as num3
cross join jump_length as num4 
cross join jump_length as num5 
cross join jump_length as num6 
cross join jump_length as num7 
cross join jump_length as num8 
cross join jump_length as num9 
cross join jump_length as num10
where num1.ln + num2.ln + num3.ln + num4.ln + num5.ln + num6.ln + num7.ln + num8.ln + num9.ln + num10.ln = 10 
)

select count(1) as answer from jump_patterns
