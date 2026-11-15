
--                                                          DATA ANALYSIS

USE Ecommerce_Sales_Analysis;


-- Q1. Display all customers.
SELECT * FROM customers;

-- Q2. Find the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- Q3. Find the total number of products.
SELECT COUNT(*) AS total_products FROM products;

-- Q4. Find the total number of orders.
SELECT COUNT(*) AS total_orders FROM orders;

-- Q5. Count orders by status.
SELECT order_status, COUNT(*) AS total_orders FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q6. Calculate total revenue from delivered orders.
SELECT ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- Q7. Calculate revenue for each delivered order.
SELECT o.order_id, o.order_date,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS order_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id, o.order_date
ORDER BY order_revenue DESC;

-- Q8. Find the average value of a delivered order.
WITH order_totals AS (
SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id )
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM order_totals;

-- Q9. Find total revenue by product.
SELECT p.product_name,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS product_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC;

-- Q10. Find the best-selling products by units sold.
SELECT p.product_name, SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;

-- Q11. Calculate revenue by product category.
SELECT p.category, 
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Q12. Find the top five customers by delivered-order revenue.
SELECT c.customer_id, c.customer_name,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS customer_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY customer_revenue DESC
LIMIT 5;

-- Q13. Find the number of delivered orders per customer.
SELECT c.customer_name,
COUNT(DISTINCT o.order_id) AS delivered_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY delivered_orders DESC;

-- Q14. Find revenue by city.
SELECT c.city, 
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY city_revenue DESC;

-- Q15. Calculate monthly revenue.
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- Q16. Calculate the cancellation rate as a percentage.
SELECT COUNT(CASE
WHEN order_status = 'Cancelled' THEN 1
END) AS cancelled_orders,
COUNT(*) AS total_orders,
ROUND( 100.0 * COUNT(CASE
WHEN order_status = 'Cancelled' THEN 1
END) / COUNT(*), 2 ) AS cancellation_rate_percent
FROM orders;

-- Q17. Find products that have never been ordered.
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Q18. Find the highest-value delivered order.
SELECT o.order_id,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS order_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id
ORDER BY order_revenue DESC
LIMIT 1;
