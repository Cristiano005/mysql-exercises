DELIMITER $$

    --- Decidi fazer diferente, ao invés de IN, aplicar INOUT

    CREATE PROCEDURE salary_adjustment(INOUT salary decimal(10,2) unsigned)

    BEGIN

        IF salary < 2000 THEN
            SET salary = salary + (salary * 0.20);
        ELSEIF salary between 2000 AND 5000 THEN
            SET salary = salary + (salary * 0.10);
        ELSE 
            SET salary = salary + (salary * 0.05);
        END IF;

    END $$

DELIMITER ;

SET @salary = 5100;
call salary_adjustment(@salary);
SELECT @salary;