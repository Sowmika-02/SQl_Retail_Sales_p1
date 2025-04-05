# RETAIL_SALES ANALYSIS  SQL PROJECT

## Project Overview

**Project Title:** Retail Sales Analysis
**Level:** Beginner 
**Database:** sql_project_1 

This project involves the analysis of retail sales data using MySQL. The goal is to explore the dataset, clean and prepare it, and extract meaningful business insights through SQL queries.

## Objectives
1. **Create the database and import the retail sales data from an Excel file.**
2. **Identify and clean any null or missing values in the dataset.**
3. **Perform basic exploratory SQL queries to better understand the data.**
4.**Execute business-oriented SQL queries to derive valuable insights from the sales data.**

## Project Strcture 
1.database setup
~ **create the database named as sql_project_1**
~ **creat the table named as retail_sales and import the data from the excel file.**

```sql
create database sql_project_1;
```


**created the data base for the project retail sales **:

```sql
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
```

2. Data  Cleaning
~ **The original dataset had no null values.**
~ **To demonstrate data cleaning, a few records were manually inserted with null fields.**
~ **SQL Safe Mode was temporarily disabled to allow deletion of these records.**
~ **All inserted null records were successfully identified and removed.**
~ **Safe Mode was re-enabled after cleanup for safety.**

```sql
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
```


3. data  exploration
~ run some data exploration query to undestand the data.
```sql
select sum(total_sale) from retail_sales ;

select count(*) from retail_sales ;/*total no of sales*/


select count(DISTINCT customer_id)  from retail_sales;  /*total no of customer*/

select count(DISTINCT category)  from retail_sales; /*total category*/

select DISTINCT category from retail_sales; /* names of the total category*/
```



4. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:


** 1. write the sql query to retrieve all colums for sales on "2022_11_05 **:
```sql
select * from retail_sales
where sale_date='2022_11_05';
```

**  2. write the sql query to retrieve all transaction whwere the category is clothing and the Quantity sold is more than 10 in the month of november in the year 2022 **:
```sql
select  ROW_NUMBER() OVER () AS sno, retail_sales.* from retail_sales
where category='Clothing' and Quantiy >=4 and month(sale_date)=11 and year(sale_date)=2022; 
```

**  3. write a query to calcutae Total sales for each category **:
```sql
select sum(Total_sale) , category ,count(*) from retail_sales
group by category ; 
```

**  4.write a query to find the average age of the customers who purchased items from the beauty category. **:
```sql
select round(avg(age),2) from retail_sales
where category="beauty" ; 
```

**  5.write a sql query to find all transaction where the total_sales is greater than 1000**:
```sql
select count( transactions_id) from retail_sales
where total_sale > 1000 ; 
```

**  6.write the sql query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select  category,age,count(transactions_id) from retail_sales
group by age,category; 
```

**   7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year **:
```sql
select  month(sale_date) as months,year(sale_date) years,avg(total_sale) as average from retail_sales
group by month(sale_date),year(sale_date) 
order by average DESC
limit 1;  
```

**  8.Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id, sum(total_sale) as total_sales from Retail_sales
group by customer_id
order by total_sales desc; 
```

**  9. Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select count(distinct customer_id) as unique_customer, category
from retail_sales 
group by category; 
```

**  10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17) **:
```sql
select 
case 
	when extract(hour from sale_time) < 12 then 'morning'
    when extract(hour from sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift , COUNT(*) as total_orders  
from retail_sales
group by shift ;
```

# key Findigs
~ **The dataset offers valuable insights into customer buying behavior and peak sales periods.**
~ **Certain product categories have stronger performance in specific months and times of day.**
~ **Targeting top customers and focusing on high-performing categories can drive better marketing strategies.**

# Conclusion
This project is a complete beginner-friendly guide to SQL for data analysis. It includes setting up a database, cleaning the data, exploring it, and running SQL queries to answer business questions. The insights gained from this project can help understand sales trends, customer behavior, and how different products are performing

