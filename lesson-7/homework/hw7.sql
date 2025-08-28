--Task-1

SELECT MIN(Price) AS Min_Price FROM Products

--Task-2

SELECT MAX(Salary) AS max_salary FROM Employees

--Task-3

SELECT COUNT(*) AS num_rows FROM Customers

--Task-4

SELECT COUNT(DISTINCT Category) AS unique_category FROM Products

--Task-5

SELECT SUM(SaleAmount) AS sale_7_amount FROM Sales

WHERE ProductID = 7

--Task-6

SELECT AVG(Age) AS avg_age FROM Employees

--Task-7

SELECT DepartmentName, COUNT(EmployeeID) AS num_emp FROM Employees

GROUP BY DepartmentName

--Task-8

SELECT Category, MIN(Price) AS min_price, MAX(Price) AS max_price FROM Products

GROUP BY Category

--Task-9

SELECT CustomerID, SUM(SaleAmount) AS total_sales FROM Sales

GROUP BY CustomerID

--Task-10

SELECT DepartmentName, COUNT(EmployeeID) AS Num_Emp FROM Employees

GROUP BY DepartmentName

HAVING COUNT(EmployeeID) > 5

--Task-11

SELECT ProductID, SUM(SaleAmount) AS sum_sale, AVG(SaleAmount) AS avg_sale FROM Sales

GROUP BY ProductID

--Task-12

SELECT DepartmentName, COUNT(EmployeeID) AS Num_emp FROM Employees

WHERE DepartmentName = 'HR'

GROUP BY DepartmentName

--Task-13

SELECT DepartmentName, MAX(Salary) AS max_salary, MIN(Salary) AS min_salary FROM Employees

GROUP BY DepartmentName

--Task-14

SELECT DepartmentName, AVG(Salary) AS avg_salary FROM Employees

GROUP BY DepartmentName

--Task-15

SELECT DepartmentName, AVG(Salary) AS avg_salary, COUNT(*) AS Num_emp FROM Employees

GROUP BY DepartmentName

--Task-16

SELECT Category, AVG(Price) AS avg_price FROM Products

GROUP BY Category

HAVING AVG(Price) > 400

--Task-17

SELECT SaleDate, SUM(SaleAmount) AS total_AMOUNT FROM Sales

GROUP BY SaleDate

--Task-18

SELECT CustomerID, COUNT(OrderID) AS num_ord FROM Orders

GROUP BY CustomerID

HAVING COUNT(CustomerID) >= 3

--Task-19

SELECT DepartmentName, AVG(Salary) AS avg_salary FROM  Employees

GROUP BY DepartmentName

HAVING AVG(Salary) > 60000

--Task-20

SELECT Category, AVG(Price) AS avg_price FROM Products

GROUP BY Category

HAVING AVG(Price) > 150

--Task-21

SELECT CustomerID, SUM(SaleAmount) AS Total_amount FROM Sales

GROUP BY CustomerID

HAVING SUM(SaleAmount) > 1500

--Task-22

SELECT DepartmentName, SUM(Salary) AS sum_salary, AVG(Salary) AS avg_salary FROM Employees

GROUP BY DepartmentName

HAVING AVG(Salary) > 65000

--Task-23

SELECT * FROM Orders

SELECT CustomerID, SUM(TotalAmount) AS total_orders FROM Orders

GROUP BY CustomerID

HAVING SUM(TotalAmount) > 50 

--Task-24

SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(Quantity) AS total_amount, 

COUNT( DISTINCT ProductID) AS num_product FROM Orders

GROUP BY OrderDate

HAVING SUM(Quantity) >= 2

--Task-25

SELECT YEAR(OrderDate) AS ORDER_YEAR, MAX(Quantity) AS max_quantity, MIN(Quantity) AS min_quantity FROM Orders

GROUP BY YEAR(OrderDate)

ORDER BY ORDER_YEAR

  

ORDER BY ORDER_YEAR
