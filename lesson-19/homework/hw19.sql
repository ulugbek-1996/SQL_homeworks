--TASK-1

CREATE PROC bonusamounttable

AS BEGIN CREATE TABLE #EmployeeBonus(EmployeeID INT, FullName VARCHAR(100), Department VARCHAR(100), 

Salary INT, BonusAmount FLOAT);

INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)

SELECT E.EmployeeID, (E.FirstName +' ' + E.LastName) AS FullName, E.Department, E.Salary, 

(D.BonusPercentage * E.Salary/100) AS  BonusAmount

FROM Employees AS E JOIN DepartmentBonus AS D ON D.Department = E.Department

SELECT * FROM #EmployeeBonus

END

exec bonusamounttable

--TASK-2

CREATE PROC	increase_salary

@department VARCHAR(100), @percent FLOAT

AS BEGIN UPDATE Employees SET Salary = Salary + (Salary * @percent/100 ) WHERE Department = @department

SELECT * FROM Employees WHERE Department = @department END


exec increase_salary @department = 'Sales', @percent = 40

--TASK-3

MERGE Products_Current AS Target 

USING Products_New AS Source ON Target.ProductID = Source.ProductID

 WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- WHEN NOT MATCHED BY TARGET: INSERT new products
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

--Task-4

SELECT DISTINCT T1.id, CASE WHEN T1.p_id IS NULL THEN 'Root'WHEN T2.id IS NULL THEN 'LEAF' ELSE 'Inner' END AS TREETYPE

FROM Tree AS T1 LEFT JOIN Tree AS T2 ON T1.id = T2.p_id

--Task-5

WITH CTE AS (SELECT user_id, SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) CONFRATE, COUNT(user_id) AS OVERALL 

FROM Confirmations GROUP BY user_id)

SELECT S.user_id,  CASE WHEN ISNULL(CONFRATE, 0) = 0  

THEN 0 ELSE CAST(ISNULL(CONFRATE, 0) AS float)/ ISNULL(OVERALL, 0) END AS CONFIRMRATE FROM Signups AS S LEFT JOIN CTE 

ON S.user_id = CTE.user_id

--Task-6

SELECT * FROM employees AS E

WHERE salary = (SELECT MIN(salary) FROM employees AS E1)

--Task-7

CREATE PROC GetProductSalesSummary 

@ProductID INT  AS BEGIN

SELECT P.ProductName, SUM(S.Quantity) AS Total_Quantity_Sold, SUM(S.Quantity)*P.Price AS Total_Sales_Amount,

MIN(S.SaleDate) AS First_Sale_Date, MAX(S.SaleDate) AS Last_Sale_Date

FROM Products P LEFT JOIN Sales S ON P.ProductID = S.ProductID

WHERE P.ProductID = @ProductID

GROUP BY P.ProductName, P.Price END

EXEC GetProductSalesSummary @ProductID = 2


