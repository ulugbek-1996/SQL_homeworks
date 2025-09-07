--TASK-1

SELECT P.firstName, P.lastName, A.city, A.state FROM Person AS P LEFT JOIN Address AS A

ON P.personId = A.personId;

--TASK-2

SELECT E.name AS Employee FROM Employee AS E JOIN Employee AS M ON E.managerId=M.id

WHERE E.salary > M.salary;

--TASK-3

SELECT email AS Email FROM Person 

GROUP BY email HAVING COUNT(email) > 1;

--TASK-4

DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);

--TASK-5

SELECT G.ParentName FROM girls AS G LEFT JOIN boys AS B ON G.ParentName = B.ParentName

WHERE B.Id IS NULL;

--TASK-6

SELECT 
    o.CustomerID,

    SUM(CASE WHEN o.Weight > 50 THEN o.SalesAmount ELSE 0 END) AS TotalSalesAbove50Weight,
    
	MIN(o.Weight) AS LeastOrderWeight

FROM  Sales.Orders o GROUP BY o.CustomerID;

--TASK-7

SELECT ISNULL (C1.Item, '') AS 'Item Cart 1', ISNULL(C2.Item, '') AS 'Item Cart 2'

FROM Cart1 AS C1 FULL JOIN Cart2 AS C2 

ON C1.Item = C2.Item ;

--TASK-8

SELECT C.name AS Customers FROM Customers AS C LEFT JOIN Orders AS O 

ON C.id = O.customerId WHERE O.id IS NULL;

--TASK-9

SELECT ST.student_id, ST.student_name, SUB.subject_name, COUNT(E.subject_name) AS attended_exams

FROM Students AS ST CROSS JOIN Subjects AS SUB LEFT JOIN Examinations AS E 

ON E.student_id=ST.student_id AND E.subject_name = SUB.subject_name 

GROUP BY ST.student_id, ST.student_name, SUB.subject_name ;


