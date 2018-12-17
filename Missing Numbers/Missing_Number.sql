--Missing numbers.  
--Imagine you are given a list of slightly less than 1,000,000 numbers, all different, and each between 0 and 999,999 inclusive. 
--How could you find (in a reasonable time) a number between 0 and 999,999 that is not on the list?

--In this solution we rely on the fact that one and only one number is missing out of a consecutive sequence of numbers, given in any order.
--We have used a comma as a separator. The same principle would be applied to a larger list.
--We can also sum them instead of XORing them, but the latter uses less operations.

declare @array varchar(max) =  '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25';
declare @sql varchar(max) = '';
declare @last int = len(@array) - len(replace(@array, ',', '')) + 2;
with num 
as (select 1 as num, cast('1' as varchar(max)) as arr 
union all select num + 1, arr + '^' + cast((num + 1) as varchar(max)) from num where num < @last) 
select @sql = 'select ' + replace(@array, ',', '^') + '^'  + (select arr from num where num = @last) 
option (maxrecursion 0);
exec(@sql);
