ALTER TABLE sales MODIFY order_date DATE;

SELECT order_id, customer_name, order_date, total_price
FROM sales
LIMIT 10;
-- Total number of orders
SELECT COUNT(*) AS total_orders
FROM sales;
-- Total revenue
SELECT SUM(total_price) AS total_revenue
FROM sales;
-- Average order value
SELECT AVG(total_price) AS avg_order_value
FROM sales;
-- Summary of all orders
SELECT COUNT(*) AS total_orders,
       SUM(total_price) AS total_revenue,
       AVG(total_price) AS avg_order_value,
       MAX(total_price) AS biggest_order,
       MIN(total_price) AS smallest_order
FROM sales;
-- Revenue for each category
SELECT category, SUM(total_price) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;
-- Top 10 customers by total spending
SELECT customer_name, SUM(total_price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;
-- Customers with the most orders
SELECT customer_name, COUNT(*) AS total_orders, SUM(total_price) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_orders DESC
LIMIT 10;
-- How many unique customers are there?
SELECT COUNT(DISTINCT customer_name) AS unique_customers
FROM sales;
-- Average order value per region
SELECT region, ROUND(AVG(total_price), 2) AS avg_order_value
FROM sales
GROUP BY region
ORDER BY avg_order_value DESC;
-- Orders bigger than the average order value
SELECT order_id, customer_name, total_price
FROM sales
WHERE total_price > (SELECT AVG(total_price) FROM sales)
ORDER BY total_price DESC;
-- Count of above-average orders
SELECT COUNT(*) AS above_avg_orders
FROM sales
WHERE total_price > (SELECT AVG(total_price) FROM sales);
-- Label each order as High, Medium or Low
SELECT order_id, customer_name, total_price,
  CASE
    WHEN total_price >= 20000 THEN 'High'
    WHEN total_price >= 8000 THEN 'Medium'
    ELSE 'Low'
  END AS order_size
FROM sales;
-- Number of orders in each size group
SELECT
  CASE
    WHEN total_price >= 20000 THEN 'High'
    WHEN total_price >= 8000 THEN 'Medium'
    ELSE 'Low'
  END AS order_size,
  COUNT(*) AS num_orders,
  SUM(total_price) AS revenue
FROM sales
GROUP BY order_size
ORDER BY revenue DESC;
-- Create a small table of regions and managers
CREATE TABLE regions (
  region VARCHAR(20),
  manager VARCHAR(50)
);

INSERT INTO regions VALUES
  ('East', 'Ravi'),
  ('West', 'Anita'),
  ('North', 'Kiran'),
  ('South', 'Meena');
  SELECT * FROM regions;
  -- Revenue for each region manager
SELECT r.manager, r.region, SUM(s.total_price) AS revenue
FROM sales s
JOIN regions r ON s.region = r.region
GROUP BY r.manager, r.region
ORDER BY revenue DESC;
-- Orders and average order value per manager
SELECT r.manager, COUNT(*) AS orders, ROUND(AVG(s.total_price), 2) AS avg_order_value
FROM sales s
JOIN regions r ON s.region = r.region
GROUP BY r.manager;