DELIMITER $$

    CREATE PROCEDURE count_to(IN number INT)

    BEGIN

        DECLARE increment INT DEFAULT 1;

        WHILE increment <= number DO

            SELECT increment;

            SET increment = increment + 1;

        END WHILE;
     
    END $$

DELIMITER ;

call count_to(5);

drop procedure count_to