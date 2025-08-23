--Task-1

SELECT ProductName AS Name FROM Products 

--Task-2

SELECT * FROM Customers AS Client

--Task-3

SELECT ProductName FROM Products 

UNION

SELECT ProductName FROM Products_Discounted 

--Task-4

SELECT * FROM Products 

INTERSECT

SELECT * FROM Products_Discounted 

--Task-5

SELECT DISTINCT FirstName, Country FROM Customers

--Task-6

SELECT *, 

CASE WHEN Price > 1000 THEN 'High' ELSE 'LOW' END AS 'PriceCategory' FROM Products

--Task-7

SELECT *, IIF(StockQuantity > 100, 'YES', 'NO') AS 'INSTOCK' FROM Products_Discounted

--Task-8

SELECT ProductName FROM Products 

UNION

SELECT ProductName FROM Products_Discounted 

--Task-9

SELECT * FROM Products 

EXCEPT

SELECT * FROM Products_Discounted

--Task-10

SELECT * , IIF ( Price > 1000,  'Expensive', 'Affordable') AS PriceCategory FROM Products

--Task-11

SELECT * FROM Employees 

WHERE Age < 25 OR Salary > 60000

--Task-12

UPDATE Employees 

SET Salary = Salary * 1.1

WHERE DepartmentName = 'HR' OR EmployeeID = 5

--Task-13

SELECT *, CASE WHEN SaleAmount > 500 THEN 'Top Tier'

WHEN SaleAmount > 200 THEN 'Mid Tier' ELSE 'Low Tier' END AS 'SaleCategory' FROM Sales

--Task-14

SELECT CustomerID FROM Orders

EXCEPT

SELECT CustomerID FROM Sales

--Task-15

SELECT CustomerID, Quantity, CASE WHEN Quantity = 1 THEN '3%' 
 
  WHEN Quantity > 1 AND   Quantity <= 3 THEN '5%' 
  
  ELSE '7%' END AS discount_persentage FROM Orders

ELSE '7%' END AS discount_persentage FROM Order
