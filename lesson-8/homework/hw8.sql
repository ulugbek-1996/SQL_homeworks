--Task-1

SELECT * FROM Products

SELECT Category,COUNT(ProductID) AS amount_prod FROM Products

GROUP BY Category

--Task-2

SELECT Category, AVG(Price) AS avg_prod FROM Products

WHERE Category = 'Electronics'

GROUP BY Category

--Task-3

SELECT * FROM Customers

WHERE City LIKE 'L%'

--Task-4

SELECT * FROM Products

WHERE ProductName LIKE '%er'

--Task-5

SELECT * FROM Customers

WHERE Country LIKE '%A'

--Task-6

SELECT TOP 1 ProductName, MAX(Price) AS max_price FROM Products

GROUP BY ProductName

ORDER BY max_price DESC

--Task-7

SELECT *, 

CASE WHEN StockQuantity < 30 THEN 'Low Stock' ELSE 'Sufficient' END AS Label_stock 

FROM Products

--Task-8

SELECT Country, COUNT(CustomerID) AS num_CUST

FROM Customers

GROUP BY Country

--Task-9

SELECT MIN(Quantity) AS min_num, MAX(Quantity) AS max_num  FROM Orders

--Task-10

SELECT DISTINCT CustomerID FROM Orders 

WHERE OrderDate BETWEEN '2023-01-01' AND '2023-01-31'

EXCEPT

SELECT DISTINCT CustomerID FROM Invoices 

WHERE InvoiceDate BETWEEN '2023-01-01' AND '2023-01-31'

--Task-11

SELECT ProductName FROM Products

UNION ALL 

SELECT ProductName FROM Products_Discounted

--Task-12

SELECT ProductName FROM Products

UNION

SELECT ProductName FROM Products_Discounted

--Task-13

SELECT YEAR(OrderDate) AS year_date, AVG(TotalAmount) AS tot_AMOUNT FROM Orders

GROUP BY YEAR(OrderDate)

--Task-14

SELECT * FROM Products

SELECT ProductName, CASE WHEN Price < 100 THEN 'Low' WHEN Price BETWEEN 100 AND 500 THEN 'Mid'

ELSE 'High' END AS PriceGroup FROM Products

--Task-15

CREATE TABLE Population_Each_Year (
    City VARCHAR(100),
    [2012] INT,
    [2013] INT );

INSERT INTO Population_Each_Year (City, [2012], [2013])

SELECT district_name, [2012], [2013]

FROM ( SELECT district_name, Year, Population
   
   FROM City_Population ) AS SourceTable

PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;

SELECT * FROM Population_Each_Year

--Task-16

SELECT ProductID, SUM(SaleAmount) AS total_sales FROM Sales

GROUP BY ProductID

--Task-17

SELECT ProductName FROM Products

WHERE ProductName LIKE '%OO%'

--Task-18

SELECT *
INTO Population_Each_City
FROM (
    SELECT district_name, Population
    FROM City_Population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

--Task-19

SELECT * FROM Invoices

SELECT TOP 3 CustomerID, SUM(TotalAmount) AS Totalspent FROM Invoices

GROUP BY CustomerID

ORDER BY Totalspent DESC

--Task-20

SELECT district_name, Year, Population
INTO City_Population
FROM (
    SELECT City, [2012], [2013]
    FROM Population_Each_Year
) p
UNPIVOT (
    Population FOR Year IN ([2012], [2013]
) AS unpvt;

--Task-21

SELECT 
    P.ProductName,
   
   COUNT(S.SaleID) AS TimesSold

FROM Products P

LEFT JOIN Sales S ON P.ProductID = S.ProductID

GROUP BY P.ProductName

  ORDER BY TimesSold DESC;

--Task-22

SELECT City, Year, Population

  INTO City_Population

  FROM (
  
  SELECT Year, Bektemir, Chilonzor, Yakkasaroy
  
  FROM Population_Each_City

  ) src

  UNPIVOT (
  
  Population FOR City IN (Bektemir, Chilonzor, Yakkasaroy)








  
) AS unpvt;
