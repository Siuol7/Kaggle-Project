# Information about survey's participant as customer segment
#1 Average Age of the Survey's Participants
select round(avg(age)) as "Avg Survey's age"from cellphones_users cu

#Gender division in the survey 
select gender,count(gender) as "Quantity" 
from Cellphone.cellphones_users 
group by gender 


# Comparision between brands
#1 Average Price
select brand,ceil(avg(price)) as "Average Price " 
from Cellphone.cellphones_data cd  
group by brand
order by 2 desc


#2 Brand's Diversity
select brand, count(model) as "Number of model" 
from cellphones_data cd 
group by brand
order by 2 desc


#3 Average performance
select brand, round(avg(performance),1) as "Average Performance"
from cellphones_data 
group by brand 
order by 2 desc 

#4 Average age by brands-> segmenting
select Brand, round(avg(b.age)) as `Average age` from cellphones_data
inner join cellphones_users b 
using(cellphone_id)
group by Brand




#Mode model  between brands,price range and models
with sub as(select brand,model, b.cellphone_id,count(b.cellphone_id) as mode,price,
case 
	when 0<price and price<500 then '<500'
	when 500<=price and price<=1000 then '500-1000'
	when 1000<price then 'Over 1000'
end as `Range`
from cellphones_data a 
inner join cellphones_users b
using(cellphone_id)	
group by model)

select* from (select row_number() over(partition by sub.`Range`,sub.brand order by sub.mode desc ) as Ranking, 
				sub.brand,sub.model,sub.mode,price,sub.`Range` from sub) as subb


#Mode model  between price range and models	with genders
with sub as(select brand,model, b.cellphone_id,count(b.cellphone_id) as mode,price, 
			count(b.gender) as `Number of Male Users`,
			case 
				when 0<price and price<500 then '<500'
				when 500<=price and price<=1000 then '500-1000'
				when 1000<price then 'Over 1000'
			end as `Range`
from cellphones_data a 
inner join cellphones_users b
using(cellphone_id)	
where gender='Male'
group by model)

select* from (select row_number() over(partition by sub.`Range` order by sub.mode desc ) as Ranking, 
				sub.brand,sub.model,sub.mode,price,sub.`Number of Male Users`,`Range` 
				from sub) as subb			
where Ranking in (1,2,3)
				
							

#Revenue by brands from participants
with sub as (select brand,model,cellphone_id,count((b.cellphone_id)) as Quantity from cellphones_users 
inner join cellphones_data b 
using(cellphone_id)
group by model)

select c.Brand,sum(sub.Quantity*price) as Revenue from cellphones_data c
inner join sub
using (cellphone_id)
group by brand
order by Revenue desc








