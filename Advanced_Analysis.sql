
--                                                       ADVANCED ANALYSIS

USE Ecommerce_Sales_Analysis;


-- Q1. Find customers who have placed more than one order.
SELECT c.customer_id, c.customer_name,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;

-- Q2. Find customers whose delivered-order revenue
-- is greater than the average customer revenue.
-- Customers without delivered orders are excluded.
WITH customer_revenue AS (
SELECT c.customer_id, c.customer_name,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name )
SELECT * FROM customer_revenue
WHERE revenue > (
    SELECT AVG(revenue) FROM customer_revenue
)
ORDER BY revenue DESC;

-- Q3. Find the second-highest distinct product revenue.
-- Revenue includes delivered orders only.
WITH product_revenue AS (
SELECT p.product_id, p.product_name,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
)
SELECT DISTINCT revenue AS second_highest_revenue
FROM product_revenue
ORDER BY revenue DESC
LIMIT 1 OFFSET 1;

-- Q4. Rank products by revenue using DENSE_RANK().
WITH product_revenue AS (
SELECT p.product_id, p.product_name,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
)
SELECT product_name, revenue,
DENSE_RANK() OVER ( ORDER BY revenue DESC ) AS revenue_rank
FROM product_revenue;

-- Q5. Find the highest-revenue product in each category.
WITH product_revenue AS (
SELECT p.product_id, p.product_name,
p.category, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
),
ranked_products AS (
SELECT *,
DENSE_RANK() OVER ( PARTITION BY category ORDER BY revenue DESC
) AS category_rank
FROM product_revenue
)
SELECT * FROM ranked_products
WHERE category_rank = 1;

-- Q6. Find the top two customers by revenue.
WITH customer_revenue AS (
SELECT c.customer_id, c.customer_name,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
),
ranked_customers AS (
SELECT *, 
DENSE_RANK() OVER ( ORDER BY revenue DESC ) AS revenue_rank
FROM customer_revenue
)
SELECT * FROM ranked_customers
WHERE revenue_rank <= 2;

-- Q7. Calculate running monthly revenue.
WITH monthly_revenue AS (
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT sales_month, revenue,
SUM(revenue) OVER ( ORDER BY sales_month ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW ) AS running_revenue
FROM monthly_revenue
ORDER BY sales_month;

-- Q8. Compare monthly revenue with the previous month.
WITH monthly_revenue AS (
SELECT
DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
monthly_comparison AS (
SELECT sales_month, revenue,
LAG(revenue) OVER ( ORDER BY sales_month ) AS previous_month_revenue
FROM monthly_revenue
)
SELECT sales_month, revenue, previous_month_revenue,
revenue - previous_month_revenue AS revenue_change,
ROUND( 100.0 * (revenue - previous_month_revenue)
/ NULLIF(previous_month_revenue, 0), 2 ) AS growth_percent
FROM monthly_comparison
ORDER BY sales_month;

-- Q9. Find orders with a total value above
-- the average delivered-order value.
WITH order_totals AS (
SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered'
GROUP BY o.order_id
)
SELECT * FROM order_totals
WHERE order_value > ( SELECT AVG(order_value) FROM order_totals )
ORDER BY order_value DESC;

-- Q10. Calculate the percentage contribution
-- of each product category to total revenue.
WITH category_revenue AS (
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
)
SELECT category, revenue,
ROUND( 100.0 * revenue / SUM(revenue) OVER (), 2 ) AS revenue_percentage
FROM category_revenue
ORDER BY revenue DESC;

-- Q11. Calculate the repeat customer rate.
-- Definition: customers with at least two orders
-- divided by all customers who placed at least one order.
-- Includes all order statuses.
WITH customer_order_counts AS (
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
)
SELECT COUNT(*) AS customers_with_orders,
SUM(CASE
	WHEN total_orders >= 2 THEN 1
	ELSE 0
    END) AS repeat_customers,
ROUND( 100.0 * SUM(CASE
	WHEN total_orders >= 2 THEN 1
	ELSE 0
	END) / COUNT(*), 2 ) AS repeat_customer_rate_percent
FROM customer_order_counts;

-- Q12. Compare each product's revenue with
-- the average product revenue.
WITH product_revenue AS (
SELECT p.product_id, p.product_name,
COALESCE( SUM( CASE
				WHEN o.order_status = 'Delivered' THEN oi.quantity * oi.unit_price
				ELSE 0
                END ), 0 ) AS revenue
    FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name
)
SELECT product_name, revenue,
ROUND(AVG(revenue) OVER (), 2) AS average_product_revenue,
ROUND( revenue - AVG(revenue) OVER (), 2 ) AS difference_from_average
FROM product_revenue
ORDER BY revenue DESC;

-- Q13. Create a summary of key business KPIs.
SELECT COUNT(DISTINCT o.order_id) AS total_orders,
COUNT(DISTINCT CASE
	WHEN o.order_status = 'Delivered' THEN o.order_id
    END) AS delivered_orders,
COUNT(DISTINCT CASE
	WHEN o.order_status = 'Cancelled' THEN o.order_id
    END) AS cancelled_orders,
ROUND( SUM(CASE
            WHEN o.order_status = 'Delivered' THEN oi.quantity * oi.unit_price
            ELSE 0
        END), 2 ) AS delivered_revenue,
ROUND( 100.0 * COUNT(DISTINCT CASE
		WHEN o.order_status = 'Cancelled'
		THEN o.order_id
        END) / NULLIF(COUNT(DISTINCT o.order_id), 0), 2 ) AS cancellation_rate_percent
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id;

