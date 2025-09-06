
--Task-1

SELECT O.OrderID, C.FirstName,O.OrderDate FROM Orders AS O JOIN Customers AS C ON C.CustomerID=O.CustomerID 

WHERE OrderDate > '2022-12-31'

--Task-2

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID WHERE D.DepartmentName IN('Sales', 'Marketing')

--Task-3

SELECT D.DepartmentName, MAX(E.Salary) AS max_salary FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID GROUP BY D.DepartmentName

--Task-4

SELECT C.FirstName, O.OrderID, O.OrderDate FROM Customers AS C JOIN Orders AS O ON C.CustomerID=O.CustomerID

WHERE C.Country = 'USA' AND O.OrderDate BETWEEN '2023-01-01' AND '2023-12-31'

--Task-5

SELECT C.FirstName, COUNT(O.OrderID) AS total_o FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID=O.CustomerID GROUP BY C.FirstName

--Task-6

SELECT P.ProductName, S.SupplierName FROM Products AS P JOIN Suppliers AS S 

ON S.SupplierID=P.SupplierID WHERE S.SupplierName IN ('Gadget Supplies', 'Clothing Mart')

--Task-7

SELECT C.FirstName, MAX(O.OrderDate) AS MostRecentOrderDate FROM Customers AS C LEFT JOIN Orders AS O 

ON C.CustomerID=O.CustomerID GROUP BY C.FirstName 

--Task-8

SELECT C.FirstName, SUM(O.TotalAmount) AS OrderTotal FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID = O.CustomerID  GROUP BY C.FirstName HAVING SUM(O.TotalAmount) > 500

--Task-9

SELECT P.ProductName, S.SaleDate, S.SaleAmount FROM Products AS P JOIN Sales AS S 

ON P.ProductID = S.ProductID WHERE S.SaleDate BETWEEN '2022-01-01' AND '2022-12-31' OR S.SaleAmount > 400

--Task-10

SELECT P.ProductName, SUM(S.SaleAmount) AS TotalSalesAmount FROM Products AS P LEFT JOIN Sales AS S 

ON P.ProductID = S.ProductID GROUP BY P.ProductName

--Task-11

SELECT E.Name, D.DepartmentName, E.Salary FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID = D.DepartmentID WHERE D.DepartmentName = 'HR' AND E.Salary > 60000

--Task-12

SELECT P.ProductName, S.SaleDate, P.StockQuantity FROM Products AS P JOIN Sales AS S 

ON S.ProductID=P.ProductID WHERE S.SaleDate BETWEEN '2023-01-01' AND '2023-12-31' AND P.StockQuantity > 100

--Task-13

SELECT E.Name, D.DepartmentName, E.HireDate FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID WHERE D.DepartmentName = 'Sales' OR E.HireDate > '2020-12-31'

--Task-14

SELECT C.FirstName, O.OrderID, C.Address, O.OrderDate FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID=O.CustomerID WHERE C.Country = 'USA' AND C.Address LIKE '[0-9][0-9][0-9][0-9]%'

--Task-15

SELECT * FROM Products AS P JOIN Sales AS S

ON P.ProductID=S.ProductID WHERE P.Category = 'Electronics' OR S.SaleAmount > 350

--Task-16

SELECT C.CategoryName, COUNT(P.ProductID) AS ProductCount FROM Products AS P RIGHT JOIN Categories AS C 

ON C.CategoryID = P.Category GROUP BY C.CategoryName

--Task-17

SELECT C.FirstName, C.City, O.OrderID, O.TotalAmount FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID = O.CustomerID WHERE C.City = 'Los Angeles' AND O.TotalAmount > 300

--Task-18

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID = D.DepartmentID WHERE D.DepartmentName IN ('HR', 'Finance') OR
      
	  ( LENGTH  (  REGEXP_REPLACE(LOWER(e.EmployeeName), '[^aeiou]', '', 'g')
        ) >= 4  )

--Task-19

SELECT E.Name, D.DepartmentName, E.Salary FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID = D.DepartmentID WHERE D.DepartmentName IN ('Sales', 'Marketing') AND E.Salary > 60000



