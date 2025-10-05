
--Task-1

SELECT *, SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS total_sales  FROM sales_data

--Task-2

SELECT 
    product_category, 
    COUNT(sale_id) AS total_orders
FROM sales_data
GROUP BY product_category
ORDER BY total_orders DESC;

--Task-3

select * , MAX(total_amount) over (PARTITION BY product_category )  as maxtotal from sales_data

--Task-4

select * , MIN(total_amount) over (PARTITION BY product_category )  as mINtotal from sales_data

--Task-5

select * , AVG(total_amount) over (ORDER BY order_date rows between 1 preceding and 1 following)  

as avgtotal from sales_data

--Task-6

select * , SUM(total_amount) over (PARTITION BY REGION)  

as SUMREGIONtotal from sales_data

--Task-7

with customer as (select distinct customer_id, customer_name, SUM(total_amount) over (PARTITION BY customer_id)  

as SUMREGIONtotal from sales_data)

select *, DENSE_RANK() over (order by SUMREGIONtotal DESC) AS RANKC from customer as c

--Task-8

SELECT *, LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS PREVDATE,

(total_amount - ISNULL(LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date), 0)) 

AS DIFFER FROM sales_data ORDER BY customer_id, order_date

--Task-9

WITH RANKPRICE1 AS (SELECT product_category, product_name, DENSE_RANK() OVER (PARTITION BY product_category 

ORDER BY unit_price DESC) AS rankprice FROM sales_data)

SELECT * FROM RANKPRICE1

WHERE rankprice <= 3

--Task-10

SELECT *, SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS SUMSALES FROM sales_data

--Task-11

SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;

--Task-12

CREATE TABLE Sample1(ID INT)    INSERT INTO Sample1 VALUES (1), (2), (3), (4), (5) 

SELECT *, SUM(ID) OVER (ORDER BY ID) AS SumPRE FROM Sample1

--Task-13

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT *, SUM(Value) OVER (ORDER BY Value rows between 1 preceding and current row ) AS Sum_of_Previous FROM OneColumn

--Task-14

WITH cte1 AS (SELECT DISTINCT customer_id, customer_name, product_category FROM sales_data),

cte2 AS (SELECT customer_id, customer_name, COUNT(product_category) OVER (PARTITION BY customer_id) AS numcount  FROM cte1)

SELECT DISTINCT customer_id, customer_name FROM cte2

WHERE numcount > 1;

SELECT customer_id, customer_name, COUNT(DISTINCT product_category) AS CATEGORY FROM sales_data

GROUP BY customer_id, customer_name

HAVING COUNT(DISTINCT product_category) > 1;

--Task-15

WITH CTE AS (SELECT customer_id, customer_name, total_amount, AVG(total_amount) OVER (PARTITION BY region) 

AS AVGSALES FROM sales_data)

SELECT * FROM CTE

WHERE total_amount > AVGSALES

--Task-16

	SELECT
    region,
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spending,
    RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS rank_within_region
FROM
    sales_data
GROUP BY
    region,
    customer_id,
    customer_name
ORDER BY
    region,
    rank_within_region;

--TASK-17

SELECT *, SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS SUMTOTAL FROM sales_data

ORDER BY customer_id, order_date


--TASK-18

WITH CTE AS (SELECT YEAR(order_date) AS YEARDATE, MONTH(order_date) AS MONTHDATE, SUM(total_amount) AS SUMTOTAL 

FROM sales_data GROUP BY YEAR(order_date), MONTH(order_date))

SELECT YEARDATE, MONTHDATE, SUMTOTAL, LAG(SUMTOTAL) OVER (ORDER BY YEARDATE, MONTHDATE) AS PREVMONTH,

CASE WHEN LAG(SUMTOTAL) OVER (ORDER BY YEARDATE, MONTHDATE) IS NULL THEN NULL

ELSE ROUND(((SUMTOTAL - LAG(SUMTOTAL) OVER (ORDER BY YEARDATE, MONTHDATE))/LAG(SUMTOTAL) 

--TASK-19

with cte as (SELECT customer_id, customer_name, total_amount, LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS PREVTOTAL FROM sales_data)

select * from cte 

where total_amount > PREVTOTAL

--TASK-20

SELECT * FROM sales_data

WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data)

--TASK-21

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

SELECT *, CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 

THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp) ELSE NULL END TOT FROM MyData 

--TASK-22

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

WITH DistinctQty AS (
    SELECT DISTINCT ID, Quantity FROM TheSumPuzzle
),
QtyCount AS (
    SELECT
        ID,
        COUNT(*) OVER (PARTITION BY ID) AS DistinctQtyCount,
        SUM(Quantity) OVER (PARTITION BY ID) AS SumQuantity,
        MAX(Quantity) OVER (PARTITION BY ID) AS MaxQuantity
    FROM DistinctQty
)
SELECT DISTINCT
    t.ID,
    SUM(t.Cost) OVER (PARTITION BY t.ID) AS Cost,
    CASE 
        WHEN q.DistinctQtyCount = 1 THEN q.MaxQuantity
        ELSE q.SumQuantity
    END AS Quantity
FROM
    TheSumPuzzle t
JOIN
    QtyCount q ON t.ID = q.ID
ORDER BY
    t.ID;

--TASK-23

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

WITH NumberedSeats AS (
    SELECT 
        SeatNumber,
        LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS NextSeat
    FROM Seats
),
Gaps AS (
    SELECT
        CASE WHEN SeatNumber + 1 < NextSeat THEN SeatNumber + 1 ELSE NULL END AS GapStart,
        CASE WHEN SeatNumber + 1 < NextSeat THEN NextSeat - 1 ELSE NULL END AS GapEnd
    FROM NumberedSeats
),
FirstSeat AS (
    SELECT MIN(SeatNumber) AS MinSeat FROM Seats
),
LastSeat AS (
    SELECT MAX(SeatNumber) AS MaxSeat FROM Seats
),
BeforeFirst AS (
    SELECT 1 AS GapStart, MinSeat - 1 AS GapEnd FROM FirstSeat WHERE MinSeat > 1
),
AfterLast AS (
    -- If you want to consider gaps after the last seat, define max range. 
    -- Not required for this question since output ends at 54.
    SELECT NULL AS GapStart, NULL AS GapEnd WHERE 1=0 -- no gap after last seat
)
SELECT GapStart, GapEnd FROM BeforeFirst
UNION ALL
SELECT GapStart, GapEnd FROM Gaps WHERE GapStart IS NOT NULL
ORDER BY GapStart;

