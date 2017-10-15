-- 1. There are five houses, each of a different color.
-- 2. In each house lives a person of distinct nationality.
-- 3. Each tenant drinks a certain beverage, smokes a certain brand of cigarette and owns a certain pet.
-- 4. None of the five people drink same drinks, smoke same cigarettes or own same pets.
 
-- Question: Who owns the fish?
 
-- Tips:
-- 1. The Englishman lives in the red house
-- 2. The Swede owns dogs
-- 3. The Dane drinks tea
-- 4. The green house is immediately to the left of the white
-- 5. The green house owner drinks coffee
-- 6. The person who smokes Pall Mall, owns a bird
-- 7. The owner of the center house drinks milk
-- 8. The owner of the yellow house smokes Dunhill
-- 9. The Norwegian lives in the first house
-- 10. Marlboro smoker lives next to the one who owns cats
-- 11. A person who owns a horse lives next to the man who smokes Dunhill
-- 12. Winfield cigarette smoker drinks beer
-- 13. The Norwegian's next door neighbor lives in blue house
-- 14. The German smokes Rothmans
-- 15. Marlboro smoker lives next to the man who drinks water

with
color as (select 'red' as color union select 'white' union select 'yellow' union select 'blue' union select 'green'),
man as (select 'd' as man union select 's' union select 'n' union select 'e' union select 'g'),
pet as (select 'dog' as pet union select 'bird' union select 'fish' union select  'horse' union select 'cat'),
drink as (select 'tea' as drink union select 'milk' union select 'water' union select  'coffee' union select 'beer'),
smoke as (select 'pm' as smoke union select 'd' union select 'm' union select 'r' union select 'w'),
house as (select 1 as house union select 2 union select 3 union select 4 union select 5),
total as
(
select man, color, pet, drink, smoke, house,
[1a] = case man when 'e' then case when color <> 'red' then 0 else 1 end else 1 end,
[1b] = case color when 'red' then case when man <> 'e' then 0 else 1 end else 1 end,
[2a] = case man when 's' then case when pet <> 'dog' then 0 else 1 end else 1 end,
[2b] = case pet when 'dog' then case when man <> 's' then 0 else 1 end else 1 end,
[3a] = case man when 'd' then case when drink <> 'tea' then 0 else 1 end else 1 end,
[3b] = case drink when 'tea' then case when man <> 'd' then 0 else 1 end else 1 end,
[4a] = case color when 'white' then case when house = 1 then 0 else 1 end else 1 end,
[4b] = case color when 'green' then case when house = 5 then 0 else 1 end else 1 end,  
[5a] = case color when 'green' then case when drink <> 'coffee' then 0 else 1 end else 1 end,
[5b] = case drink when 'coffee' then case when color <> 'green' then 0 else 1 end else 1 end,
[6a] = case smoke when 'pm' then case when pet <> 'bird' then 0 else 1 end else 1 end,
[6b] = case pet when 'bird' then case when smoke <> 'pm' then 0 else 1 end else 1 end,
[7a] = case house when 3 then case when drink <> 'milk' then 0 else 1 end else 1 end,
[7b] = case drink when 'milk' then case when house <> 3 then 0 else 1 end else 1 end,
[8a] = case smoke when 'd' then case when color <> 'yellow' then 0 else 1 end else 1 end,
[8b] = case color when 'yellow' then case when smoke <> 'd' then 0 else 1 end else 1 end,
[9a] = case man when 'n' then case when house <> 1 then 0 else 1 end else 1 end,
[9b] = case house when 1 then case when man <> 'n' then 0 else 1 end else 1 end,
[10] = case smoke when 'm' then case when pet = 'cat' then 0 else 1 end else 1 end,
[11] = case smoke when 'd' then case when pet = 'horse' then 0 else 1 end else 1 end,
[12a] = case smoke when 'w' then case when drink <> 'beer' then 0 else 1 end else 1 end,
[12b] = case drink when 'beer' then case when smoke <> 'w' then 0 else 1 end else 1 end,
[13] = case man when 'n' then case when color = 'blue' then 0 else 1 end else 1 end,
[14a] = case smoke when 'r' then case when man <> 'g' then 0 else 1 end else 1 end,
[14b] = case man when 'g' then case when smoke <> 'r' then 0 else 1 end else 1 end,
[15] = case smoke when 'm' then case when drink = 'water' then 0 else 1 end else 1 end,
--n can only live in yellow, because, if he is in green, then the next house should be white, but it is blue [13]
[16a] = case color when 'yellow' then case when man <> 'n' then 0 else 1 end else 1 end,
[16b] = case man when 'n' then case when color <> 'yellow' then 0 else 1 end else 1 end,
--because house 1 is yellow, [4a] ca be modified
[4c] = case color when 'white' then case when house = 2 then 0 else 1 end else 1 end,
--because only choice of drink for n is water , no one else can have it
[17] = case drink when 'water' then case when man <> 'n' then 0 else 1 end else 1 end,
--because n drinks water, someone who smokes m lives next to him in house 2
[18a] = case smoke when 'm' then case when house <> 2 then 0 else 1 end else 1 end,
[18b] = case house when 2 then case when smoke <> 'm' then 0 else 1 end else 1 end,
--because n smokes d water, someone who keeps horse lives next to him in house 2 [8]
[19a] = case pet when 'horse' then case when house <> 2 then 0 else 1 end else 1 end,
[19b] = case house when 2 then case when pet <> 'horse' then 0 else 1 end else 1 end,
--because only g has an option to live in green house, he cannot be in any other house 
[20] = case man when 'g' then case when color <> 'green' then 0 else 1 end else 1 end,
--because green house can only be 4, then no other house can be 4
[21] = case house when 4 then case when color <> 'green' then 0 else 1 end else 1 end,
--because house 4 is green, 5 is white [4]
[4d] = case house when 5 then case when color <> 'white' then 0 else 1 end else 1 end,
--because e keeps bird, no one else keeps bird
[22] = case pet when 'bird' then case when man <> 'e' then 0 else 1 end else 1 end,
--because the one who smokes m and lives in house 2 lives next to a cat owner, can can live in house 1 only [10]
[10a] = case pet when 'cat' then case when house <> 1 then 0 else 1 end else 1 end,
-- because cat is kept in house 1, it is kept by n
[23] = case man when 'n' then case when pet <> 'cat' then 0 else 1 end else 1 end
from man cross join color cross join pet cross join drink cross join smoke cross join house
)

select man, color, pet, drink, smoke, house
from total
where
1=1
and [1a] = 1 and [1b] = 1
and [2a] = 1 and [2b] = 1
and [3a] = 1 and [3b] = 1
and [4a] = 1 and [4b] = 1
and [5a] = 1 and [5b] = 1
and [6a] = 1 and [6b] = 1
and [7a] = 1 and [7b] = 1
and [8a] = 1 and [8b] = 1
and [9a] = 1 and [9b] = 1
and [10] = 1
and [11] = 1
and [12a] = 1 and [12b] = 1
and [13] = 1
and [14a] = 1 and [14b] = 1
and [15] = 1
and [16a] = 1 and [16b] = 1
and [4c] = 1
and [17] = 1
and [18a] = 1 and [18b] = 1
and [19a] = 1 and [19b] = 1
and [20] = 1
and [21] = 1
and [4d] = 1
and [22] = 1
and [10a] = 1
and [23] = 1
order by house
