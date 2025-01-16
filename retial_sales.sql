-- SQL RETAIL SALES ANALYSIS --
CREATE DATABASE retail_analysis;
USE retail_analysis;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
    
);

SELECT * FROM retail_sales;

-- DATA CLEANING --
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
SET SQL_SAFE_UPDATES = 0;
    
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
   
-- DATA EXPLORATION --

-- HOW MANY SALES WE HAVE --
SELECT 
	COUNT(*) as total_sales 
FROM retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE --
SELECT 
	COUNT(DISTINCT customer_id) 
FROM retail_sales;

-- HOW MANY CATEGORIES ARE THERE --
SELECT DISTINCT category 
FROM retail_sales;
    
-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS

-- Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date=' 2022-11-05';


-- Q2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_sales
WHERE category='Clothing' AND quantity>=4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30' -- You can also write it as TO_CHAR(sale_date, 'YYYY-MM')='2022-11' --
ORDER BY sale_date ASC;

-- Q3: Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category, 
	SUM(total_sale) as net_sales,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1; 

-- Q4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:   

SELECT category,
	ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='Beauty';

-- Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * FROM retail_sales
WHERE total_sale>1000;

-- Q6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.: 

SELECT category,gender, 
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,gender
ORDER BY category;
-- Q7: Write a SQL query to calculate the average sale for each month, and find the max sale from each year.

SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	ROUND(AVG(total_sale),2) as total_sale
FROM retail_sales
GROUP BY year,month
ORDER BY year ASC, total_sale DESC;

-- Q8: Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
	SUM(total_sale) as net_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY net_sales DESC
LIMIT 5;

-- Q9: Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, 
       COUNT(DISTINCT customer_id) AS num_customers
FROM retail_sales
GROUP BY category;

-- Q10: Write a query to find total number of customers who purchased from either the 'Clothing' or 'Beauty' category and display their customer IDs along with the category they purchased from.

SELECT category,
	COUNT( DISTINCT customer_id) as total_customers
FROM retail_sales
WHERE category = 'Clothing'

UNION

SELECT category,
	COUNT( DISTINCT customer_id) as total_customers
FROM retail_sales
WHERE category = 'Beauty'





