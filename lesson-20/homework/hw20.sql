--Task-1

SELECT * FROM #Sales S1

WHERE EXISTS (SELECT 1 FROM  #Sales S2 WHERE  S1.CustomerName = S2.CustomerName AND MONTH(S2.SaleDate) = 3)

--task-2

SELECT Product, SUM(Quantity * Price) AS TOTALREVENUE FROM #Sales S1

GROUP BY Product HAVING SUM(Quantity * Price) = (SELECT MAX(REVENUE) AS MAXREV FROM (SELECT SUM(Quantity * Price) AS REVENUE 

FROM #Sales S2 GROUP BY Product) AS REVPERPRO)

--task-3

SELECT MAX(Quantity*Price) AS MAXQUAN2 FROM #Sales S1

WHERE (Quantity * Price) < (SELECT MAX(Quantity*Price) AS MAXQUAN2 FROM #Sales S2)

--task-4

SELECT MONTH(SaleDate) AS MONTHSALE, YEAR(SaleDate) AS YEARSALE, (SELECT SUM(Quantity) AS TotalQuantity 

FROM #Sales AS S2 WHERE MONTH(S1.SaleDate) = MONTH(S2.SaleDate) AND YEAR(S2.SaleDate) = YEAR(S1.SaleDate)) 

AS Total_quantity FROM #Sales AS S1

GROUP BY MONTH(SaleDate), YEAR(SaleDate)

--task-5

SELECT DISTINCT S1.CustomerName FROM #Sales AS S1

WHERE EXISTS (SELECT 1 FROM #Sales AS S2 WHERE S1.Product = S2.Product AND S1.CustomerName <> S2.CustomerName)

--task-6

SELECT Name, SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS APPLE, 

SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS BANANA, 

SUM(CASE WHEN Fruit = 'ORANGE' THEN 1 ELSE 0 END) AS ORANGE FROM Fruits

GROUP BY Name

--task-7

create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

WITH RecursiveFamily AS (
    -- Base case: direct parent-child pairs
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family

    UNION ALL

    -- Recursive case: find descendants by joining recursively
    SELECT rf.PID, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f ON rf.CHID = f.ParentId
)
SELECT PID, CHID
FROM RecursiveFamily
ORDER BY PID, CHID;

--Task-8

SELECT * FROM #Orders AS O1

WHERE DeliveryState = 'TX' AND EXISTS (SELECT 1  FROM #Orders O2 

WHERE O1.CustomerID = O2.CustomerID AND O2.DeliveryState = 'CA')

--Task-9

UPDATE #residents

SET address = address + 'name =' +fullname

WHERE CHARINDEX('name =', address) = 0

--Task-10

SELECT
    'Tashkent - Samarkand - Khorezm' AS Route,
    SUM(Cost) AS Cost
FROM #Routes
WHERE (DepartureCity = 'Tashkent' AND ArrivalCity = 'Samarkand')
   OR (DepartureCity = 'Samarkand' AND ArrivalCity = 'Khorezm')

UNION ALL

SELECT
    'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm' AS Route,
    SUM(Cost) AS Cost
FROM #Routes
WHERE (DepartureCity = 'Tashkent' AND ArrivalCity = 'Jizzakh')
   OR (DepartureCity = 'Jizzakh' AND ArrivalCity = 'Samarkand')
   OR (DepartureCity = 'Samarkand' AND ArrivalCity = 'Bukhoro')
   OR (DepartureCity = 'Bukhoro' AND ArrivalCity = 'Khorezm')
;
--Task-11

SELECT *, (select COUNT(R2.Vals) from  #RankingPuzzle AS R2 WHERE R2.Vals ='Product' AND R2.ID< = R1.ID)

AS Productrank

FROM #RankingPuzzle AS R1

--Task-12

SELECT * FROM #EmployeeSales AS E1

WHERE SalesAmount > (SELECT AVG(SalesAmount) AS AVGSALES FROM #EmployeeSales AS E2

WHERE E1.Department = E2.Department)

--Task-13

SELECT * FROM #EmployeeSales AS E1

WHERE NOT EXISTS (SELECT 1 FROM #EmployeeSales AS E2 WHERE

E1.SalesMonth = E2.SalesMonth AND E1.SalesYear = E2.SalesYear AND E2.SalesAmount > E1.SalesAmount)

--Task-14
	
SELECT DISTINCT EmployeeName
FROM #EmployeeSales E1
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales
    ) AS AllMonths
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales E2
        WHERE E2.EmployeeName = E1.EmployeeName
          AND E2.SalesMonth = AllMonths.SalesMonth
          AND E2.SalesYear = AllMonths.SalesYear
    )
);

--Task-15

SELECT * FROM Products AS P1

WHERE P1.Price >(SELECT AVG(P2.Price) AS AVGPRICE FROM Products AS P2 )

--Task-16

SELECT * FROM Products 

WHERE Stock < (SELECT MAX(Stock) FROM Products)

--Task-17

SELECT  P1.Name  FROM Products AS P1

WHERE P1.Category = (SELECT Category FROM Products AS P2 WHERE P2.Name = 'Laptop')

--Task-18

SELECT  *  FROM Products AS P1

WHERE P1.Price > (SELECT MIN(P2.Price) FROM Products AS P2 

WHERE P2.Category = 'Electronics')

--Task-19

SELECT  *  FROM Products AS P1

WHERE P1.Price > (SELECT AVG(P2.Price) FROM Products AS P2 WHERE P1.Category = P2.Category)

--Task-20

SELECT DISTINCT ProductID FROM Orders

--Task-21

SELECT P.ProductID, P.Name FROM Products AS P JOIN Orders AS O ON P.ProductID = O.ProductID

GROUP BY P.ProductID, P.Name 

HAVING SUM(O.Quantity) > (SELECT AVG(Quantity) FROM Orders)

--Task-22

SELECT * FROM Products P

WHERE NOT EXISTS(SELECT 1 FROM Orders O WHERE O.ProductID = P.ProductID )

--Task-23
--1)
WITH CTE AS (SELECT P.ProductID, P.Name, O.Quantity FROM Products P JOIN Orders O ON P.ProductID = O.ProductID)

SELECT TOP 1 C.Name, MAX(C.Quantity) AS MAXQUANTITY FROM CTE C

GROUP BY C.Name

ORDER BY MAXQUANTITY DESC


--2)
SELECT TOP 1 P.ProductID, P.Name, O.Quantity FROM Products P JOIN Orders O ON P.ProductID = O.ProductID

ORDER BY O.Quantity DESC





