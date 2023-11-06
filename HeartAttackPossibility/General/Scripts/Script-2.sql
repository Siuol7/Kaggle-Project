select* from `2019` a
inner join `2020` b
on a.`Country or region` = b.`Country name`
inner join `2021` c 
on b.`Country name` = c.`Country name`