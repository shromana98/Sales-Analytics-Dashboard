CREATE DATABASE STORE;
USE STORE;
-- Overall view of superstore sales dataset --
SELECT * FROM superstoreordersdataset;
ALTER TABLE superstoreordersdataset
CHANGE COLUMN ï»¿order_id order_id VARCHAR(20) NULL;
SELECT
COUNT(order_id) AS Total_oreders,
COUNT(DISTINCT country) AS Total_countries,
COUNT(DISTINCT product_name) AS Total_products,
COUNT(DISTINCT category) AS Total_categories,
COUNT(DISTINCT sub_category) AS Total_subcategories,
COUNT(DISTINCT year) AS Total_years,
SUM(sales) AS Total_sales,
SUM(quantity) AS Total_quantity_sold,
AVG(profit) AS Avg_profit,
AVG(discount) AS Total_discount
FROM superstoreordersdataset;

-- sales performance analysis --
SELECT 
product_name,
category,
SUM(sales) AS Toatl_sales,
SUM(quantity) AS Total_quantity_sold
FROM superstoreordersdataset
GROUP BY
product_name,
category
ORDER BY 
SUM(sales) DESC
LIMIT 10;

-- Sales over year

SELECT 
year,
SUM(sales) AS Total_sales
FROM superstoreordersdataset
GROUP BY year
ORDER BY SUM(sales) DESC;

-- What are total sales and total profits?
SELECT
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstoreordersdataset;




-- Customer segmentation

SELECT
segment,
COUNT(DISTINCT customer_name) AS Toatl_customers,
SUM(sales) AS Total_sales
FROM superstoreordersdataset
GROUP BY segment
ORDER BY SUM(sales) DESC;

-- What segment makes the most of our profits and sales ?
SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY segment
ORDER BY total_profit DESC;

-- How many customers do we have (unique customer IDs) in total and how much per region and state?
SELECT COUNT(DISTINCT customer_name) AS total_customers
FROM superstoreordersdataset;
SELECT region, COUNT(DISTINCT customer_name) AS total_customers
FROM superstoreordersdataset
GROUP BY region
ORDER BY total_customers DESC;
-- Customer rewards program

--  What customers spent the most with us? That is generated the most sales.
SELECT customer_name, 
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY customer_name
ORDER BY total_sales desc
LIMIT 15;
-- Shipping and order management 

SELECT
ship_mode,
AVG(shipping_cost) AS Avg_shipping_cost,
AVG(profit) AS Avg_profit
FROM superstoreordersdataset
GROUP BY ship_mode
ORDER BY AVG(profit);

-- Time Series
SELECT
  ship_mode,
  AVG(DATEDIFF(STR_TO_DATE(ship_date, '%Y-%m-%d'), STR_TO_DATE(order_date, '%Y-%m-%d'))) AS Avg_time_gap
FROM superstoreordersdataset
WHERE STR_TO_DATE(ship_date, '%Y-%m-%d') >= STR_TO_DATE(order_date, '%Y-%m-%d') -- Filter out negative time gaps
GROUP BY ship_mode;



-- Profibility and cost analysis

SELECT
product_name,
category,
sub_category,
AVG(profit) AS Avg_profit,
AVG(discount) AS Avg_discount
FROM superstoreordersdataset
GROUP BY 
product_name,
category,
sub_category
ORDER BY AVG(profit) DESC;

-- The relationship between discount and sales and the total discount per category


SELECT discount, AVG(Sales) AS Avg_Sales
FROM superstoreordersdataset
GROUP BY discount
ORDER BY discount;

-- Total discount per product category:

SELECT category, SUM(discount) AS total_discount
FROM superstoreordersdataset
GROUP BY category
ORDER BY total_discount DESC;
SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstoreordersdataset
GROUP BY category
ORDER BY total_profit DESC;
SELECT region, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY region, category
ORDER BY total_profit DESC;
-- highest total sales and total profits per Category in each state:

SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY state, category
ORDER BY total_profit DESC;
-- What subcategory generates the highest sales and profits in each region and state ?
SELECT sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstoreordersdataset
GROUP BY sub_category
ORDER BY total_profit DESC;
-- What are the names of the products that are the most and least profitable
SELECT product_name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY product_name
ORDER BY total_profit DESC;
-- Less proftable ones:

SELECT product_name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstoreordersdataset
GROUP BY product_name
ORDER BY total_profit ASC;
-- Global sales and quantity product overview --
SELECT
country,
SUM(sales) AS Total_sales,
SUM(quantity)  AS Total_quantity
FROM superstoreordersdataset
GROUP BY country
ORDER BY SUM(sales) DESC;


-- State level category exploration --
SELECT 
product_name,
category,
SUM(quantity) AS Total_quantity_sold
FROM superstoreordersdataset
GROUP BY 
product_name,
category
ORDER BY SUM(quantity) DESC;

-- What state and city brings in the highest sales and profits ?

