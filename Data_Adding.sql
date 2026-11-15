
--                                                          DATA ADDING

CREATE DATABASE Ecommerce_Sales_Analysis;

USE Ecommerce_Sales_Analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Arun', 'Chennai', '2026-01-05'),
(2, 'Priya', 'Bengaluru', '2026-01-10'),
(3, 'Kumar', 'Chennai', '2026-02-01'),
(4, 'Divya', 'Coimbatore', '2026-02-15'),
(5, 'Rahul', 'Bengaluru', '2026-03-01'),
(6, 'Meena', 'Chennai', '2026-03-10'),
(7, 'Sanjay', 'Coimbatore', '2026-04-01'),
(8, 'Kavya', 'Bengaluru', '2026-04-12');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Smartphone', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Office Chair', 'Furniture', 8000),
(105, 'Keyboard', 'Accessories', 1500),
(106, 'Monitor', 'Electronics', 12000),
(107, 'Desk', 'Furniture', 10000),
(108, 'Mouse', 'Accessories', 800);

INSERT INTO orders VALUES
(1001, 1, '2026-05-01', 'Delivered'),
(1002, 2, '2026-05-02', 'Delivered'),
(1003, 3, '2026-05-03', 'Delivered'),
(1004, 4, '2026-05-04', 'Cancelled'),
(1005, 5, '2026-05-05', 'Delivered'),
(1006, 1, '2026-05-06', 'Delivered'),
(1007, 6, '2026-05-07', 'Pending'),
(1008, 7, '2026-05-08', 'Delivered'),
(1009, 8, '2026-05-09', 'Delivered'),
(1010, 2, '2026-05-10', 'Cancelled'),
(1011, 3, '2026-05-11', 'Delivered'),
(1012, 5, '2026-05-12', 'Delivered');

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 103, 2, 2000),
(3, 1002, 102, 1, 25000),
(4, 1002, 105, 2, 1500),
(5, 1003, 104, 1, 8000),
(6, 1003, 108, 2, 800),
(7, 1004, 107, 1, 10000),
(8, 1005, 106, 2, 12000),
(9, 1005, 105, 1, 1500),
(10, 1006, 102, 1, 25000),
(11, 1006, 103, 1, 2000),
(12, 1007, 101, 1, 55000),
(13, 1008, 107, 1, 10000),
(14, 1008, 108, 3, 800),
(15, 1009, 104, 1, 8000),
(16, 1009, 105, 2, 1500),
(17, 1010, 102, 1, 25000),
(18, 1011, 103, 3, 2000),
(19, 1011, 108, 2, 800),
(20, 1012, 106, 1, 12000);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;