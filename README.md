Retail Sales Analysis using PostgreSQL
📌 Project Overview

This project performs end-to-end analysis of a retail company’s transactional sales data using PostgreSQL.
The dataset contains monthly order records including product purchased, quantity, price, order date, and purchase address.

The objective of this project is to simulate the work of a Business/Data Analyst by importing raw CSV files, cleaning messy data, transforming it into a structured format, and generating meaningful business insights.

🎯 Objectives

Import raw CSV sales data into PostgreSQL

Clean and transform inconsistent fields (especially date and numeric values)

Convert unstructured text data into analyzable formats

Create business KPIs such as Revenue and Order Volume

Analyze product performance, time trends, and customer purchasing behaviour

🧰 Tools & Technologies

PostgreSQL (pgAdmin 4)

SQL

CSV Dataset (Monthly retail sales transactions)

GitHub for version control and project documentation

🗄️ Database Structure

Database: Company_ZXY
Schema: sales
Table: sales_2026

Table Columns
Column	Description
orderid	Unique order identifier
product	Product name
quantity_ordered	Units purchased
price_each	Price per unit
order_date	Raw date from CSV (text format)
purchase_address	Customer purchase location
order_timestamp	Cleaned timestamp for analysis
total_sales	Calculated revenue per transaction
🧹 Data Cleaning & Transformation

The raw dataset contained inconsistent date formats and missing values.
The following transformations were performed:

Imported CSV data into a staging table

Converted order_date (text) into TIMESTAMP using TO_TIMESTAMP

Handled NULL values using COALESCE

Created a calculated revenue column:

total_sales = quantity_ordered * price_each

This step allowed accurate time-series and financial analysis.

📊 Key Analysis Performed
1. Product Performance

Top selling products by quantity

Highest revenue generating products

Least performing products

2. Time-Based Analysis

Orders per day

Monthly revenue trends

Peak purchasing hours

3. Location Analysis

Orders by city

Revenue by city

4. Category Analysis

Revenue contribution from specific products (e.g., iPhone)

5. Customer Behaviour

Multi-product orders

Cross-selling opportunities

🔍 Sample Queries
Monthly Revenue
SELECT DATE_TRUNC('month', order_timestamp) AS month,
SUM(total_sales) AS revenue
FROM sales.sales_2026
GROUP BY month
ORDER BY month;
Peak Order Hour
SELECT EXTRACT(HOUR FROM order_timestamp) AS hour,
COUNT(*) AS orders
FROM sales.sales_2026
GROUP BY hour
ORDER BY orders DESC;
Product Revenue Ranking
SELECT product,
SUM(total_sales) AS revenue,
RANK() OVER (ORDER BY SUM(total_sales) DESC) AS rank
FROM sales.sales_2026
GROUP BY product;
📈 Key Business Insights

Certain products generate significantly higher revenue than others

Sales peak during evening hours, indicating customer purchasing patterns

Some cities contribute a majority of total orders

High-value products drive a large portion of total revenue

Multiple products are frequently purchased in a single order, indicating cross-selling opportunities

💡 What I Learned

Through this project I learned:

Real-world data is messy and requires cleaning before analysis

Importance of datatype conversion and validation

SQL aggregation and filtering for business reporting

How analysts transform raw data into decision-making insights

🚀 Conclusion

This project demonstrates the complete workflow of a Data Analyst:
Data Import → Data Cleaning → Transformation → Analysis → Business Insights

It reflects practical skills used in retail, banking, and e-commerce analytics environments.

👨‍💻 Author

Abhishek Sharma
MBA (Finance) | Aspiring Data Analyst
Skills: SQL, Power BI, Financial Analysis
