
--Task-1

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS ROWSALE FROM ProductSales

--Task-2

SELECT ProductName, SUM(Quantity) AS Sumquantity, DENSE_RANK() OVER (ORDER BY SUM(Quantity)) AS ROWSALE 

FROM ProductSales GROUP BY ProductName ORDER BY ROWSALE 

--Task-3

WITH CTE AS (SELECT CustomerID, SaleAmount, RANK() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS RANK1 

FROM ProductSales) 

SELECT * FROM CTE 

WHERE RANK1 = 1

--Task-4

SELECT *, LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS Display FROM ProductSales 

--Task-5

SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate) AS Display FROM ProductSales

--Task-6

WITH SalesWithNext AS (
    SELECT 
        SaleID,
        SaleAmount,
        LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
        SaleDate
    FROM ProductSales
)
SELECT 
    SaleID,
    SaleAmount,
    NextSaleAmount
FROM SalesWithNext
WHERE NextSaleAm.ount > SaleAmount
ORDER BY SaleDate;

--Task-7

SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - ISNULL(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS SaleAmountDifference
FROM
    ProductSales
ORDER BY
    ProductName,
    SaleDate;

--Task-8

SELECT SaleID, ProductName, SaleDate, SaleAmount, LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NEXTSALE,

ROUND(((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount) *100, 2) AS PROCDIFFER FROM ProductSales

ORDER BY ProductName, SaleDate

--Task-9

SELECT 
    SaleID,	
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    ROUND(
        SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),
        2
    ) AS SaleAmountRatio
FROM 
    ProductSales
ORDER BY 
    ProductName, 
    SaleDate;

--Task-10

SELECT SaleID, ProductName, SaleDate, SaleAmount, FIRST_VALUE(SaleAmount) OVER (PARTITION BY 

ProductName ORDER BY SaleDate) AS First_value, (SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY 

ProductName ORDER BY SaleDate)) AS DIFFER FROM ProductSales

--Task-11

WITH CTE AS (SELECT SaleID, ProductName, SaleDate, SaleAmount, (LAG(SaleAmount) OVER (PARTITION BY 

ProductName ORDER BY SaleDate)) AS Prev_value FROM ProductSales)

SELECT * FROM CTE

WHERE SaleAmount > Prev_value

--Task-12

select p1.SaleID, p1.ProductName,p1.SaleDate, p1.SaleAmount, 

(select sum(p2.SaleAmount) as sumsale from ProductSales as p2 

where p2.SaleDate <=p1.SaleDate) as balans  from ProductSales as p1

--Task-13

with cte as (Select p1.SaleID, p1.ProductName, p1.SaleDate, p1.SaleAmount, 

DENSE_RANK() over (ORDER BY p1.SaleDate desc) as rankdate from ProductSales p1)

select sum(c.SaleAmount) as sumsale from cte as c

where c.rankdate in (1, 2,3)

--Task-14

WITH AVG1 AS (SELECT SaleID, SaleAmount, ProductName, (SELECT AVG(SaleAmount) FROM ProductSales) AS AVGSALE

FROM ProductSales)

SELECT A.SaleID, A.ProductName, (A.AVGSALE -A.SaleAmount) AS DIFFER FROM AVG1 AS A

--Task-15

with cte as (SELECT EmployeeID, Name, Salary, DENSE_RANK() OVER (ORDER BY Salary) AS salaryrank FROM Employees1)

SELECT EmployeeID, Name, Salary, salaryrank FROM cte

WHERE salaryrank IN (SELECT salaryrank FROM cte 

GROUP BY salaryrank HAVING COUNT(salaryrank) > 1)

--Task-16

WITH CTE AS (SELECT EmployeeID, Name, Department, Salary, 

DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RNK FROM Employees1)

SELECT EmployeeID, Name, Department, Salary, RNK FROM CTE

WHERE RNK <=2

ORDER BY Department, RNK

--Task-17

WITH CTE AS (SELECT  EmployeeID, Name, Department, Salary, DENSE_RANK() OVER 

(PARTITION BY Department ORDER BY SALARY) AS RNK FROM Employees1)

SELECT EmployeeID, Name, Department, Salary, RNK FROM CTE

WHERE RNK = 1 ORDER BY Department

--Task-18

SELECT EmployeeID, Department, Salary, (SELECT SUM(Salary) FROM Employees1 AS E

WHERE E.Department =Employees1.Department AND E.EmployeeID < = Employees1.EmployeeID) AS SUMSAL FROM Employees1

ORDER BY Department, Salary 

--Task-19

SELECT DISTINCT Department, (SELECT SUM(E1.Salary) AS SUMDEPART FROM Employees1 AS E1

WHERE E1.Department = Employees1.Department) AS SUMDEPART FROM Employees1

--Task-20

--1) 
SELECT DISTINCT Department, (SELECT AVG(E.Salary) FROM Employees1 AS E 

WHERE E.Department = Employees1.Department) AS AVGSALARY FROM Employees1

--2)
SELECT DISTINCT Department, AVG(Salary) OVER (PARTITION BY Department) FROM Employees1

--Task-21

SELECT EmployeeID, Name, Department, Salary, (SELECT AVG(Salary) FROM Employees1 AS E

WHERE E.Department = Employees1.Department) AS AVGSALARY, 

((SELECT AVG(Salary) FROM Employees1 AS E

WHERE E.Department = Employees1.Department) - Salary) AS DIFFER FROM Employees1

ORDER BY Department, EmployeeID

--Task-22
---1)
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees1
ORDER BY EmployeeID;

--2)

SELECT E.EmployeeID, E.Name, E.Department, E.Salary, ((E.Salary + ISNULL(PREV.Salary, 0) + ISNULL(NT.Salary, 0)) /

(1 + CASE WHEN PREV.Salary IS NULL THEN 0 ELSE 1 END + CASE WHEN NT.Salary IS NULL THEN 0 ELSE 1 END)) AS MovingSalary

FROM Employees1 AS E LEFT JOIN Employees1 AS PREV ON 

E.EmployeeID - 1 = PREV.EmployeeID LEFT JOIN Employees1 AS NT ON NT.EmployeeID = E.EmployeeID + 1  

ORDER BY EmployeeID

--Task-23

WITH CTE AS (SELECT EmployeeID, Name, Salary, ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RNKDATE 
FROM Employees1)

SELECT SUM(Salary) AS SUMSALARY FROM CTE

WHERE RNKDATE <= 3;


