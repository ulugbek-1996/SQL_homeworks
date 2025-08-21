--Task-1

1)To select the top 5 highest-paid employees:

SELECT TOP 5 * FROM Employees

ORDER BY Salary DESC

2)To select the top 5 most recently hired employees:

SELECT TOP 5 * FROM Employees

ORDER BY HireDate DESC

--Task-2

SELECT DISTINCT Category FROM Products

--Task-3

SELECT * FROM Products

WHERE Price > 100

--Task-4

SELECT * FROM Customers

WHERE FirstName LIKE 'A%'

--Task-5

SELECT * FROM Products

ORDER BY PRICE ASC

--Task-6

SELECT * FROM Employees

WHERE Salary >= 60000 AND DepartmentName = 'HR'

--Task-7

SELECT EmployeeID,FirstName, LastName, DepartmentName, Salary, HireDate, Age INT,

ISNULL(Email,'noemail@example.com') AS Email, Country FROM Employees

--Task-8

SELECT * FROM Products

WHERE Price BETWEEN 50 AND 100

--Task-9

SELECT DISTINCT Category, ProductName FROM Products

--Task-10

SELECT DISTINCT Category, ProductName FROM Products

ORDER BY ProductName DESC

--Task-11

SELECT TOP 10 * FROM  Products

ORDER BY Price DESC

--Task-12

SELECT COALESCE (FirstName, LastName)  AS NAME FROM Employees

--Task-13

SELECT DISTINCT Category, Price FROM Products

--Task-14

SELECT * FROM Employees

WHERE (Age BETWEEN 30 AND 40) OR (DepartmentName = 'Marketing')

--Task-15

SELECT * FROM Employees

ORDER BY Salary DESC OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY 

--Task-16

SELECT * FROM Products

WHERE Price <= 1000 AND StockQuantity > 50

ORDER BY StockQuantity ASC 

--Task-17

SELECT * FROM Products

WHERE ProductName LIKE '%e%'

--Task-18

SELECT * FROM Employees

WHERE DepartmentName IN ('HR', 'IT', 'Finance')

--Task-19

SELECT * FROM Customers

ORDER BY City ASC, PostalCode DESC

--Task-20

SELECT TOP 5 * FROM Sales

ORDER BY SaleAmount DESC

--Task-21

SELECT EmployeeID, FirstName +' '+ LastName AS FullName, 
  
DepartmentName, Salary, HireDate, Age, Email, Country FROM Employees

--Task-22

SELECT DISTINCT Category, ProductName, Price FROM Products

WHERE Price > 50

--Task-23

SELECT ProductID, ProductName, Price, Category, StockQuantity FROM Products

Where Price < 0.1 * (SELECT AVG(Price) FROM Products)

--Task-24

SELECT * FROM Employees

WHERE Age < 30 AND DepartmentName IN ('IT', 'HR')

--Task-25

SELECT * FROM Customers

WHERE Email LIKE '%@gmail.com'

--Task-26

SELECT * FROM Employees

WHERE Salary > ALL (SELECT Salary FROM Employees WHERE DepartmentName = 'Sales')

--Task-27

SELECT * FROM Orders

WHERE OrderDate BETWEEN DATEADD(DAY, -180, LATEST_DATE) AND LATEST_DATE
