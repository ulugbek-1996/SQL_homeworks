--TASK-1

SELECT R1.Region, R2.Distributor, ISNULL(R3.Sales, 0) AS Sales FROM

(SELECT DISTINCT Region FROM #RegionSales) AS R1

CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) AS R2

LEFT JOIN #RegionSales AS R3 ON R1.Region = R3.Region AND R2.Distributor = R3.Distributor

ORDER BY R2.Distributor , R1.Region

-- Task-2

SELECT E1.name FROM Employee AS E1
 
WHERE E1.id = (SELECT E.managerId FROM Employee AS E

GROUP BY E.managerId

HAVING COUNT(E.id) >= 5)

--Task-3

WITH O AS (SELECT product_id, SUM(unit) AS SUMUNIT FROM Orders

WHERE MONTH(order_date) = 2

GROUP BY product_id

HAVING SUM(unit) >= 100) 

SELECT P.product_id, P.product_name, O.SUMUNIT FROM Products AS P JOIN O ON P.product_id= O.product_id

--Task-4

WITH CTE AS (
    SELECT CustomerID, Vendor, COUNT(OrderID) AS CO 
    FROM Orders
    GROUP BY CustomerID, Vendor
),
CTE1 AS (
    SELECT CustomerID, MAX(CO) AS MAXCO 
    FROM CTE
    GROUP BY CustomerID
)
SELECT 
    CTE.CustomerID, 
    CTE.Vendor 
FROM CTE 
JOIN CTE1 
  ON CTE.CustomerID = CTE1.CustomerID 
 AND CTE.CO = CTE1.MAXCO;

--Task-5

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @i_Prime INT = 1;

IF @Check_Prime < 2

SET @i_Prime = 0
  
ELSE BEGIN WHILE @i < @Check_Prime BEGIN IF @Check_Prime % @i = 0 SET @i_Prime = 0

 SET @i = @i + 1 END

IF @i_Prime = 1 PRINT CAST(@Check_Prime AS VARCHAR) + ' is a Prime Number.'

ELSE PRINT CAST(@Check_Prime AS VARCHAR) + ' is  NOT a Prime Number.' END

--Task-6

WITH D1 AS (SELECT Device_id, Locations, COUNT(Locations) AS Number_loc FROM Device

GROUP BY Device_id, Locations),

D2 AS (SELECT D1.Device_id, MAX(Number_loc) AS MAXLOC FROM D1

GROUP BY D1.Device_id),

D3 AS (SELECT Device_id, COUNT(Locations) AS NumOVERALL_loc FROM Device

GROUP BY Device_id),

D4 AS (SELECT Device_id, COUNT (DISTINCT Locations) AS Num_loc FROM Device

GROUP BY Device_id)

SELECT D1.Device_id, D1.Locations, D4.Num_loc, D3.NumOVERALL_loc FROM D1 JOIN D2 ON

D1.Device_id = D2.Device_id AND  D1.Number_loc = D2.MAXLOC JOIN D3 ON D1.Device_id = D3.Device_id 

JOIN D4 ON D1.Device_id = D4.Device_id 

ORDER BY D3.NumOVERALL_loc DESC

--Task-7

SELECT E.EmpID, E.EmpName, E.Salary FROM Employee AS E

WHERE E.Salary > (SELECT AVG(Salary) AS AVGSAL FROM Employee AS E1 WHERE E.DeptID = E1.DeptID)

ORDER BY Salary DESC

--Task-8

WITH CTE AS (SELECT T.TicketID, COUNT(N.Number) AS NUMTIC FROM Tickets AS T LEFT JOIN Numbers AS N ON T.Number = N.Number

GROUP BY T.TicketID )

SELECT SUM(CASE WHEN NUMTIC = 3 THEN 100 WHEN NUMTIC >= 1 THEN 10 ELSE 0 END) 

AS PRICE  FROM CTE

--Task-9

	WITH S1 AS (SELECT User_id, Spend_date, Platform, SUM(Amount) AS SUMAMOUNT FROM Spending

	GROUP BY User_id, Spend_date, Platform),

	S2 AS (SELECT User_id, Spend_date, MAX(CASE WHEN Platform = 'Mobile' THEN SUMAMOUNT END) AS MobileAmount,

	MAX(CASE WHEN Platform = 'Desktop' THEN SUMAMOUNT END) AS DeskAmount FROM S1

	GROUP BY User_id, Spend_date),

	S3 AS (SELECT User_id, Spend_date, CASE WHEN MobileAmount IS NOT NULL AND DeskAmount IS NULL THEN 'Mobile'

	WHEN MobileAmount IS NULL AND DeskAmount IS NOT NULL THEN 'Desktop'

	when MobileAmount IS NOT NULL AND DeskAmount IS NOT NULL THEN 'BOTH' END AS Platform, 

	COALESCE(MobileAmount, 0) + COALESCE(DeskAmount, 0) AS Total_Amount FROM S2)

	SELECT Spend_date, Platform, SUM(Total_Amount) AS STotal_Amount, COUNT(DISTINCT(User_id)) AS Total_users FROM S3

	GROUP BY Spend_date, Platform

--Aproach 2

WITH MobileUsers AS (
  SELECT Spend_date, User_id, SUM(Amount) AS MobileAmount
  FROM Spending
  WHERE Platform = 'Mobile'
  GROUP BY Spend_date, User_id
),
DesktopUsers AS (
  SELECT Spend_date, User_id, SUM(Amount) AS DesktopAmount
  FROM Spending
  WHERE Platform = 'Desktop'
  GROUP BY Spend_date, User_id
),
MobileStats AS (
  SELECT 'Mobile' AS Platform, Spend_date, COUNT(DISTINCT User_id) AS Total_users, SUM(MobileAmount) AS Total_Amount
  FROM MobileUsers
  GROUP BY Spend_date
),
DesktopStats AS (
  SELECT 'Desktop' AS Platform, Spend_date, COUNT(DISTINCT User_id) AS Total_users, SUM(DesktopAmount) AS Total_Amount
  FROM DesktopUsers
  GROUP BY Spend_date
),
BothStats AS (
  SELECT
    'Both' AS Platform,
    Spend_date,
    COUNT(DISTINCT User_id) AS Total_users,
    SUM(Amount) AS Total_Amount
  FROM Spending
  GROUP BY Spend_date
)
SELECT * FROM (
  SELECT * FROM MobileStats
  UNION ALL
  SELECT * FROM DesktopStats
  UNION ALL
  SELECT * FROM BothStats
) AS Combined
ORDER BY Spend_date, 
  CASE Platform
    WHEN 'Mobile' THEN 1
    WHEN 'Desktop' THEN 2
    WHEN 'Both' THEN 3
  END;

--Task-10

-- Step 1: Declare a variable to hold the maximum quantity
DECLARE @max_qty INT;
SELECT @max_qty = MAX(Quantity) FROM Grouped;

-- Step 2: Recursive CTE to generate sequence from 1 to max quantity
WITH cte(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM cte WHERE n + 1 <= @max_qty
)

-- Step 3: Join with Grouped table to "de-group" it
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN cte ON cte.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);



