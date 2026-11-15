
--                                                     DATA CLEANING


USE Ecommerce_Sales_Analysis;

-- Q1. Find missing customer details.
SELECT * FROM customers
WHERE customer_name IS NULL
OR city IS NULL
OR signup_date IS NULL;

-- Q2. Remove unwanted spaces from customer names and cities.
UPDATE customers
SET customer_name = TRIM(customer_name), city = TRIM(city);

-- Q3. Find missing product details.
SELECT * FROM products
WHERE product_name IS NULL
OR category IS NULL
OR price IS NULL;

-- Q4. Remove unwanted spaces from product names and categories.
UPDATE products
SET product_name = TRIM(product_name), category = TRIM(category);

-- Q5. Standardize product category capitalization.
UPDATE products
SET category = CASE
	WHEN UPPER(TRIM(category)) = 'ELECTRONICS' THEN 'Electronics'
    WHEN UPPER(TRIM(category)) = 'ACCESSORIES' THEN 'Accessories'
    WHEN UPPER(TRIM(category)) = 'FURNITURE' THEN 'Furniture'
    ELSE TRIM(category)
END;

-- Q6. Find missing order information.
SELECT * FROM orders
WHERE customer_id IS NULL
OR order_date IS NULL
OR order_status IS NULL;

-- Q7. Standardize order status capitalization and spaces.
UPDATE orders
SET order_status = CASE
    WHEN UPPER(TRIM(order_status)) = 'DELIVERED' THEN 'Delivered'
    WHEN UPPER(TRIM(order_status)) = 'CANCELLED' THEN 'Cancelled'
    WHEN UPPER(TRIM(order_status)) = 'PENDING' THEN 'Pending'
    ELSE TRIM(order_status)
END;

-- Q8. Find invalid product prices.
SELECT * FROM products
WHERE price <= 0;

-- Q9. Find invalid order item quantities.
SELECT * FROM order_items
WHERE quantity <= 0;

-- Q10. Find invalid order item prices.
SELECT * FROM order_items
WHERE unit_price <= 0;

-- Q11. Check whether item prices differ from product prices.
-- Differences may be valid if discounts or price changes occurred.
SELECT oi.order_item_id, p.product_name,
p.price AS current_product_price, oi.unit_price AS recorded_order_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE oi.unit_price <> p.price;

-- Q12. Verify that every order belongs to an existing customer.
SELECT o.* FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Q13. Verify that every order item references an existing order.
SELECT oi.* FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Q14. Verify that every order item references an existing product.
SELECT oi.* FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Q15. Review all records after cleaning.
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


