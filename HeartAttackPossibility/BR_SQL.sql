#Data Preparation
with cte as (select age,
		case 
			when sex=1 then 'male'
			else 'female'
		end as 'sex',
		case 
			when cp=0 then 'typical agina'
			when cp=1 then 'atypical agina'
			when cp=2 then 'non-aginal pain'
			else 'asymptomatic'
		end 'cp',
		trestbps,chol,
		case 
			when fbs=0 then 'False'
			else 'True'
		end as 'fbs',
		restecg, thalach,
		case 
			when exang=1 then 'Yes'
			else 'No'
		end as 'exang', oldpeak,
		case 
			when slope=0 then 'unsloping'
			when slope=1 then 'flat'
			else 'downsloping'
		end as 'thal',
		case 
			when target=1 then 'heart disease'
			else 'no heart disease'
		end as 'target'
from heart)
select count(exang) as 'Count of Exang',target 
from cte
group by 2
order by 1 desc

#----------------------------------------------------------------------------------------------
#Sex Distribution
select Sex,count(sex) as 'Sex distribution',
		concat(round(count(sex)/(select count(*) from cte)*100,2),'%') as 'Percentage'
from cte group by sex

#Heart Attack Patient Distribution
select Target, count(*) as 'Number of People',
		concat(round(count(target)/(select count(*) from cte)*100,2),'%') as 'Percentage'
from cte group by 1


#Heart Attack Patient By Age
select Age, count(age) as 'Number of Patients' 
from cte 
group by 1 
order by 2 desc

		
#---------------------------------Target Comparison------------------------------------------------------------
#Average of Thalach by target
select target ,avg(thalach) as 'Average of Max Bps'
from cte
group by 1
order by 2 desc 

#Count of Exang by target
select target ,count(exang) as 'Number of Exang'
from cte
group by 1
order by 2 desc

#Count of Fbs by target
select target,count(fbs) as 'Number of Fbs',
from cte
group by 1
order 2 desc

#Average of Trestbps by target
select target,avg(trestbps) as 'Average of Trestbps',
from cte
group by 1
order 2 desc

#Average of Oldpeak by target 
select target,avg(oldpeak) as 'Average of Oldpeak',
from cte
group by 1
order 2 desc

#Average of Chol by target
select target,avg(chol) as 'Average of chol',
from cte
group by 1
order 2 desc


#Number of people by oldpeak and target 
select oldpeak,count(oldpeak) as 'Number of People',target 
from cte
group by 1,3
order by 2 desc 

#Number of people by Thalach and target 
select thalach,count(thalach) as 'Number of People',target 
from cte
group by 1,3
order by 2 desc 

#Number of people by trestbps and target 
select trestbps,count(trestbps) as 'Number of People',target 
from cte
group by 1,3
order by 2 desc 

#Number of people by cholestarol and target 
select chol,count(chol) as 'Number of People',target 
from cte
group by 1,3
order by 2 desc 

#Number of people by Thalessemia and target 
select thal,count(thal) as 'Number of People',target 
from cte
group by 1,3
order by 1

#Number of people by Chestpain and target 
select cp,count(cp) as 'Number of People',target 
from cte
group by 1,3
order by 1


#Number of people by Chestpain and target 
select cp,count(cp) as 'Number of People',target 
from cte
group by 1,3
order by 1

#Number of people by Restacg and target 
select restacg,count(restacg) as 'Number of People',target 
from cte
group by 1,3
order by 1

#--------------------------------------Analytics-------------------------------------------------------

#Average of Thalach by gender
select sex ,avg(thalach) as 'Average of Max Bps'
from cte
group by 1
order by 2 desc 

#Count of Exang by gender
select sex ,count(exang) as 'Number of Exang'
from cte
group by 1
order by 2 desc

#Count of Fbs by gender
select sex,count(fbs) as 'Number of Fbs',
from cte
group by 1
order 2 desc

#Average of Trestbps by gender
select sex,avg(trestbps) as 'Average of Trestbps',
from cte
group by 1
order 2 desc

#Average of Oldpeak by gender
select sex,avg(oldpeak) as 'Average of Oldpeak',
from cte
group by 1
order 2 desc

#Average of Chol by gender
select sex,avg(chol) as 'Average of chol',
from cte
group by 1
order 2 desc


#Number of people by oldpeak and gender
select oldpeak,count(oldpeak) as 'Number of People',sex 
from cte
group by 1,3
order by 2 desc 

#Number of people by Thalach and target 
select thalach,count(thalach) as 'Number of People',sex
from cte
group by 1,3
order by 2 desc 

#Number of people by trestbps and target 
select trestbps,count(trestbps) as 'Number of People',sex
from cte
group by 1,3
order by 2 desc 

#Number of people by cholestarol and target 
select chol,count(chol) as 'Number of People',sex
from cte
group by 1,3
order by 2 desc 

#Number of people by Thalessemia and target 
select thal,count(thal) as 'Number of People',sex 
from cte
group by 1,3
order by 1

#Number of people by Chestpain and target 
select cp,count(cp) as 'Number of People',sex
from cte
group by 1,3
order by 1


#Number of people by Chestpain and target 
select cp,count(cp) as 'Number of People',sex
from cte
group by 1,3
order by 1

#Number of people by Restacg and target 
select restacg,count(restacg) as 'Number of People',sex
from cte
group by 1,3
order by 1








		
		
		
		
		
		
		
		
		