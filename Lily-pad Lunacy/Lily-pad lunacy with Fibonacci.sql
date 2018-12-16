-- Lily-pad lunacy. 
-- Eleven lily pads are numbered from 0 to 10. 
-- A frog starts on pad 0 and wants to get to pad 10. 
-- At each jump, the frog can move forward by one or two pads, so there are many ways it can get to pad 10. 
-- For example, it can make 10 jumps of one pad, 1111111111, or five jumps of two pads, 22222, or go 221212 or 221122, and so on. 
-- We'll call each of these ways different, even if the frog takes the same jumps in a different order. 
-- How many different ways are there of getting from 0 to 10?

-- Solution

-- If we know what it takes for a frog to reach pad n,
-- we can observe that pad n+1 can be reached by a jump of length 1 from pad n or by a jump of length 2 from pad n-1.
-- Therefore, to reach pad n+1 there exist exactly the sum of ways to reach pad n-1 and pad n.
-- Therefore, the solution represents the Fibonacci Sequence.

declare @n int = 10;

with
numbers as 
(
select 1 as number1, 1 as number2, 1 as step
union all select number2, number1 + number2, step + 1 from numbers where step <= @n

)

select top 1 number1 as fibonacci from numbers
order by number1 desc
option (maxrecursion 0)
