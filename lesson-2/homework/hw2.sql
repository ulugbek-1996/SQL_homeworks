--Task-1

Create table Employees(EmpID int, Name varchar(50), Salary decimal(10, 2))

Select * from Employees 

--Task-2

--Single-row insert

Insert into Employees values (2, 'Ulug''bek', 1042735.45)

--Multiple-row insert

Insert into Employees values (3, 'Diyorbek', 9875634.865), 

(4, 'Ahmadbek', 12589731.85), (5, 'Vohobjon', 17895746.31)

--Task-3

Update Employees

Set salary = 7000

Where EmpID = 1

--Task-4

Delete from Employees

Where EmpID = 2

--Task-5

DELETE – deletes specified rows from a table using a WHERE clause.

TRUNCATE – removes all rows from a table without logging individual deletions.

DROP – deletes the entire table, including its structure and data. 

--Task-6

alter table Employees 

alter column Name varchar(100)

--Task-7

alter table Employees 

add Department VARCHAR(50)

--Task-8

alter table Employees

alter column salary float

--Task-9

create table Departments(DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))

select * from Departments

--Task-10

truncate table Employees

 --Task-11

 INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT *
FROM (VALUES
    (1, 'Electronics'),
    (2, 'Clothing'),
    (3, 'Home & Kitchen'),
    (4, 'Toys'),
    (5, 'Books')
) AS Dept(DepartmentID, DepartmentName)
 
 
 --Task-12

 update Employees 

 set Department = 'Management'

 where Salary > 5000

 --Task-13

 truncate Employees table

 --Task-14

 alter table Employees

 drop column Department

 --Task-15

exec sp_rename 'Staf_members', 'StaffMembers'

 --Task-16

 DROP table Departments

  --Task-17

  create table Products (ProductID int Primary Key, ProductName varchar(100), 
  
  Category varchar(100), Price decimal(10,2), ProductNum int)  

  --Task-18

  alter table Products 

  add constraint ch_Prise_Positive Check (Price > 0)

  --Task-19

  alter table Products

  add StockQuantity int default 50

  --Task-20

  exec sp_rename 'Products.Category', 'ProductCategory', 'column' 

  --Task-21

  insert into Products 

  values (1, 'computer', 'Technical', 6000000.23, 27), (2, 'meat', 'Food', 195804.245, 13), (3, 'Book', 'Paper', 45000, 32),

  (4, 'boots', 'Shoes', 300000.56, 4), (5, 'cap', 'Drees', 43000, 51)

  --Task-22

  select * into Products_Backup

  from Products

  --Task-23

   exec sp_rename 'Products', 'Inventory'

  --Task-24

  alter table Inventory
 
 alter column Price float 

  --Task-25

  SELECT 
    IDENTITY(INT, 1000, 5) AS ProductCode,
    *
INTO Inventory_New FROM Inventory

DROP TABLE Inventory

exec sp_rename 'Inventory_New', 'Inventory'