SELECT State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM superstoreordersdataset
GROUP BY State
ORDER BY Total_Profits DESC
LIMIT 10;
SELECT State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits
FROM superstoreordersdataset
GROUP BY State
ORDER BY Total_Profits ASC
LIMIT 10;
-- Regional subcategory analysis --
SELECT
region,
sub_category,
SUM(quantity) AS Total_quantity_sold
FROM superstoreordersdataset
GROUP BY region,
sub_category
ORDER BY SUM(quantity) DESC;
-- What region generates the highest sales and profits ?

SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profits
FROM superstoreordersdataset
GROUP BY region
ORDER BY total_profits DESC;
-- What state and city brings in the highest sales and profits ?
SELECT State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM superstoreordersdataset
GROUP BY State
ORDER BY Total_Profits DESC
LIMIT 10;
-- Bottom 10
SELECT State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits
FROM superstoreordersdataset
GROUP BY State
ORDER BY Total_Profits ASC
LIMIT 10;

-- What region generates the highest sales and profits ?
SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profits
FROM superstoreordersdataset
GROUP BY region
ORDER BY total_profits DESC;

SELECT region, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM superstoreordersdataset
GROUP BY region
ORDER BY profit_margin DESC;
SELECT *
FROM superstoreordersdataset
LIMIT 5;
-- Q1) What percentage of total orders were shipped on the same date?


SELECT
    ROUND((COUNT(DISTINCT Order_ID) / (SELECT COUNT(DISTINCT Order_ID) AS total_orders FROM superstoreordersdataset)) * 100, 2) AS Same_Day_Shipping_Percentage
FROM
    superstoreordersdataset
WHERE
    Order_Date = Ship_Date;

-- Q2) Name top 3 customers with highest total value of orders?


SELECT
    Customer_Name,
    ROUND(SUM(sales), 3) AS TotalOrderValue
FROM
    superstoreordersdataset
GROUP BY
    Customer_Name
ORDER BY
    SUM(sales) DESC
LIMIT 3;

-- Q3) Find the top 5 items with the highest average sales per day?

SELECT
    Product_ID,
    ROUND(AVG(sales), 3) AS Average_Sales
FROM
    superstoreordersdataset
GROUP BY
    Product_ID
ORDER BY
    Average_Sales DESC
LIMIT 5;
-- Q4) Write a query to find the average order value for each customer, and rank the customers by their average order value? 


 SELECT
    Customer_Name,
    ROUND(AVG(sales), 3) AS avg_order_value,
    DENSE_RANK() OVER (ORDER BY AVG(sales) DESC) AS sales_rank
FROM
    superstoreordersdataset
GROUP BY
    Customer_Name;

-- Q6) What is the most demanded sub-category in the west region?


SELECT
    Sub_Category,
    ROUND(SUM(sales), 3) AS total_quantity
FROM
    superstoreordersdataset
WHERE
    Region = 'Central'
GROUP BY
    Sub_Category
ORDER BY
    total_quantity DESC
LIMIT 1;


-- Q7) Which order has the highest number of items? 


SELECT
    order_id,
    COUNT(order_id) AS num_item
FROM
    superstoreordersdataset
GROUP BY
    order_id
ORDER BY
    num_item DESC
LIMIT 1;


-- Q8) Which order has the highest cumulative value?


SELECT
    order_id,
    ROUND(SUM(sales), 3) AS order_value
FROM
    superstoreordersdataset
GROUP BY
    order_id
ORDER BY
    order_value DESC
LIMIT 1;


-- Q9) Which segment’s order is more likely to be shipped via first class?


SELECT
    segment,
    COUNT(order_id) AS num_of_ordr
FROM
    superstoreordersdataset
WHERE
    ship_mode = 'First Class'
GROUP BY
    segment
ORDER BY
    num_of_ordr DESC;






/* Q12) Which segment places the highest number of orders from each state 
		and which segment places the largest individual orders from each state? */

        
WITH cte AS (
    SELECT
        state,
        segment,
        COUNT(order_id) AS num_orders,
        RANK() OVER (PARTITION BY state ORDER BY COUNT(order_id) DESC) AS state_rank
    FROM
        superstoreordersdataset
    GROUP BY
        state,
        segment
)
SELECT
    state,
    segment
FROM
    cte
WHERE
    state_rank = 1;




-- Q14) Find the maximum number of days for which total sales on each day kept rising?


 WITH sales_sequence AS (
    SELECT
        Order_Date,
        SUM(Sales) AS TotalSales,
        ROW_NUMBER() OVER (ORDER BY Order_Date) AS rn
    FROM
        superstoreordersdataset
    GROUP BY
        Order_Date
),
rising_days AS (
    SELECT
        s1.Order_Date,
        COUNT(*) AS rising_day_count
    FROM
        sales_sequence s1
    INNER JOIN
        sales_sequence s2 ON s1.TotalSales < s2.TotalSales AND s1.rn < s2.rn
    GROUP BY
        s1.Order_Date
)
SELECT
    MAX(rising_day_count) AS max_rising_days
FROM
    rising_days;