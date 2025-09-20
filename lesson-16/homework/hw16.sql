--Easy Tasks

--Task-1

WITH Numbers AS (
    SELECT 1 AS number
    UNION ALL
    SELECT number + 1
    FROM Numbers
    WHERE number < 1000
)
SELECT number
FROM Numbers
OPTION (MAXRECURSION 1000);

--Task-2

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
)

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

SELECT E.EmployeeID, s.sum FROM Employees AS E

JOIN (SELECT EmployeeID, SUM(SalesAmount) AS sum FROM Sales  GROUP BY EmployeeID) AS S

ON E.EmployeeID = S.EmployeeID

--Task-3

WITH CTE AS (SELECT AVG(Salary) AS AVGSAL FROM Employees)


SELECT * FROM CTE

--Task-4

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);

SELECT P.ProductID, P.ProductName, S.MAXAMOUNT FROM Products AS P JOIN

(SELECT ProductID, MAX(SalesAmount) AS MAXAMOUNT FROM Sales

GROUP BY ProductID) AS S ON P.ProductID = S.ProductID

--Task-5

-- Declare a table variable to hold the values
DECLARE @Doubles TABLE (value BIGINT);

-- Declare and initialize the counter
DECLARE @val BIGINT = 1;

-- Loop: double the value each time while it's less than 1,000,000
WHILE @val < 1000000
BEGIN
    INSERT INTO @Doubles (value) VALUES (@val);
    SET @val = @val * 2;
END

-- Return the results
SELECT * FROM @Doubles;

--Task-6

 WITH CTE AS

(SELECT EmployeeID, COUNT(SalesID) AS Numsale FROM Sales

GROUP BY EmployeeID )

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, CTE.Numsale FROM CTE

JOIN Employees ON CTE.EmployeeID=Employees.EmployeeID

WHERE CTE.Numsale > 5

--Task-7

 WITH CTE AS (SELECT ProductID, SUM(SalesAmount) AS SUMSALES FROM Sales

 GROUP BY ProductID)
 
 SELECT P.ProductID, P.ProductName, SUMSALES FROM CTE  JOIN Products AS P

 ON P.ProductID = CTE.ProductID WHERE SUMSALES > 500

--Task-8

WITH CTE AS (SELECT  AVG(E.Salary) AS AVGSAL FROM Employees AS E)

SELECT E.EmployeeID, E.FirstName,E.LastName,E.Salary, C.AVGSAL FROM CTE AS C CROSS JOIN Employees AS E

WHERE E.Salary > C.AVGSAL

--Medium Tasks

--Task-1

SELECT TOP 5 E.EmployeeID, E.FirstName, E.LastName, S1.NUMSALE FROM Employees AS E JOIN 

(SELECT S.EmployeeID, COUNT(S.SalesID) AS NUMSALE FROM Sales AS S

GROUP BY S.EmployeeID) AS S1 ON E.EmployeeID=S1.EmployeeID ORDER BY NUMSALE DESC

--Task-2

 SELECT P.CategoryID, SUM(S1.SUMSALE) AS SUM2SALE FROM Products AS P JOIN 

(SELECT S.ProductID, SUM(S.SalesAmount) AS SUMSALE FROM Sales AS S 

GROUP BY S.ProductID) S1 ON P.ProductID = S1.ProductID

GROUP BY P.CategoryID ORDER BY SUM2SALE DESC

--Task-3

