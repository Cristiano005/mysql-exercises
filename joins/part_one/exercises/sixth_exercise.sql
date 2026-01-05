SELECT * FROM departments;

SELECT * FROM employees;

SELECT department.name, employee.name FROM departments department 
    LEFT JOIN employees employee
        ON employee.department_id = department.id