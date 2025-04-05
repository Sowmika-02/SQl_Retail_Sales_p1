/*created the data base for the project retail sales */
create database sql_project_1;

use sql_project_1;

/*created the data base for the project retail sales */
create table retail_sales ( 
transactions_id	int Primary key ,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(15),
age	int,
category varchar(15),
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale float
);

select * from retail_sales ;

select count(*) from retail_sales ;

/*null values in the tabel */
select * from retail_sales
where 
transactions_id is null  or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null ;


/*insert values in the tabel */
insert into retail_sales (transactions_id,customer_id)
values(679,64),(746,42),(1225,137);

SELECT @@SQL_SAFE_UPDATES;
/*If it returns 1, Safe Mode is ON.

If it returns 0, Safe Mode is OFF.*/

SET SQL_SAFE_UPDATES = 0;  /*To Disable Safe Mode Temporarily*/

SET SQL_SAFE_UPDATES = 1; /*turn Safe Mode back on for safety*/

START TRANSACTION; /* to make temparory changes */
 DELETE FROM retail_sales
     WHERE 
    transactions_id IS  NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
                             /* rollback ; to grt back the deleted rows */
commit ;  /* to delete perminently */


/*data  exploration*/

select sum(total_sale) from retail_sales ;

select count(*) from retail_sales ;/*total no of sales*/


select count(DISTINCT customer_id)  from retail_sales;  /*total no of customer*/

select count(DISTINCT category)  from retail_sales; /*total category*/

select DISTINCT category from retail_sales; /* names of the total category*/


/* data analyst or business problems */

/* 1. write the sql query to retrieve all colums for sales on "2022_11_05 */

select * from retail_sales
where sale_date='2022_11_05';

/* 2. write the sql query to retrieve all transaction whwere the category is clothing and the Quantity sold is more than 10 in the month of november in the year 2022 */

select  ROW_NUMBER() OVER () AS sno, retail_sales.* from retail_sales
where category='Clothing' and Quantiy >=4 and month(sale_date)=11 and year(sale_date)=2022;

/* 3. write a query to calcutae Total sales for each category */ 

select sum(Total_sale) , category ,count(*) from retail_sales
group by category ;

/* 4.write a query to find the average age of the customers who purchased items from the beauty category. */

select round(avg(age),2) from retail_sales
where category="beauty" ;

/* 5.write a sql query to find all transaction where the total_sales is greater than 1000 */

select count( transactions_id) from retail_sales
where total_sale > 1000 ;

/* 6.write the sql query to find the total number of transactions (transaction_id) made by each gender in each category.*/

select  category,age,count(transactions_id) from retail_sales
group by age,category;

/*  7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year */

select  month(sale_date) as months,year(sale_date) years,avg(total_sale) as average from retail_sales
group by month(sale_date),year(sale_date) 
order by average DESC
limit 1;

/*8.Write a SQL query to find the top 5 customers based on the highest total sales */

select customer_id, sum(total_sale) as total_sales from Retail_sales
group by customer_id
order by total_sales desc;

/*9. Write a SQL query to find the number of unique customers who purchased items from each category.*/

select count(distinct customer_id) as unique_customer, category
from retail_sales 
group by category; 

/*10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) */

select 
case 
	when extract(hour from sale_time) < 12 then 'morning'
    when extract(hour from sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift , COUNT(*) as total_orders  
from retail_sales
group by shift ;


/* END OF THE PROJECT */













