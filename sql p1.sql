

drop table if exists p1;
create table p1(
transactions_id	int primary key, 
sale_date date, 
sale_time	time,
customer_id int,	
gender 	varchar(10),
age int,	
category varchar(15),	
quantiy int,
price_per_unit float,	
cogs	float,
total_sale float);

select * from p1 limit 100
drop table p1

select count (*) from p1 as total_count

-- DATA CEANING--
select * from p1
where transactions_id is null

select * from p1
where sale_date is null

select * from p1
where customer_id is null

select * from p1
where 
    gender is null
	or
	age is null
	or 
	category is null
	or 
	quantity is null
	or
	price_per_unit is null
	or 
	cogs is null
    or 
	total_sale is null

delete from p1
where 
 gender is null
	or
	age is null
	or 
	category is null
	or 
	quantity is null
	or
	price_per_unit is null
	or 
	cogs is null
    or 
	total_sale is null

---data exploration
  
--how many sale we have?
select count (*) as total_sale from p1

--how many unique customers we have?

select count (distinct customer_id) as unique_customers from p1
select count (customer_id) from p1

select count (distinct category) as category from p1
select distinct (category) as category from p1

--Data analysis & business key problems and answers

--Myanalysis and findings
--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the 
--      month of Nov-2022
--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
--Q.4 Write a SQL query find the average age of customers who purchased item from the 'Beauty' category.
--Q.5 Write a SQL query to find all transaction where the total_sale is greater then 1000.
--Q.6 Write a SQL query to find the total no. of transaction (transaction_id) made by each gender in each category.
--Q.7 Write a SQL query to calculate the average sale of each month. Find out best selling month of each year.
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
--Q.9 Write a SQL query to find the number of unique customers who purchase items of each category.
--Q.10 Write a SQL query to create each shift and number of orders (example morning <=12, Afternoon between 12 & 17, evening >17)


--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from p1
where
sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the 
--    month of Nov-2022

select 
   category,----1(group by 1 or group by category)
   sum(quantiy)---2
   from p1
where category = 'Clothing'
group by category
-------------------------------
select *
from p1
where
   category = 'Clothing'
   and
   to_char(sale_date, 'YYYY-MM') = '2022-11'
   and
   quantity >= 4

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as net_sale
from p1
where category in ('Clothing', 'Beauty', 'Electronics')
group by category

--Q.4 Write a SQL query find the average age of customers who purchased item from the 'Beauty' category.


select 
round(avg(age), 2) as ave_age
from p1
where category = 'Beauty'

--Q.5 Write a SQL query to find all transaction where the total_sale is greater then 1000.

select * from p1
where total_sale > 1000


--Q.6 Write a SQL query to find the total no. of transaction (transaction_id) made by each gender in each category.

select 
category,
gender,
count (*) as total_transaction
from p1
group by category, gender
order by category


--Q.7 Write a SQL query to calculate the average sale of each month. Find out best selling month of each year.


select * from
(select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as average_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from p1
group by 1, 2
)
as t1
where rank = 1

--order by 1, 3 desc

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select 
customer_id,
sum(total_sale) as total_sale
from p1
group by 1
order by 2 desc 
limit 5


--Q.9 Write a SQL query to find the number of unique customers who purchase items of each category.

select
category,
count(distinct customer_id) as unique_customers
from p1
group by category


--Q.10 Write a SQL query to create each shift and number of orders (example morning <=12, Afternoon between 12 & 17, evening >17)


with hourly_sale
as
(
select *,
   case
       when extract(hour from sale_time) < 12 then 'Morning'
	   when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
 	   else 'Evening'
		End as Shift
		from p1
)
select 
shift,
count(*) as total_orders
from hourly_sale
group by shift


--End of Project




group by shift











