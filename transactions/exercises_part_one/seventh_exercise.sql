CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE salary_adjustment_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10,2) NOT NULL,
    new_salary DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB;

INSERT INTO employees (department_id, salary) VALUES
(1, 2500.00),
(1, 3200.00),
(1, 2800.00),
(2, 4000.00),
(2, 4500.00);

DELIMITER $$

    CREATE PROCEDURE salary_adjustment(IN departmentId INT UNSIGNED, IN newSalary DECIMAL(10,2))

    BEGIN

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            -- Aqui havia colcoado FOR UPDATE, mas era redundante e desnecessário...
            IF EXISTS (SELECT 1 FROM employees WHERE department_id = departmentId) THEN

                INSERT INTO salary_adjustment_logs (employee_id, old_salary, new_salary) SELECT id, salary, newSalary FROM employees WHERE department_id = departmentId;

                -- Isso porque entendi que quando uma tabela é InnoDB, o delete e update já vem com LOCK por padrão
                -- ou seja, eles já bloqueiam outra soperações enquanto realizam ajustes nessa transição
                -- Realizei o uso do FOR UPDATE em outros casos porque havua regrá de negócio entre select e o update e 
                -- Poderia haver neste meio tempo... outras operações sendo executadas.
                UPDATE employees SET salary = newSalary WHERE department_id = departmentId;

                COMMIT;

            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "No employees found for this department";
            END IF;
    END $$

DELIMITER ;

drop procedure salary_adjustment;

call salary_adjustment(2, 8000);

SELECT * FROM employees;

SELECT * FROM salary_adjustment_logs;