DELIMITER $$

    CREATE PROCEDURE validate_age(IN age int unsigned)

        BEGIN

            IF age < 0 THEN
                SELECT "Idade fora do padrão!";
            ELSEIF age > 120 THEN
                SELECT "Idade fora do padrão";
            ELSE
                SELECT "Idade válida!";
            END IF;

        END $$

DELIMITER ;

call validate_age(12);