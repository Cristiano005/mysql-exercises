DELIMITER $$

    CREATE PROCEDURE define_grade(IN grade DECIMAL(3,2) unsigned)

    BEGIN

        DECLARE response VARCHAR(100);

        CASE 

            WHEN grade < 6 
                THEN SET response = "Reprovado!"; 
            WHEN grade between 6 and 7 
                THEN SET response = "Recuperação!";
            ELSE SET response = "Aprovado!";

        END CASE;

        SELECT response;
    END

DELIMITER $$

call define_grade(7);

-- drop procedure define_grade;