-- Drop function if it already exists
IF OBJECT_ID('dbo.GetFactorial', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetFactorial;
GO

-- Create the factorial function
CREATE FUNCTION dbo.GetFactorial (@num INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @result BIGINT = 1;
    DECLARE @i INT = 1;

    IF @num < 0
        RETURN NULL;  -- Factorial not defined for negative numbers

    WHILE @i <= @num
    BEGIN
        SET @result = @result * @i;
        SET @i = @i + 1;
    END

    RETURN @result;
END;
GO

--TASK-4	

-- Recursive CTE to split strings into characters by row
WITH RecursiveSplit AS (
    -- Anchor member: start with first character
    SELECT
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example

    UNION ALL

    -- Recursive member: go to next character
    SELECT
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM RecursiveSplit
    WHERE Position + 1 <= LEN(String)
)
SELECT 
    Id,
    Position,
    Character
FROM RecursiveSplit
ORDER BY Id, Position
OPTION (MAXRECURSION 32767);  -- Allow deeper recursion for long strings

--Task-5

WITH _MONTH AS (SELECT YEAR(SaleDate) AS YEARSALES, MONTH(SaleDate) AS MONTHSALE, SUM(SalesAmount) 

AS TOTALSALES  FROM Sales GROUP BY YEAR(SaleDate), MONTH(SaleDate))

SELECT C.YEARSALES, C.MONTHSALE, C.TOTALSALES, P.TOTALSALES, 

(C.TOTALSALES - P.TOTALSALES) AS DIFSALE FROM _MONTH AS C LEFT JOIN _MONTH AS P 

ON C.YEARSALES = P.YEARSALES AND C.MONTHSALE = P.MONTHSALE + 1

OR (C.YEARSALES = P.YEARSALES + 1 AND C.MONTHSALE = 1 AND P.MONTHSALE = 12)

ORDER BY C.YEARSALES, C.MONTHSALE

--Task-6

SELECT E.EmployeeID, E.FirstName, S1.QUARTERDATE, S1.SUMSALE FROM Employees AS E JOIN 

(SELECT EmployeeID, SUM(SalesAmount) AS SUMSALE, DATEPART(QUARTER, SaleDate) 

AS QUARTERDATE FROM Sales

WHERE YEAR(SaleDate) = '2025'

GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)

HAVING SUM(SalesAmount) > 45000) AS S1 ON E.EmployeeID = S1.EmployeeID

--Difficult Tasks

--Task-1

-- Fibonacci Sequence using Recursive CTE in SQL Server
WITH FibonacciCTE (n, fib1, fib2) AS (
    -- Anchor member (first row)
    SELECT 1 AS n, 0 AS fib1, 1 AS fib2
    UNION ALL
    -- Recursive member
    SELECT 
        n + 1,
        fib2,
        fib1 + fib2
    FROM FibonacciCTE
    WHERE n < 20  -- 🔁 Change this to generate more terms
)
-- Final SELECT
SELECT 
    n AS Position,
    fib1 AS FibonacciNumber
FROM FibonacciCTE
OPTION (MAXRECURSION 1000);  -- 🚫 Prevents infinite recursion

--Task-2

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')

SELECT * FROM FindSameCharacters

WHERE LEN(Vals) > 1 AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0

--Task-3

CREATE TABLE NUM_SEQ (ID INT IDENTITY(1,1), Numbersequeze VARCHAR(1000))

declare @n int = 100

DECLARE @i int = 1  DECLARE @coulumnum varchar(1000) = ''

WHILE @i < @n

BEGIN 

SET  @coulumnum = @coulumnum + CAST(@i AS VARCHAR)

INSERT INTO NUM_SEQ(Numbersequeze) VALUES (@coulumnum)

SET @i = @i + 1

END

SELECT * FROM NUM_SEQ

--Task-4

SELECT TOP 1 with ties E.EmployeeID, E.FirstName, SUMSALE FROM Employees AS E JOIN

(SELECT EmployeeID, SUM(SalesAmount) AS SUMSALE FROM Sales

WHERE SaleDate BETWEEN DATEADD(MONTH, -6, GETDATE()) AND GETDATE()

GROUP BY EmployeeID) AS S ON E.EmployeeID = S.EmployeeID

ORDER BY SUMSALE DESC

--Task-5

SELECT * FROM RemoveDuplicateIntsFromNames

SELECT case when len(Pawan_slug_name) - len(REPLACE(Pawan_slug_name, RIGHT(Pawan_slug_name,1),'')) > 1

or len(SUBSTRING(pawan_slug_name, charindex('-', pawan_slug_name)+1,len(pawan_slug_name))) = 1

then REPLACE(Pawan_slug_name, RIGHT(Pawan_slug_name,1),'')

else pawan_slug_name end as num FROM RemoveDuplicateIntsFromNames


