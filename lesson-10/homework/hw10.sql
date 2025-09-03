
--TASK-1

SELECT E.Name, E.Salary, D.DepartmentName FROM Employees AS E JOIN Departments AS D ON E.DepartmentID=D.DepartmentID

WHERE E.Salary > 50000

--TASK-2

SELECT C.FirstName, C.LastName, O.OrderDate FROM Customers AS C JOIN Orders AS O ON C.CustomerID=O.CustomerID

WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'

--TASK-3

SELECT E.Name, D.DepartmentName FROM Employees AS E LEFT JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID

--TASK-4

SELECT S.SupplierName, P.ProductName FROM Products AS P RIGHT JOIN Suppliers AS S 

ON P.SupplierID=S.SupplierID

--TASK-5

SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount FROM Orders AS O 

FULL JOIN Payments AS P ON O.OrderID=P.OrderID

--TASK-6

SELECT E1.Name AS EmployeeName, E2.Name AS ManagerName FROM Employees AS E1 LEFT JOIN Employees AS E2

ON E1.ManagerID=E2.EmployeeID

--TASK-7

SELECT S.Name, C.CourseName FROM Enrollments AS E JOIN Students AS S ON E.StudentID=S.StudentID 

JOIN Courses AS C ON E.CourseID=C.CourseID WHERE C.CourseName = 'Math 101'

--TASK-8

SELECT C.FirstName, C.LastName, O.Quantity FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID=O.CustomerID WHERE O.Quantity > 3

--TASK-9 

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID WHERE D.DepartmentName = 'Human Resources'

--TASK-10

SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID GROUP BY D.DepartmentName HAVING COUNT(E.EmployeeID) > 5

--TASK-11

SELECT P.ProductID, P.ProductName FROM Products AS P LEFT JOIN Sales AS S 

ON P.ProductID=S.ProductID WHERE S.ProductID IS NULL

--TASK-12

SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders FROM Customers AS C JOIN Orders AS O 

ON C.CustomerID=O.CustomerID GROUP BY C.FirstName, C.LastName HAVING COUNT(O.OrderID)>= 1

--TASK-13

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID

--TASK-14

SELECT E1.Name AS Employee1, E2.Name AS Employee1, E1.ManagerID FROM Employees AS E1 

JOIN Employees AS E2 ON E1.ManagerID=E2.ManagerID WHERE E1.EmployeeID < E2.EmployeeID AND E1.ManagerID IS NOT NULL

--TASK-15

SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName  FROM Orders AS O JOIN Customers AS C 

ON O.CustomerID=C.CustomerID WHERE O.OrderDate BETWEEN '2022-01-01' AND '2022-12-31'

--TASK-16

SELECT E.Name, E.Salary, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID WHERE E.Salary > 60000 AND D.DepartmentName = 'Sales'

--TASK-17

SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount FROM Orders AS O INNER JOIN Payments AS P 

ON O.OrderID=P.OrderID 

--TASK-18

SELECT P.ProductID, P.ProductName FROM Products AS P LEFT JOIN Orders AS O 

ON P.ProductID=O.ProductID WHERE O.OrderID IS NULL

--TASK-19

SELECT  E.Name, E.Salary FROM Employees AS E

WHERE E.Salary > (SELECT AVG(E2.Salary) FROM Employees AS E2 WHERE E.DepartmentID=E2.DepartmentID)

--TASK-20

SELECT O.OrderID, O.OrderDate FROM Orders AS O LEFT JOIN Payments AS P

ON O.OrderID=P.OrderID WHERE O.OrderDate < '2022-01-01' AND P.OrderID IS NULL

--TASK-21

SELECT * FROM Products AS P LEFT JOIN Categories AS C 

ON P.Category=C.CategoryID WHERE C.CategoryID IS NULL

--TASK-22

SELECT E1.Name AS Employee1, E2.Name AS Employee1, E1.ManagerID, E1.Salary FROM Employees AS E1 

JOIN Employees AS E2 ON E1.ManagerID=E2.ManagerID AND E1.EmployeeID < E2.EmployeeID 

WHERE E1.Salary > 60000 AND E2.Salary>60000

--TASK-23

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D ON E.DepartmentID=D.DepartmentID

WHERE D.DepartmentName LIKE 'M%'

--TASK-24

SELECT S.SaleID, P.ProductName, S.SaleAmount FROM Products AS P JOIN Sales AS S 

ON P.ProductID=S.ProductID WHERE S.SaleAmount > 500

--TASK-25

SELECT S.StudentID, S.Name FROM Students AS S LEFT JOIN Enrollments AS E ON S.StudentID = E.StudentID 

LEFT JOIN Courses AS C ON C.CourseID = E.CourseID AND C.CourseName = 'Math 101' WHERE C.CourseID IS NULL

--TASK-26

SELECT O.OrderID, O.OrderDate, P.PaymentID FROM Orders AS O LEFT JOIN Payments AS P 

ON O.OrderID=P.OrderID WHERE P.OrderID IS NULL

--TASK-27

SELECT P.ProductID, P.ProductName, C.CategoryName FROM Products AS P JOIN Categories AS C 

ON P.Category = C.CategoryID WHERE C.CategoryName IN('Electronics', 'Furniture')


