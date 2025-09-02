--Task-1

SELECT ProductName, SupplierName FROM Products AS prod

JOIN Suppliers AS supp

ON prod.SupplierID = supp.SupplierID

--Task-2

SELECT DepartmentName, Name FROM Departments AS depar

JOIN Employees AS Emp

ON depar.DepartmentID = Emp.DepartmentID

--Task-3

SELECT prod.ProductName, supp.SupplierName FROM Suppliers  AS supp 

JOIN Products AS prod

ON prod.SupplierID = supp.SupplierID

--Task-4

SELECT cust.FirstName, ord.OrderID FROM Customers AS cust

JOIN Orders AS ord ON cust.CustomerID = ord.CustomerID

--Task-5

SELECT stu.Name, cour.CourseName FROM Students as stu

CROSS JOIN Courses AS cour

--Task-6

select * from Products

select * from Orders

SELECT prod.ProductName, ord.OrderID FROM Products AS prod

JOIN Orders AS ord ON prod.ProductID=ord.ProductID

--Task-7

SELECT emp.Name, dep.DepartmentName  FROM Employees AS emp

JOIN Departments AS dep ON emp.DepartmentID=dep.DepartmentID

--Task-8

SELECT stu.Name, enrol.CourseID FROM Students AS stu

JOIN Enrollments AS enrol ON stu.StudentID=enrol.StudentID

--Task-9

SELECT pay.PaymentID, ord.OrderID FROM Payments AS pay

JOIN Orders AS ord ON pay.OrderID = ord.OrderID

--Task-10

SELECT o.OrderID, p.ProductName, p.Price FROM Orders AS o

JOIN Products AS p ON o.ProductID=p.ProductID

WHERE p.Price > 100

--Task-11

SELECT E.Name, D.DepartmentName FROM Employees AS E 

JOIN Departments AS D ON E.DepartmentID ! = D.DepartmentID

--Task-12

SELECT O.OrderID, O.Quantity, P.StockQuantity FROM Orders AS O 

JOIN Products AS P ON O.ProductID=P.ProductID

WHERE O.Quantity > P.StockQuantity

--Task-13

SELECT C.FirstName, S.ProductID FROM Customers AS C 

JOIN Sales AS S ON C.CustomerID=S.CustomerID

WHERE S.SaleAmount >= 500

--Task-14

SELECT S.Name, C.CourseName FROM Students AS S JOIN Enrollments AS E ON S.StudentID = E.StudentID

JOIN Courses AS C ON E.CourseID = C.CourseID 

--Task-15

SELECT P.ProductName, S.SupplierName FROM Products AS P JOIN Suppliers AS S 

ON P.SupplierID = S.SupplierID

WHERE S.SupplierName LIKE '%Tech%'

--Task-16

SELECT O.OrderID FROM Orders AS O JOIN Payments AS P

ON O.OrderID=P.OrderID

WHERE P.Amount < O.TotalAmount

--Task-17

SELECT E.Name, D.DepartmentName FROM Employees AS E JOIN Departments AS D 

ON E.DepartmentID=D.DepartmentID

--Task-18

SELECT P.ProductName, C.CategoryName

FROM Products AS P JOIN Categories AS C

ON P.Category=C.CategoryID WHERE C.CategoryName IN('Electronics', 'Furniture')

--Task-19

SELECT S.SaleID FROM Sales AS S JOIN  Customers AS C 

ON C.CustomerID=S.CustomerID 

WHERE C.Country = 'USA'

--Task-20

SELECT O.OrderID FROM  Orders AS O JOIN Customers AS C

ON C.CustomerID = O.CustomerID

WHERE C.Country = 'Germany' AND O.TotalAmount > 100

--Task-21

SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.DepartmentID AS Dept1,
    e2.DepartmentID AS Dept2
FROM 
    Employees AS e1
JOIN 
    Employees AS e2
ON 
    e1.EmployeeID <> e2.EmployeeID
    AND e1.DepartmentID <> e2.DepartmentID;

--Task-22

SELECT P.PaymentID, P.OrderID, P.PaymentDate, P.PaymentMethod,  P.Amount, O.Quantity, PR.Price 

FROM Orders AS O JOIN Payments AS P ON O.OrderID=P.OrderID 

JOIN Products AS PR ON O.ProductID=PR.ProductID 

WHERE P.Amount <> (O.Quantity*PR.Price)

--Task-23

SELECT S.StudentID, S.Name FROM Students AS S LEFT JOIN Enrollments AS E ON S.StudentID=E.StudentID

 LEFT JOIN Courses AS C ON E.CourseID=C.CourseID

WHERE S.StudentID IS NULL

--Task-24

	SELECT  e2.EmployeeID AS ManagerID,  e2.Name AS Manager, e2.Salary AS Man_Sal

	FROM Employees AS e1 JOIN Employees AS e2 ON e1.EmployeeID = e2.ManagerID 

	WHERE e1.Salary >= e2.Salary

--Task-25

SELECT C.CustomerID, C.FirstName, C.LastName FROM Orders AS O LEFT JOIN Payments AS P ON O.OrderID=P.OrderID 

JOIN Customers AS C ON C.CustomerID=O.CustomerID WHERE P.PaymentID IS NULL
