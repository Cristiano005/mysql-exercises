SELECT * FROM departments;

SELECT AVG(salary) FROM employees  ;

SELECT AVG(totalEmployeeByDepart) FROM (
    SELECT COUNT(employees.id) AS totalEmployeeByDepart FROM employees GROUP BY department_id
) employee


SELECT department.id AS id, department.name
    FROM departments department
        INNER JOIN employees employee
            ON employee.department_id = department.id 
GROUP BY department.id
HAVING COUNT(employee.id) < 
        (SELECT AVG(totalEmployeeByDepart) FROM (
            SELECT COUNT(employees.id) AS totalEmployeeByDepart 
                FROM employees GROUP BY department_id
        ) employee )
        
        AND AVG(employee.salary) > 
            ( SELECT AVG(salary) FROM employees  
            );
