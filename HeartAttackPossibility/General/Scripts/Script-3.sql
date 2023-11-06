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


#Average Rating
select brand,model,round(avg(b.rating)) as `Average Rating` from cellphones_data 
inner join cellphones_ratings b 
using(cellphone_id)
group by model
order by `Average Rating` desc


#Most rating model by brand, price range
with sub as(select brand,model,round(avg(b.rating),2) as `Average Rating`,price,
case 
	when 0<price and price<500 then '<500'
	when 500<=price and price<=1000 then '500-1000'
	when 1000<price then 'Over 1000'
end as `Range`
from cellphones_data a 
inner join cellphones_ratings b
using(cellphone_id)	
group by model)

select* from (select row_number() over(partition by sub.`Range`order by sub.`Average Rating` desc ) as Ranking, 
				sub.brand,sub.model,sub.`Average Rating`,price,sub.`Range` from sub) as subb


#Top3 rating model by brand, price range, and its technichal statistics 
with sub as(select brand,model,round(avg(b.rating),2) as `Average Rating`,price, 
			`internal memory`,RAM,`battery size`,`main camera`,
			`selfie camera`,`screen size`,weight,performance, 
			case 
				when 0<price and price<500 then '<500'
				when 500<=price and price<=1000 then '500-1000'
				when 1000<price then 'Over 1000'
			end as `Range`
from cellphones_data a 
inner join cellphones_ratings b
using(cellphone_id)	
group by model)

select* from (select row_number() over(partition by sub.`Range` order by sub.`Average Rating` desc ) as Ranking,`Range`,  
				sub.brand,sub.model,sub.`Average Rating`,price,performance,`internal memory`,RAM,`battery size`,`main camera`,
		`selfie camera`,`screen size`,weight 
				from sub) as subb

where Ranking in (1,2,3)
				
			








