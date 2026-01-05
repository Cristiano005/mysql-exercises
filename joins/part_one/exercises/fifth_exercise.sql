SELECT * FROM employees;

SELECT * FROM departments

SELECT employee.name, department.name FROM employees employee 
    INNER JOIN departments department  
        ON department.id = employee.department_id