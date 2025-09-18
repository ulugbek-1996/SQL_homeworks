--Task-1

SELECT * FROM employees

WHERE salary = (SELECT MIN(salary) FROM employees)

--Task-2

SELECT * FROM products

WHERE price > (SELECT AVG(price) FROM products)

--TASK-3

SELECT id, name FROM employees 

WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales')

--Task-4

SELECT * FROM customers

WHERE customer_id NOT IN (SELECT customer_id FROM orders)

--Task-5

SELECT * FROM products AS P1

WHERE price = (SELECT MAX(price) FROM products AS P2 WHERE P1.category_id = P2.category_id)

--Task-6

SELECT id, name, (SELECT department_name FROM departments AS D WHERE D.id = E.department_id) AS DepartName

FROM employees AS E

WHERE department_id = (SELECT id FROM departments WHERE id = (SELECT TOP 1 department_id FROM

(SELECT department_id,  AVG(salary) as avg_salary FROM employees

GROUP BY department_id) AS dept_avg

ORDER BY avg_salary DESC))

--Task-7

SELECT * FROM employees AS E1

WHERE salary > (SELECT AVG(salary) FROM employees AS E2 WHERE E1.department_id = E2.department_id)

--Task-8

SELECT sudent_id, course_id, (SELECT name FROM students 

WHERE students.sudent_id = grades.sudent_id) AS Name, grade  FROM grades

WHERE grade = (SELECT MAX(grade) FROM grades G1 WHERE G1.course_id = grades.course_id)

--Task-9

SELECT * FROM products AS P1

WHERE 2 = (SELECT COUNT(DISTINCT P2.price) FROM products AS P2

WHERE P1.category_id = P2.category_id AND P2.price > P1.price)
 
 --Task-10

SELECT * FROM employees

WHERE salary BETWEEN (SELECT AVG(salary) FROM employees) AND (SELECT MAX(salary) FROM employees AS E1

WHERE E1.department_id = employees.department_id)



