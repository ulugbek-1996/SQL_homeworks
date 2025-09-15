--Easy Tasks

--Task-1

SELECT * FROM TestMultipleColumns

SELECT Id,
    LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS FirstName,
    LTRIM(RTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name)))) AS LastName
FROM TestMultipleColumns;

--Task-2

SELECT * FROM TestPercent

WHERE Strs LIKE '%[%]%'

--Task-3

SELECT 
    s.Id,
    s.Vals,
    ss.value AS SplitPart
FROM Splitter s
CROSS APPLY STRING_SPLIT(s.Vals, '.') ss
 
 --Task-4

SELECT 
    '1234ABC123456XYZ1234567890ADS' AS OriginalString,
    REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE(
        REPLACE('1234ABC123456XYZ1234567890ADS', '0', 'X')
    , '1', 'X')
    , '2', 'X')
    , '3', 'X')
    , '4', 'X')
    , '5', 'X')
    , '6', 'X')
    , '7', 'X')
    , '8', 'X')
    , '9', 'X') AS ReplacedString

 --Task-5

 SELECT * FROM testDots

 WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2

 --Task-6

 SELECT *, (LEN(texts) - LEN(REPLACE(texts, ' ', ''))) AS NUM_SPA FROM CountSpaces

 --Task-7

 SELECT E1.Name FROM Employee AS E1 JOIN Employee AS E2 

 ON E1.ManagerId = E2.Id WHERE E1.Salary > E2.Salary

 --Task-8

 SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_of_Service  
 
 FROM Employees WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10 AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 15

 --Medium Tasks

 --Task-1

 DECLARE @input NVARCHAR(100) = 'rtcfvty34redt'; 

WITH Tally (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM Tally
    WHERE n + 1 <= LEN(@input)
),
SplitChars AS (
    SELECT 
        n,
        SUBSTRING(@input, n, 1) AS ch
    FROM Tally
),
Separated AS (
    SELECT
        ch,
        CASE 
            WHEN ch LIKE '[0-9]' THEN 'digit'
            WHEN ch LIKE '[a-zA-Z]' THEN 'char'
            ELSE 'other'
        END AS ch_type
    FROM SplitChars
)
SELECT
    (SELECT STRING_AGG(ch, '') FROM Separated WHERE ch_type = 'char') AS characters,
    (SELECT STRING_AGG(ch, '') FROM Separated WHERE ch_type = 'digit') AS digits;

--Task-2

SELECT  WK.Id FROM weather AS WO JOIN weather AS WK 

ON DATEADD(DAY, -1, WK.RecordDate)  = WO.RecordDate 

WHERE WO.Temperature < WK.Temperature

--Task-3

SELECT * FROM Activity

SELECT player_id, MIN(event_date) AS FIRST_DATE FROM Activity

GROUP BY player_id 

--Task-4

WITH SplitFruit AS (
    SELECT 
        value,
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM 
        fruits
        CROSS APPLY STRING_SPLIT(fruit_list, ',')
)
SELECT value AS third_fruit
FROM SplitFruit
WHERE rn =. 3;

--Task-5

CREATE TABLE Characters (
    CharPosition INT PRIMARY KEY,
    Character NVARCHAR(1)
);

DECLARE @str NVARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Tally (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM Tally WHERE n + 1 <= LEN(@str)
)
INSERT INTO Characters (CharPosition, Character)
SELECT n, SUBSTRING(@str, n, 1)
FROM Tally
OPTION (MAXRECURSION 0);

--Task-6

SELECT p1.id, CASE WHEN P1.code = 0 THEN P2.code ELSE p1.code

END AS P1_CODE, P2.id, P2.code FROM p1 JOIN p2 ON p1.id = P2.id

--Task-7

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, 

CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'

WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior' 

WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'Mid-Level' 

WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 19 THEN 'Senior'

ELSE 'Veteran' END AS EMP_STAGE FROM Employees

--Task-8

SELECT * FROM GetIntegers

SELECT Id, VALS, LEFT(VALS, PATINDEX('%[^0-9]%', VALS + 'X') - 1) AS STARINTEG FROM GetIntegers

WHERE VALS LIKE '[0-9]%'

--Difficult Tasks

--Task-1

SELECT 
    Id,
    STRING_AGG(
        CASE 
            WHEN LEN(Item) >= 2 THEN 
                SUBSTRING(Item, 2, 1) + 
                SUBSTRING(Item, 1, 1) + 
                SUBSTRING(Item, 3, LEN(Item))
            ELSE 
                Item
        END,
        ','
    ) AS SwappedVals
FROM (
    SELECT 
        m.Id,
        TRIM(value) AS Item
    FROM MultipleVals m
    CROSS APPLY (
        SELECT CAST('<x>' + 
                    REPLACE(m.Vals, ',', '</x><x>') + 
                    '</x>' AS XML) AS XmlData
    ) AS A
    CROSS APPLY (
        SELECT x.value('.', 'VARCHAR(100)') AS value
        FROM XmlData.nodes('/x') AS T(x)
    ) AS B
) AS SplitData
GROUP BY Id;

--Task-2

SELECT a.player_id, a.device_id
FROM Activity a
JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) firsts
  ON a.player_id = firsts.player_id AND a.event_date = firsts.first_login;

--Task-3

SELECT * FROM WeekPercentagePuzzle

	WITH CleanedData AS (
    SELECT
        Area,
        [Date],
        ISNULL(SalesLocal, 0) + ISNULL(SalesRemote, 0) AS TotalSales,
        FinancialWeek,
        FinancialYear,
        DayName
    FROM WeekPercentagePuzzle),

WeeklyTotals AS (
    SELECT
        FinancialWeek,
        FinancialYear,
        SUM(TotalSales) AS WeeklyTotalSales
    FROM CleanedData
    GROUP BY FinancialWeek, FinancialYear
),
AreaDailySales AS (
    SELECT
        Area,
        [Date],
        FinancialWeek,
        FinancialYear,
        DayName,
        SUM(TotalSales) AS AreaDaySales
    FROM CleanedData
    GROUP BY Area, [Date], FinancialWeek, FinancialYear, DayName
)
SELECT
    a.FinancialYear,
    a.FinancialWeek,
    a.DayName,
    a.Area,
    a.AreaDaySales,
    w.WeeklyTotalSales,
    ROUND(
        (CAST(a.AreaDaySales AS FLOAT) / NULLIF(w.WeeklyTotalSales, 0)) * 100, 2
    ) AS PercentageOfWeek
FROM AreaDailySales a
JOIN WeeklyTotals w
  ON a.FinancialWeek = w.FinancialWeek
 AND a.FinancialYear = w.FinancialYear
ORDER BY a.FinancialYear, a.FinancialWeek, a.DayName, a.Area;






