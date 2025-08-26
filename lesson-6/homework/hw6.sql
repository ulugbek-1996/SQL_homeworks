    --TASK-1

--Approach-1: 

SELECT DISTINCT col1, col2 FROM InputTbl

--Approach-2: 

SELECT DISTINCT

CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,

CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2 FROM InputTbl

--TASK-2

--Approach-1: 

SELECT * FROM TestMultipleZero

WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0)

--Approach-2:

SELECT * FROM TestMultipleZero

WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0

--TASK-3

SELECT * FROM section1

WHERE id % 2 = 1

--TASK-4

SELECT TOP 1 * FROM section1

ORDER BY id ASC

--TASK-5

SELECT TOP 1 * FROM section1

ORDER BY id DESC

--TASK-6

SELECT * FROM section1

WHERE name LIKE 'B%'

--TASK-7

SELECT * FROM ProductCodes

WHERE Code LIKE '%[_]%'

