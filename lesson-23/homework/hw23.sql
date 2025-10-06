
--TASK-1

SELECT *, RIGHT('0'+ CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS ADDIT FROM Dates

--Task-2

WITH CTE AS (SELECT Id, rID, MAX(Vals) AS MAXVALUE FROM MyTabel

GROUP BY Id, rID)

SELECT COUNT(DISTINCT Id) AS Distinct_Ids, rID, SUM(MAXVALUE) AS TotalOfMaxVals  FROM CTE

GROUP BY rID

--TASK-3

SELECT * FROM TestFixLengths

WHERE LEN(Vals) BETWEEN 6 AND 10

--TASK-4

SELECT * FROM TestMaximum AS T2

WHERE Vals = (SELECT MAX(Vals) AS MAXVALUE FROM TestMaximum AS T1 WHERE T1.ID = T2.ID)

ORDER BY ID

--Task-5

WITH CTE AS (SELECT Id, DetailedNumber, MAX(Vals) AS MAXVALUE FROM SumOfMax

GROUP BY Id, DetailedNumber)

SELECT Id, SUM(MAXVALUE) AS SUMOFMAX FROM CTE

GROUP BY Id

--Task-6

CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

SELECT *, CASE WHEN a - b = 0 THEN ''  ELSE CAST(a - b AS varchar) END AS OUTPUT FROM TheZeroPuzzle

--Task-7

SELECT *, SUM(QuantitySold * UnitPrice) OVER () AS TOTALR FROM Sales

--TASK-8

SELECT *, AVG(UnitPrice) OVER () AS AVGR FROM Sales

--TASK-9

SELECT *, COUNT(SaleID) OVER () AS AVGR FROM Sales

--TASK-10

SELECT *, MAX(QuantitySold) OVER () AS MAXSALE FROM Sales

--TASK-11

SELECT *, SUM(QuantitySold) OVER (PARTITION BY Category) AS sumSALE FROM Sales


--TASK-12

SELECT Region, SUM(QuantitySold * UnitPrice) AS regionSALE FROM Sales

GROUP BY Region

--TASK-13

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS MAXSALE FROM Sales

GROUP BY Product ORDER BY MAXSALE DESC

--TASK-14

SELECT *, SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS sumSALE FROM Sales

--TASK-15

--1)

SELECT *, SUM(QuantitySold * UnitPrice) OVER (PARTITION BY Category)*100.0/SUM(QuantitySold * UnitPrice) OVER() AS cateSALE FROM Sales

--2)

SELECT Category,
       SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
       SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS ContributionPercent
FROM Sales
GROUP BY Category;

--TASK-17

SELECT S.SaleID, S.SaleDate, S.CustomerID, C.CustomerName FROM Customers C JOIN Sales S ON C.CustomerID = S.CustomerID

--TASK-18

SELECT * FROM Customers C LEFT JOIN Sales S ON C.CustomerID = S.CustomerID

WHERE S.CustomerID IS NULL

--TASK-19

SELECT S.CustomerID, SUM(QuantitySold * UnitPrice) AS SUMTOTAL, C.CustomerName FROM Sales S JOIN Customers C 

ON S.CustomerID = C.CustomerID GROUP BY S.CustomerID, C.CustomerName ORDER BY SUMTOTAL

--TASK-20

SELECT TOP 1 S.CustomerID, SUM(QuantitySold * UnitPrice) AS SUMTOTAL, C.CustomerName FROM Sales S JOIN Customers C 

ON S.CustomerID = C.CustomerID GROUP BY S.CustomerID, C.CustomerName ORDER BY SUMTOTAL DESC

--TASK-21

SELECT TOP 1 S.CustomerID, C.CustomerName, SUM(QuantitySold * UnitPrice) AS SUMTOTAL, COUNT(S.SaleID) AS TOTALSALES

FROM Sales S JOIN Customers C 

ON S.CustomerID = C.CustomerID GROUP BY S.CustomerID, C.CustomerName ORDER BY SUMTOTAL DESC

--TASK-22

SELECT DISTINCT P.ProductID, P.ProductName FROM Sales S JOIN Products P ON S.Product =P.ProductName

--TASK-23

SELECT * FROM Products

WHERE CostPrice = (SELECT MAX(CostPrice) FROM Products)

--TASK-24

SELECT * FROM Products P1

WHERE P1.SellingPrice > (SELECT AVG(SellingPrice) FROM Products P2 WHERE P1.Category = P2.Category)


