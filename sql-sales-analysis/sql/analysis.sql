-- =====================================================
-- SALES DATA ANALYSIS PROJECT
-- Dataset: Superstore
-- =====================================================


-- 1. Check total number of rows
SELECT COUNT(*) AS total_rows
FROM sales;


-- 2. View sample data
SELECT *
FROM sales
LIMIT 10;


-- =====================================================
-- BASIC BUSINESS METRICS
-- =====================================================

-- 3. Total sales
SELECT
SUM(sales) AS total_sales
FROM sales;


-- 4. Total profit
SELECT
SUM(profit) AS total_profit
FROM sales;


-- =====================================================
-- CATEGORY ANALYSIS
-- =====================================================

-- 5. Sales by category
SELECT
category,
SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- 6. Profit margin by category
SELECT
category,
SUM(profit) / SUM(sales) * 100 AS profit_margin_percent
FROM sales
GROUP BY category
ORDER BY profit_margin_percent DESC;


-- =====================================================
-- GEOGRAPHICAL ANALYSIS
-- =====================================================

-- 7. Top 10 cities by sales
SELECT
city,
SUM(sales) AS total_sales
FROM sales
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;


-- 8. Sales by region
SELECT
region,
SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;


-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

-- 9. Top 10 products by sales
SELECT
product_name,
SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- 10. Products generating losses
SELECT
product_name,
SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;


-- =====================================================
-- TIME ANALYSIS
-- =====================================================

-- 11. Monthly sales trend
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(sales) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;


-- =====================================================
-- ADVANCED SQL
-- =====================================================

-- 12. Top 3 products in each category

WITH ranked_products AS (
SELECT
category,
product_name,
SUM(sales) AS total_sales,
ROW_NUMBER() OVER (
PARTITION BY category
ORDER BY SUM(sales) DESC
) AS sales_rank
FROM sales
GROUP BY category, product_name
)

SELECT *
FROM ranked_products
WHERE sales_rank <= 3;


-- =====================================================
-- KPI ANALYSIS
-- =====================================================

-- 13. Sales by year
SELECT
EXTRACT(YEAR FROM order_date) AS year,
SUM(sales) AS total_sales
FROM sales
GROUP BY year
ORDER BY year;


-- 14. Year-over-Year sales growth

WITH yearly_sales AS (
SELECT
EXTRACT(YEAR FROM order_date) AS year,
SUM(sales) AS total_sales
FROM sales
GROUP BY year
)

SELECT
year,
total_sales,
LAG(total_sales) OVER (ORDER BY year) AS previous_year_sales,
(total_sales - LAG(total_sales) OVER (ORDER BY year)) AS sales_growth
FROM yearly_sales
ORDER BY year;