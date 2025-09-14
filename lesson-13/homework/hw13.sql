
-- EASY TASKS

--Task-1

SELECT CONCAT(EMPLOYEE_ID, '-', FIRST_NAME,' ', LAST_NAME) AS FULLINFO FROM Employees

--Task-2

UPDATE Employees

SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')

WHERE PHONE_NUMBER LIKE '%124%'

--Task-3

SELECT FIRST_NAME AS FIRST_NA, LEN(FIRST_NAME) AS LFN FROM Employees

WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'

ORDER BY FIRST_NAME

--Task-4

SELECT E.MANAGER_ID, SUM(E.SALARY) AS SUMSALARY FROM Employees AS E

GROUP BY E.MANAGER_ID
	
--Task-5

SELECT * FROM TestMax

SELECT Year1, CASE WHEN Max1 > = Max2 AND  Max1 > = Max3 THEN Max1

WHEN Max2 > = Max1 AND  Max2 > = MAX3 THEN Max2 ELSE Max3 END AS MAXDEGREE FROM TestMax

--Task-6

SELECT * FROM cinema

WHERE id % 2 = 1 AND description NOT LIKE '%boring%'

--Task-7

SELECT * FROM SingleOrder
ORDER BY 
  (CASE WHEN Id = 0 THEN 1 ELSE 0 END) * 1000000 + Id

 --Task-8

 SELECT COALESCE(id, ssn, passportid, itin, 'null') AS FIRSTNULL FROM Person

 --MEDIUM TASKS

 --Task-1

 SELECT StudentID, LEFT(FullName, (CHARINDEX(' ', FullName ) - 1)) AS FirstNAME, 
 
 SUBSTRING(FullName, CHARINDEX(' ', FullName ) + 1, 
 
 CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1 ) - CHARINDEX(' ', FullName )- 1)  AS MiddleNAME,
 
 RIGHT(FullName, (LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1 )) ) 
 
 AS LastName, Grade FROM Students;

 --Task-2

 SELECT * FROM Orders

 WHERE DeliveryState = 'TX' AND CustomerID IN (SELECT DISTINCT CustomerID FROM Orders

 WHERE DeliveryState = 'CA');

  --Task-3

SELECT STRING_AGG(String, ' ') WITHIN GROUP 

(ORDER BY SequenceNumber) AS FullQuery

FROM DMLTable;

  --Task-4

SELECT * FROM Employees

WHERE LEN(CONCAT(FIRST_NAME, LAST_NAME)) - LEN(REPLACE(CONCAT(FIRST_NAME, LAST_NAME), 'a', '')) >=3

--Task-5

SELECT * FROM Employees

SELECT 
  DEPARTMENT_ID,
  COUNT(*) AS TotalEmployees,
  SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS EmployeesOver3Years,
  ROUND(
    100.0 * SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS PercentageOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

--Task-6

WITH RankedExperience AS (
  SELECT 
    JobDescription,
    SpacemanID,
    MissionCount,
    RANK() OVER (PARTITION BY JobDescription ORDER BY MissionCount DESC) AS MostExperiencedRank,
    RANK() OVER (PARTITION BY JobDescription ORDER BY MissionCount ASC) AS LeastExperiencedRank
  FROM Personal
)
SELECT 
  JobDescription,
 
 MAX(CASE WHEN MostExperiencedRank = 1 THEN SpacemanID END) AS MostExperiencedID,
  MAX(CASE WHEN LeastExperiencedRank = 1 THEN SpacemanID END) AS LeastExperiencedID

FROM RankedExperience
GROUP BY JobDescription;

Difficult Tasks

--Task-1

-- Declare the string
DECLARE @str NVARCHAR(100) = 'tf56sd#%OqH';

-- Create a tally table (numbers 1 to length of the string)
WITH Numbers AS (
    SELECT TOP (LEN(@str))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects -- use a large system table to generate enough rows
),
Chars AS (
    SELECT 
        SUBSTRING(@str, n, 1) AS char
    FROM Numbers
),
Classified AS (
    SELECT
        char,
        CASE
            WHEN ASCII(char) BETWEEN 65 AND 90 THEN 'uppercase'
            WHEN ASCII(char) BETWEEN 97 AND 122 THEN 'lowercase'
            WHEN ASCII(char) BETWEEN 48 AND 57 THEN 'number'
            ELSE 'special'
        END AS category
    FROM Chars
)
SELECT
    STRING_AGG(CASE WHEN category = 'uppercase' THEN char END, '') AS uppercase_letters,
    STRING_AGG(CASE WHEN category = 'lowercase' THEN char END, '') AS lowercase_letters,
    STRING_AGG(CASE WHEN category = 'number' THEN char END, '') AS numbers,
    STRING_AGG(CASE WHEN category = 'special' THEN char END, '') AS special_characters
FROM Classified;

--Task-2

SELECT * FROM Students

SELECT 
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotal
FROM Students;

--Task-3

SELECT * FROM Equations

-- Declare variables
DECLARE @Equation VARCHAR(200), 
        @SQL NVARCHAR(300), 
        @Result INT;

-- Cursor to go through each equation
DECLARE eq_cursor CURSOR FOR
SELECT Equation FROM Equations;

OPEN eq_cursor;
FETCH NEXT FROM eq_cursor INTO @Equation;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        -- Build dynamic SQL to evaluate the expression
        SET @SQL = N'SET @ResultOut = ' + @Equation;

        -- Execute and capture result
        EXEC sp_executesql 
            @SQL, 
            N'@ResultOut INT OUTPUT', 
            @ResultOut = @Result OUTPUT;

        -- Update the result into the table
        UPDATE Equations
        SET TotalSum = @Result
        WHERE Equation = @Equation;
    END TRY
    BEGIN CATCH
        -- Optional: Handle errors (e.g., invalid expressions)
        UPDATE Equations
        SET TotalSum = NULL
        WHERE Equation = @Equation;
    END CATCH;

    FETCH NEXT FROM eq_cursor INTO @Equation;
END

CLOSE eq_cursor;
DEALLOCATE eq_cursor;

-- Final result
SELECT * FROM Equations;

--Task-4

SELECT * FROM Student AS S1 JOIN Student AS S2 

ON S1.Birthday = S2.Birthday AND S2.StudentName > S1.StudentName

--Task-5

SELECT

    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
   
   SUM(Score) AS TotalScore

FROM PlayerScores

GROUP BY

    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;



