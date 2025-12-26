
DELIMITER $$

    CREATE PROCEDURE is_even(IN numberValue int unsigned)

    BEGIN

        IF MOD(numberValue, 2) = 1 THEN 

            SELECT "Ímpar";

        ELSE   

            SELECT "Par";

        END IF;

    END $$

DELIMITER ;

call is_even(101);
