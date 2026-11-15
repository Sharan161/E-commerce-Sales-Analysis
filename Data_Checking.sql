 
 --                                                       DATA CHECK

USE Ecommerce_Sales_Analysis;


-- Q1. Display all customer records.
SELECT * FROM customers;

-- Q2. Display all product records.
SELECT * FROM products;

-- Q3. Display all order records.
SELECT * FROM orders;

-- Q4. Display all order item records.
SELECT * FROM order_items;

-- Q5. Count the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- Q6. Count the total number of products.
SELECT COUNT(*) AS total_products FROM products;

-- Q7. Count the total number of orders.
SELECT COUNT(*) AS total_orders FROM orders;

-- Q8. Count the total number of order items.
SELECT COUNT(*) AS total_order_items FROM order_items;

-- Q9. Check the structure of the customers table.
DESCRIBE customers;

-- Q10. Check the structure of the products table.
DESCRIBE products;

-- Q11. Check the structure of the orders table.
DESCRIBE orders;

-- Q12. Check the structure of the order_items table.
DESCRIBE order_items;

-- Q13. Find missing customer information.
SELECT * FROM customers
WHERE customer_name IS NULL
OR city IS NULL
OR signup_date IS NULL;

-- Q14. Find missing product information.
SELECT * FROM products
WHERE product_name IS NULL
OR category IS NULL
OR price IS NULL;

-- Q15. Find missing order information.
SELECT * FROM orders
WHERE customer_id IS NULL
OR order_date IS NULL
OR order_status IS NULL;

-- Q16. Find missing order item information.
SELECT * FROM order_items
WHERE order_id IS NULL
OR product_id IS NULL
OR quantity IS NULL
OR unit_price IS NULL;


-- Q17. Check for duplicate customer IDs.
SELECT customer_id, COUNT(*) AS occurrences FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Q18. Check for duplicate product IDs.
SELECT product_id, COUNT(*) AS occurrences FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Q19. Check for duplicate order IDs.
SELECT order_id, COUNT(*) AS occurrences FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Q20. Check for duplicate order item IDs.
SELECT order_item_id, COUNT(*) AS occurrences FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

-- Q21. Find invalid or non-positive product prices.
SELECT * FROM products
WHERE price <= 0;

-- Q22. Find invalid quantities.
SELECT * FROM order_items
WHERE quantity <= 0;

-- Q23. Find invalid or non-positive order item prices.
SELECT * FROM order_items
WHERE unit_price <= 0;

-- Q24. Check the available product categories.
SELECT DISTINCT category FROM products;

-- Q25. Check the available order statuses.
SELECT DISTINCT order_status FROM orders;

-- Q26. Count orders by status.
SELECT order_status, COUNT(*) AS total_orders FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q27. Check whether orders reference missing customers.
SELECT o.* FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Q28. Check whether order items reference missing orders.
SELECT oi.* FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Q29. Check whether order items reference missing products.
SELECT oi.* FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Q30. Check the minimum and maximum product prices.
SELECT MIN(price) AS minimum_price, MAX(price) AS maximum_price, ROUND(AVG(price), 2) AS average_price
FROM products;

-- Q31. Check the earliest and latest order dates.
SELECT MIN(order_date) AS earliest_order_date, MAX(order_date) AS latest_order_date
FROM orders;

-- Q32. Check the earliest and latest customer signup dates.
SELECT MIN(signup_date) AS earliest_signup_date, MAX(signup_date) AS latest_signup_date
FROM customers;

-- Q33. Check for blank customer names or cities.
SELECT * FROM customers
WHERE TRIM(customer_name) = ''
   OR TRIM(city) = '';

-- Q34. Check for blank product names or categories.
SELECT * FROM products
WHERE TRIM(product_name) = '' OR TRIM(category) = '';

-- Q35. Check for unexpected order statuses.
SELECT * FROM orders
WHERE order_status NOT IN ( 'Delivered', 'Cancelled', 'Pending' );

-- Q36. Calculate the number of units recorded in order items.
SELECT SUM(quantity) AS total_units FROM order_items;

-- Q37. Check the total number of records in each table.
SELECT 'customers' AS table_name, COUNT(*) AS total_records
FROM customers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)
FROM order_items;
