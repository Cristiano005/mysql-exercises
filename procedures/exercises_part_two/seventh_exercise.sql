DELIMITER $$

    CREATE PROCEDURE multiply_value_by_two(INOUT numberValue int unsigned)

    BEGIN

        SET numberValue = numberValue * 2;

    END $$

DELIMITER ;

SET @numberValue = 5;

call multiply_value_by_two(@numberValue);

SELECT @numberValue;