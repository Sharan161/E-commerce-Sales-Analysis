# E-commerce Sales Analysis Using SQL

##  Project Overview

The **E-commerce Sales Analysis Using SQL** project focuses on analyzing e-commerce business data using MySQL. The main objective is to understand sales performance, customer behaviour, product performance, and order trends by writing SQL queries.

This project uses multiple related tables to perform data exploration, data cleaning, and business analysis.

##  Project Objectives

- Analyze overall sales performance.
- Identify top-performing products.
- Understand customer purchasing behaviour.
- Analyze sales by product category.
- Identify order status distribution.
- Find high-value customers.
- Analyze monthly sales trends.
- Generate business insights using SQL queries.

##  Tools & Technologies

- MySQL
- MySQL Workbench
- SQL

##  Database Structure

The project contains four main tables:

### 1. Customers
Stores customer information.

| Column | Description |
|---|---|
| customer_id | Unique customer ID |
| customer_name | Customer name |
| city | Customer city |
| signup_date | Customer registration date |

### 2. Products
Stores product information.

| Column | Description |
|---|---|
| product_id | Unique product ID |
| product_name | Product name |
| category | Product category |
| price | Product price |

### 3. Orders
Stores order information.

| Column | Description |
|---|---|
| order_id | Unique order ID |
| customer_id | Customer ID |
| order_date | Date of order |
| order_status | Current order status |

### 4. Order_Items
Stores details of products included in each order.

| Column | Description |
|---|---|
| order_item_id | Unique order item ID |
| order_id | Order ID |
| product_id | Product ID |
| quantity | Number of products |
| unit_price | Price per unit |

##  Project Workflow

### 1. Database Creation
- Created an e-commerce database.
- Created four relational tables.
- Defined primary and foreign keys.
- Inserted sample records into the tables.

### 2. Data Exploration
- Checked total records in each table.
- Reviewed table structures.
- Identified distinct product categories.
- Analyzed order statuses.
- Checked date ranges.

### 3. Data Cleaning
- Checked missing values.
- Identified duplicate records.
- Checked invalid prices and quantities.
- Verified foreign key relationships.
- Checked inconsistent values.

### 4. Data Analysis

Performed business analysis using SQL queries:

- Total revenue analysis.
- Total number of orders.
- Total products sold.
- Sales by product category.
- Top-selling products.
- Customer-wise purchase analysis.
- High-value customer identification.
- Order status analysis.
- Monthly sales analysis.

### 5. Advanced SQL Analysis

Applied advanced SQL concepts:

- JOIN operations.
- Subqueries.
- Common Table Expressions (CTEs).
- Aggregate functions.
- CASE statements.
- Window functions.
- RANK() and DENSE_RANK().
- GROUP BY and HAVING.
- Date functions.

##  Key SQL Concepts Used

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- DISTINCT
- LIMIT
- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- INNER JOIN
- LEFT JOIN
- Subqueries
- CTEs
- Window Functions

##  Business Insights

The analysis is designed to help understand:

- Which products generate the highest sales.
- Which categories perform best.
- Which customers contribute more to revenue.
- How sales change over time.
- How orders are distributed across different statuses.
- Which products have stronger sales performance.

*Note: Add specific numerical findings here after completing your SQL analysis.*

##  Project Structure

```text
E-commerce-Sales-Analysis-SQL/
│
├── 01_create_tables.sql
├── 02_insert_data.sql
├── 03_data_exploration.sql
├── 04_data_cleaning.sql
├── 05_sales_analysis.sql
├── 06_advanced_analysis.sql
│
└── README.md
```

##  How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench.
3. Create a new SQL query tab.
4. Run `01_create_tables.sql`.
5. Run `02_insert_data.sql`.
6. Execute the data exploration and cleaning scripts.
7. Run the sales analysis queries.
8. Review the results and business insights.

##  Skills Demonstrated

- SQL Query Writing
- Database Management
- Data Exploration
- Data Cleaning
- Data Analysis
- Relational Database Concepts
- Joins and Subqueries
- CTEs and Window Functions
- Business Problem Solving

##  Author

**Sharan S**

Aspiring Data Analyst

GitHub: https://github.com/sharan161
