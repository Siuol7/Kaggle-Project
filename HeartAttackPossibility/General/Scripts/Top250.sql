alter table `2020`
add column `Rank` int(64) first


 with a as (select rank() over(order by `Ladder Score` desc) as 'Rank', `Country name` from `2020`)  		
#update into table
update `2020` as b 
inner join a
using(`Country name`)
set b.`Rank`=a.`Rank`
where b.`Rank` is null










