--Task-1

BULK INSERT is a transact SQL command in SQL server used to import a large volume of data from a data file( such us a .txt, .csv or .dat file) into SQL server table or view efficiently.

Syntax Overview

BULK INSERT [schema_name.]table_name
FROM 'data_file_path'
WITH (
    [FORMAT = 'CSV' | 'TEXT'],
    FIELDTERMINATOR = 'field_separator',
    ROWTERMINATOR = 'row_separator',
    FIRSTROW = starting_row_number,
    ...).

--Task-2

1. CSV (Comma-Separated Values)

One of the most common formats. Data fields are separated by commas.

Example: data.csv

2. TXT (Plain Text)

Typically used with custom delimiters like tabs (\t) or pipes (|).

Example: data.txt

3. XLS/XLSX (Microsoft Excel Files)

Excel spreadsheets can be imported using tools like the Import Wizard, SSIS, or OPENROWSET.

Example: data.xlsx

4. XML (Extensible Markup Language)

Used for structured data and can be imported using SQL Server’s XML features or bulk load operations.

Example: data.xml

--Task-3

Create table Products (ProductID int PRIMARY KEY, ProductName varchar(50), Price decimal(10,2)) 

select * from Products

--Task-4

INSERT INTO Products VALUES (1, 'Melon', 35869.34), (2, 'Watermelon', 43869.34), (3, 'Sugar', 23748.28)

--Task-5

NULL

Meaning:
Represents the absence of a value or unknown/missing data in a database column.

Behavior:
Indicates that no data has been entered for that field.

It’s not the same as zero, empty string, or any default value — it literally means "no value."

Example:
If a MiddleName column is NULL for a person, it means you don’t know or the person doesn’t have a middle name (or it’s just not provided).

NOT NULL

Meaning:
Indicates that a column must always have a value — it cannot be left empty.

Behavior:

When you define a column as NOT NULL, SQL Server will reject any insert or update that tries to put a NULL value in that column.

Ensures data integrity by making certain fields mandatory.

Example:
If the LastName column is NOT NULL, every row must have a last name; you can’t insert a record without it.

--Task-6

ALTER TABLE Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE(ProductName)

--Task-7

--Add a UNIQUE CONSTRAINT to unsure that no two products have the same name.

--Task-8

ALTER TABLE Products

ADD CategoryID INT

--Task-9

CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(100) UNIQUE)

--Task-10

The IDENTITY column is used to generate automotically unique numeric values for a column, typically used as a primary key.

--Task-11

BULK INSERT Products	
FROM 'D:\VIBRATION- 2024\Secondary calibration\Protoc. acceleration.txt'
WITH (ROWTERMINATOR = '\n', FIELDTERMINATOR = ',',  FIRSTROW = 2)

--Task-12

ALTER TABLE Products

ADD CONSTRAINT FK_Products_Categories

FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)


--Task-13

Both PRIMARY KEY and UNIQUE KEY are used in SQL to enforce uniqueness, but they have some key differences in behavior and purpose.

1. PRIMARY KEY

Ensures uniqueness of values and disallows NULLs.

There can be only one PRIMARY KEY per table.

Usually used as the main identifier for a record (e.g., ProductID).

Automatically creates a clustered index (by default, if not already present).

2. UNIQUE KEY (UNIQUE CONSTRAINT)

Ensures uniqueness, but allows one or more NULLs (depending on the database system).

A table can have multiple UNIQUE constraints.

Typically used for enforcing business rules like "Product names must be unique".

--Task-14

ALTER TABLE Products

ADD CONSTRAINT CHK_Products_Price_Positive

CHECK (Price > 0)

--Task-15

ALTER TABLE Products

ADD Stock INT NOT NULL DEFAULT 0

--Task-16

SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price, Stock
FROM Products;

--Task-17

A FOREIGN KEY constraint is used to enforce referential integrity between two tables in a relational database. It ensures that the value in a column (or a group of columns) in one table matches a value in a primary key column (or a unique key) in another table.

In simple terms:

It ensures that relationships between tables remain valid.

It prevents invalid data from being inserted into the foreign key column.

Usage and Behavior:

When you insert a record into Orders, the CustomerID must already exist in the Customers table.

You cannot delete a customer from the Customers table if they have orders in the Orders table (unless you define ON DELETE behavior).

You can specify actions for updates or deletions:

ON DELETE CASCADE – deletes dependent rows automatically

ON DELETE SET NULL – sets foreign key value to NULL

ON UPDATE CASCADE – updates foreign key if primary key changes.

Benefits:

Maintains data integrity across tables.

Reduces risk of orphaned records (e.g., orders with no matching customer).

Enforces rules automatically, reducing need for manual checks in code.

--Task-18

CREATE TABLE Customers	( CustomerID INT PRIMARY KEY, CustomerName VARCHAR(100) NOT NULL, 

Age INT NOT NULL, CHECK (Age > 18) )

--Task-19

CREATE TABLE Metrology (ID INT IDENTITY(100,10) PRIMARY KEY, NAME VARCHAR(100) NOT NULL)

--Task-20

CREATE TABLE OrderDetails (OrderID INT NOT NULL, NAME VARCHAR(50) NOT NULL, ProductID INT NOT NULL,  
 
 Price DECIMAL(12, 3) NOT NULL, PRIMARY KEY  (OrderID, ProductID))

 --Task-21

 Both COALESCE and ISNULL are used in SQL Server to handle NULL values, but they have different behaviors and use cases.

 ISNULL(expression, replacement_value)
How it works:

Returns expression if it’s not NULL, otherwise returns replacement_value.

Only evaluates two values.

Example:

SELECT ISNULL(Price, 0) AS AdjustedPrice
FROM Products;
This returns 0 if Price is NULL.

COALESCE() – More Flexible and Standard SQL

Syntax:

COALESCE(expression1, expression2, ..., expressionN)
How it works:

Returns the first non-NULL value from the list of expressions.

Supports multiple expressions.

Standard SQL, so it works across different databases.

Example:

SELECT COALESCE(DiscountPrice, SalePrice, RegularPrice, 0) AS FinalPrice
FROM Products;
This returns the first available (non-NULL) price among the listed columns.

SELECT 
    ISNULL(NULL, 5.5) AS IsNullResult,   -- returns 5 (int, not 5.5)
    COALESCE(NULL, 5.5) AS CoalesceResult -- returns 5.5 (decimal)

In this case, ISNULL returns 5 because it uses the data type of the first argument (NULL is treated as int), while COALESCE evaluates full precedence and keeps it as decimal.

--Task-22

CREATE TABLE Employees (EmpID INT PRIMARY KEY, FirstName VARCHAR(50) NOT NULL, 
LastName VARCHAR(50) NOT NULL,  Email VARCHAR(250) UNIQUE NOT NULL)

--Task-23

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) 
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE )
