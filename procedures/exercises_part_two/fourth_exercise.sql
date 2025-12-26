DELIMITER $$

    CREATE PROCEDURE multiplication(IN number_value INT unsigned)

    BEGIN

        DECLARE increment_value INT UNSIGNED DEFAULT 1;

        WHILE increment_value <= 10 DO

            SELECT number_value * increment_value AS result;

            SET increment_value = increment_value + 1;

        END WHILE;
        
    END $$

DELIMITER ;

call multiplication(7);

drop procedure multiplication;