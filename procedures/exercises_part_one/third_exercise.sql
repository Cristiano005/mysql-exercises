DELIMITER $$

    CREATE PROCEDURE custom_sum(IN numberOne INT, IN numberTwo INT)

    BEGIN

        SELECT numberOne + numberTwo AS result;

    END $$

DELIMITER ;

call custom_sum(169,259);

drop procedure custom_sum;