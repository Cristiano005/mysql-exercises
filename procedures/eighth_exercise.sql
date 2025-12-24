DELIMITER $$

    CREATE PROCEDURE sum_to(IN limit_number int unsigned)

    BEGIN

        DECLARE total int unsigned default 0; 
        DECLARE increment int unsigned default 1;

        REPEAT

            SET total = total + increment;
            SET increment = increment + 1;

            UNTIL increment > limit_number END REPEAT;

        SELECT total;

    END

DELIMITER $$

call sum_to(5);

-- drop procedure sum_to;