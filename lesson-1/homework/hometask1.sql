--Task 1. 

Data is any piece of information. For example it can be like numbers, names, texts, videos or pictures. 

Database is a place where data is stored and organised so it can be esily managed, accessed and updated.

Relational database stores data in a structured way, using tables and links related data together.

Table is like a spreadsheets or a chart inside a database. It has rows and columns.

  --Task 2. 

  1. Tables for Storing Data 

  2. SQL Language for Asking Questions 

  3. Relationships Between Tables  
 
  4. Data Protection and Security 
 
  5. Easy Backup and Restore.
 
 Task 3.
 
  1. Windows Authentication mode 
  
  2. SQL Server Authentication mode

 Task 4.
 
  create database SchoolDB

 Task 5.
 
  create table Students (StudentID int PRIMARY KEY, Name varchar(50), Age int)
 
 Task 6.

 SQL is a language, just like English or Spanish - but insted of talking to people, it is used to talk to databases.  

 SQL Server (Microsoft SQL Server) is the actual database system. It stores and manages your data. it is like a powerful warehouse where all your information lives.

 SSMS is the tool(app) that you use to interact with SQL server. it is like a fancy notepad that helps you to write, run and manage your SQL code. 

 Task 7.

 DQL(Data query language) - Focus on querying the data. MAIN COMMAND: SELECT. Example: select * from Students

DML(Data manupulation language) - Used to manipulate data in tables -inserting, updating and delating records. MAIN COMMAND:INSERT, UPDATE, DELETE. 

  Example: insert into Students (StudentID, Name, Age) values (1, 'Ulugbek', 28)

DDL(Data defination language) - used to define and manage table structures, like creating and altering tables.

  Examples: Create table Students (StudentID int, Name varchar(30), Age int)

DCL(Data control language) - Control access to data and permissions. Main Commands: GRANT, REVOKE.

   Examples: GRANT SELECT, UPDATE ON Employees TO user1

TCL(TRANSACTION control language)-Manages transactions (groups of SQL operations) to ensure data consistency.

   Examples: BEGIN TRANSACTION; UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1.

Task 8.

INSERT INTO Students (StudentID, Name, Age) values 
(5, 'ULUGBEK', 28), (6, 'MUQADDAS', 25), (7, 'Karina', 15)

Task 9.

1. Download the Backup File
Obtain the AdventureWorksDW2022.bak file from a reliable source.

Ensure the file is compatible with your SQL Server version.

2. Move the Backup File to the SQL Server Backup Directory
Copy the .bak file to your SQL Server's backup directory.

Common default paths include:

C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup

C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup

Adjust the path based on your SQL Server version and instance name. 

  3. Open SQL Server Management Studio (SSMS)
Launch SSMS and connect to your SQL Server instance.

4. Initiate the Restore Process
In SSMS, right-click on the Databases node in the Object Explorer.

5. Select the Backup File
In the Restore Database window:

Under the Source section, choose Device.

Click the ellipsis (...) button to browse for the backup file.

Click Add, navigate to the backup file location, select the .bak file, and click OK.

6. Configure Restore Options

Check the Options page to configure additional settings, such as overwriting the existing database if it exists.
learningdub.com

7. Start the Restoration
Click OK to begin the restore process.

Monitor the progress and wait for the operation to complete.
B2Analyze

8. Verify the Restoration

  After restoration, expand the Databases node in Object Explorer.

Locate AdventureWorksDW2022 in the list.

Right-click on the database and select New Query.
