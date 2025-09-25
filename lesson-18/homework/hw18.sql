
--Task-1

CREATE TABLE #MonthlySales(ID INT, TotalQuantity INT, TotalRevenue INT)

INSERT INTO #MonthlySales SELECT P.ProductID, ISNULL(SUM(Quantity), 0) AS TotalQuantity, ISNULL(SUM(Quantity * P.Price), 0)  AS TotalRevenue

FROM Products AS P LEFT JOIN Sales S ON  P.ProductID = S.ProductID

WHERE YEAR(S.SaleDate) = YEAR(GETDATE()) AND MONTH(S.SaleDate) = MONTH(GETDATE())

GROUP BY P.ProductID

SELECT * FROM #MonthlySales;

--Task-2

CREATE VIEW vw_ProductSalesSummary AS

SELECT P.ProductID, P.ProductName, P.Category, SUM(Quantity) AS TotalQuantitySold FROM Products AS P JOIN Sales AS S

ON P.ProductID = S.ProductID  GROUP BY P.ProductID, P.ProductName, P.Category


SELECT * FROM vw_ProductSalesSummary;

--Task-3

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)

RETURNS DECIMAL(15,2)

AS BEGIN DECLARE @total_revenue DECIMAL(15,2);

SELECT @total_revenue = SUM(ISNULL(S.Quantity, 0) * ISNULL(P.Price, 0))

FROM Products AS P JOIN Sales S ON  P.ProductID = S.ProductID 

WHERE P.ProductID = @ProductID RETURN ISNULL(@total_revenue, 0)

END 
	
SELECT dbo.fn_GetTotalRevenueForProduct(2) AS TotalRevenue;

--Task-4

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))

RETURNS @Result TABLE (
    ProductName VARCHAR(100),
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @Result SELECT P.ProductName, SUM(ISNULL(Quantity, 0)) AS TotalQuantity, SUM(ISNULL(Quantity, 0) * ISNULL(P.Price, 0))  

AS TotalRevenue FROM Products AS P LEFT JOIN Sales S ON  P.ProductID = S.ProductID

WHERE @Category = P.Category GROUP BY P.ProductName; RETURN ; END


SELECT * FROM dbo.fn_GetSalesByCategory('Clothing');

--Task-5

CREATE function dbo.fn_IsPrime (@Number INT)

Returns VARCHAR(5) AS BEGIN  IF @Number < 2 RETURN 'NO'; DECLARE @i int = 2;

WHILE @i*@i<= @Number BEGIN IF @Number % @i = 0 RETURN 'NO'; SET @i = @i + 1;

END RETURN 'YES'; END;

SELECT dbo.fn_IsPrime (2E) AS RESULT;

--Task-6

CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)

RETURNS @RESULT TABLE(Number int) AS BEGIN DECLARE @i INT = @Start WHILE @i < = @End

BEGIN INSERT INTO @RESULT(Number) VALUES (@i); SET @i=@i + 1; END; RETURN; END;

SELECT * FROM dbo.fn_GetNumbersBetween(7, 21); 

--Task-7

CREATE FUNCTION getNthHighestSalary(@N INT)                        

RETURNS INT AS BEGIN DECLARE @i int; SELECT @i = salary FROM 

(SELECT DISTINCT salary FROM Employee ORDER BY salary DESC OFFSET @N -1 ROWS FETCH NEXT 1 ROWS ONLY) AS TEMP

RETURN @i; END;

SELECT dbo.getNthHighestSalary(2) AS HIGHEST;

--Task-8

CREATE VIEW RA AS (SELECT requester_id FROM InputRequestAccepted1

UNION ALL 

SELECT accepter_id FROM InputRequestAccepted1) 

SELECT TOP 1 requester_id, COUNT(requester_id) AS NUMFRIEND FROM RA

GROUP BY requester_id

ORDER BY NUMFRIEND DESC 

--Task-9

CREATE VIEW SUMMARY AS

(SELECT C.customer_id, C.name, COUNT(O.order_id) AS ORDNUM, SUM(ISNULL(O.amount, 0)) AS AMOUNT, 

MAX(O.order_date) AS lastdate

FROM Customers AS C LEFT JOIN Orders AS O ON C.customer_id = O.customer_id

GROUP BY C.customer_id, C.name)

SELECT * FROM SUMMARY

--Task-10

SELECT 
    RowNumber,
    MAX(Workflow) OVER (
        ORDER BY RowNumber 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Workflows
ORDER BY RowNumber;


