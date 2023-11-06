#Question 1

select ifnull(contact,'guest') as contact, count(case when type='purchase' then 1 end) as sold
from customer c
inner join document d 
on c.id=d.customer_id
group by 1
order by 2 desc

#Question 2

set @date = '2021-01-01 00:00:00.000'


select warehouse,sku,balance
from movement
where warehouse='HK' and created_at=@date


#Question 3

set @date = '2021-01-02 00:00:00.000'

with cte as (
select warehouse, sku, quantity,balance as total,created_at, ifnull(lag(created_at) over(partition by warehouse, sku order by created_at asc), created_at) as last_day
from movement
where warehouse='HK')

select warehouse, sku,total, created_at,
		case 
			when datediff(created_at,last_day) between 0 and 30 then '0-30 days'
			when datediff(created_at,last_day) between 31 and 60 then '31-60 days'
			when datediff(created_at,last_day) between 61 and 90 then '61-90 days'
			else '90+ days'
		end as age_group, sum(quantity)as recently_purchased
from cte
where created_at=@date
group by 2,4,5
