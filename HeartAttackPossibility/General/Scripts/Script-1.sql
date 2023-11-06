alter table `2021`
add column `Rank` int(64) first


 with a as (select rank() over(order by `Ladder Score` desc) as 'Rank', `Country name` from `2021`)  		
#update into table
update `2021` as b 
inner join a
using(`Country name`)
set b.`Rank`=a.`Rank`
where b.`Rank` is null










