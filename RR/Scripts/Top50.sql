#create col.State for table
alter table future50
add column State varchar(50)

#Move col.State
alter table future50
modify column State varchar(50) after Location


#cut State from col.location
with a as (select `Rank` ,trim(substr(Location,instr(location,',')+2)) as Stt 
from future50 f) 		
#update into table
update future50 as b 
inner join a
using(`Rank`)
set b.State=a.Stt
where b.State is null


#Numbers of Top50 Restaurants in States
select State,count(*) as `Number of Restaurants`
from future50 
group by State 
order by   `Number of Restaurants` desc



#Ranking Restaurants by State by sales
with rev as(select State,sum(Sales) as tol from future50 f group by State)
select rank() Over(partition by State order by Sales desc ) 
											as `Rank In State`,
		Restaurant,Location,State ,Sales, (select rev.tol from rev where f.State=rev.State) as `State's Revenue`
		from future50 f
		order by `State's Revenue` desc,Sales desc

		
#Calculate Sales of Restaurant comparing State and Total
with rev as(select State,sum(Sales) as tol from future50 f group by State)
select rank() Over(partition by State order by Sales desc ) as `Rank In State`,
		Restaurant,Location,State ,Sales, round(concat((Sales/(select rev.tol from rev where f.State=rev.State))*100,"%"),2) as `Sales/State`,
		 round(concat((Sales/(select sum(Sales) from future50))*100,"%"),2) as `Sales/Top50`,
		(select rev.tol from rev where f.State=rev.State) as `State's Revenue`
		from future50 f
		order by `State's Revenue` desc,Sales desc
		
		
#Average,Mean sales by state
select state,round(avg(sales)) as `Average Sales` 
		from future50 
		group by State 	
		order by `Average Sales` desc



#Franchising
select * from future50 where Franchising='Yes'
select State,count(*) as `Franchised Restaurants` 
		from future50 
		where Franchising='Yes' 
		group by State 
		order by `Franchised Restaurants` desc
		
select Franchising,count(*)`Number of Restaurants` 
		from future50 
		group by Franchising desc

		
