--A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

--Find the largest palindrome made from the product of two 3-digit numbers.

	with
	number as
	(
	select 100 as number
	union all select number + 1 from number where number < 999
	)
	select top 1	
	number1.number as [Number 1], 
	number2.number as [Number 2],  
	number1.number*number2.number as [Largest Palindrome]
	from number number1 cross join number number2
	where 
	cast(number1.number*number2.number as varchar(100)) 
		= reverse(cast(number1.number*number2.number as varchar(100)))
	order by number1.number*number2.number desc
    option (maxrecursion 0)
