declare @size as int = 67;
declare @sql as varchar(max) = '';
declare @sql1 as varchar(max) = '';
declare @sql2 as varchar(max) = '';
with 
num as
(
select 1 as num
union all select num + 1 from num where num < @size
)
select 
@sql1  = @sql1 + ', cast(0 as bigint) as [' + cast(num+1 as varchar(max)) + ']', 
@sql2  = @sql2 + ', cast([' + cast(num as varchar(max)) +']+[' + cast(num+1 as varchar(max)) + '] as bigint) ' 
from num where num < @size
set @sql = 'with triangle as (select 1 as rn, cast(1 as bigint) as [1]'  
			+ @sql1 + ' union all select rn+1, cast(1 as bigint)' 
			+ @sql2 + ' from triangle where rn < ' 
			+ cast(@size as varchar(max)) + ') select * from triangle option (maxrecursion 0)' 
exec(@sql)
