DELIMITER $$

    CREATE PROCEDURE define_age(IN age_number int unsigned)

    BEGIN

        DECLARE response VARCHAR(100);

        IF (age_number < 18) THEN
            SET response = "Minor";
        ELSE 
            SET response = "Adult";
        END IF;

        SELECT response;

    END $$

DELIMITER ;

call define_age(20);

drop procedure define_age;