--There is an array containing all the integers from 1 to n in some order, except that one integer is missing. 
--Suggest an efficient algorithm for finding the missing number.

declare @array varchar(max) =  '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25';
declare @sql varchar(max) = '';
--declare @last int = reverse(substring(reverse(@array), 1, charindex(',', reverse(@array), 1) - 1));
declare @last int = len(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(@array, '0', ''), '1', ''), '2', ''), '3', ''), '4', ''), '5', ''), '6', ''), '7', ''), '8', ''), '9', '')) + 2;
with num as (select 1 as num, cast('1' as varchar(max)) as arr union all select num + 1, arr + '^' + cast((num + 1) as varchar(max)) from num where num < @last) 
select @sql = 'select ' + replace(@array, ',', '^') + '^'  + (select arr from num where num = @last) option (maxrecursion 0);
exec(@sql);


