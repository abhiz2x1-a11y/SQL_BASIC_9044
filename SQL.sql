--------------------------------------------------------------------------Creating Database
create database Company_ZXY;
create schema sales;
--------------------------------------------------------------------------Creating Table
create table Sales.Sales_2026(
OrderId varchar(20) PRIMARY KEY,
Product Varchar(1000),
Quantity_Ordered Integer,
Price_Each numeric(10,2),
order_date text,
Purchase_address varchar(1000)
)
----------------------------------------------------------Upload data form jan to dec
COPY sales.sales_2026(OrderID, product, Quantity_ordered, Price_Each, Order_date, Purchase_address)
From 'D:\GITHUB\SQL\Monthly Sales\Sales_January_2026.csv'
Delimiter','
CSV HEADER
COPY sales.sales_2026(OrderID, product, Quantity_ordered, Price_Each, Order_date, Purchase_address)
From 'D:\GITHUB\SQL\Monthly Sales\Sales_December_2026.csv'
Delimiter','
CSV HEADER

select * from sales.sales_2026

--------------------------------The raw CSV stored the order date as text in US format. 
--------------------------------I used TO_TIMESTAMP to parse the string into a proper TIMESTAMP datatype

ALTER TABLE sales.sales_2026
ADD COLUMN order_timestamp TIMESTAMP;

UPDATE sales.sales_2026
SET order_timestamp =
TO_TIMESTAMP(order_date, 'MM/DD/YY HH24:MI');

-------------------------------------------------------------BASIC FILTER QUERY

SELECT * FROM sales.sales_2026

SELECT * FROM sales.sales_2026
Where Product = 'Google Phone';

SELECT * FROM Sales.sales_2026
Where Price_each > 900;

SELECT * FROM Sales.sales_2026
Where Price_each > 900
LIMIT 10;

SELECT * FROM Sales.sales_2026
Where NOT Product = 'Wired Headphones';

SELECT * FROM Sales.sales_2026
Where order_timestamp BETWEEN '2019-01-05' AND '2019-03-05';

SELECT *
FROM sales.sales_2026
WHERE product IN ('iPhone','Google Phone','Vivo Phone');

SELECT DISTINCT product from sales.sales_2026;

SELECT COUNT(DIStinct product)
From sales.sales_2026;

SELECT price_each, Product FROM sales.sales_2026
ORDER BY Price_each desc;

SELECT price_each, Product FROM sales.sales_2026
ORDER BY Price_each asc
Limit 10;

----------------------------------------------------MAX, MIN, SUM, AVG,

SELECT AVG(price_each) from sales.sales_2026;

SELECT MAX(Price_each) FROM Sales.Sales_2026;

SELECT MIN(Price_each) FROM Sales.sales_2026;

SELECT SUM(Price_each) FROM sales.sales_2026;

----------------------------------------------------GROUP BY

SELECT Product, SUM(Price_each) AS total_sales
FROM sales.sales_2026
GROUP BY Product;

SELECT Product, SUM(Price_each) AS total_sales
FROM sales.sales_2026
GROUP BY Product
ORDER BY total_sales DESC;

--list of Unit sold of each product
SELECT Product,SUM(Quantity_ordered) AS Unit_Sold
FROM sales.sales_2026
GROUP BY Product
ORDER BY Unit_sold DESC;

--revenue Calculation
SELECT product, SUM(quantity_ordered * price_each) as revenue
FROM sales.sales_2026
GROUP BY Product
ORDER BY revenue desc;

--ORDER PER DAY
SELECT DATE(order_timestamp) AS order_day,
COUNT(*) AS total_orders
FROM sales.sales_2026
GROUP BY order_day
ORDER BY order_day;

SELECT product,
SUM(quantity_ordered * price_each) AS revenue
FROM sales.sales_2026
WHERE product ILIKE '%iphone%'
GROUP BY product;

--------------------------------------------------------GROUP BY + HAVING

SELECT product, SUM(quantity_ordered) AS total_units
FROM sales.sales_2026
GROUP BY product
HAVING SUM(quantity_ordered) > 5000
order BY total_units desc;

---revenue from each product which is greater than 100000
SELECT product,
SUM(quantity_ordered * Price_each) AS Revenue
FROM sales.sales_2026
GROUP BY Product
HAVING SUM(quantity_ordered * Price_each) > 100000
ORDER BY revenue desc;

--Units SOLD only one product
SELECT product,
SUM(quantity_ordered) AS units
FROM sales.sales_2026
WHERE product ILIKE '%iphone%'
GROUP BY product
HAVING SUM(quantity_ordered) > 100;

------------------------------------------------------------INSERT DATA, UPDATE DATA, DELETE DATA

INSERT INTO sales.sales_2026
Values(12345,'micromax', 2, 12.30, '2026-02-11', 'lal bagh chauraha');

select * from sales.sales_2026
where orderid = '12345';

--corecting date 

UPDATE sales.sales_2026
SET order_timestamp =
TO_TIMESTAMP(order_date,'YYYY/02/11')
WHERE order_timestamp IS NULL;

alter table sales.sales_2026
ADD column total_sales numeric(8,2);

UPDATE sales.sales_2026
SET total_sales =
COALESCE(quantity_ordered,0) * COALESCE(price_each,0);
----Update data
UPDATE sales.sales_2026
SET price_each = '25.10'
WHERE OrderID = '12345';
-----check updation
Select *
from sales.sales_2026
Where Orderid = '12345';

---delete
DELETE FROM sales.sales_2026
WHERE orderid = '12345';

------------------------------------------CITY WISE SPLIT

SELECT
TRIM(SPLIT_PART(purchase_address, ',', 2)) AS city,
SUM(quantity_ordered * price_each) AS revenue
FROM sales.sales_2026
GROUP BY city
ORDER BY revenue DESC;



 








 
