DELIMITER $$

    CREATE PROCEDURE discount(IN value DECIMAL(10,2))

    BEGIN

        DECLARE result DECIMAL(10,2);
        SET result = value - (value * 0.10);
        SELECT result AS result;

    END $$

DELIMITER ;

call discount(650);

-- drop procedure discount