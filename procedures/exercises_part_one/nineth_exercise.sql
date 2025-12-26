DELIMITER $$

    CREATE PROCEDURE calculate_tax(IN value decimal(10,2) unsigned, OUT tax decimal(10,2) unsigned)

    BEGIN
        SET tax = value * 0.15;
    END $$

DELIMITER ;

call calculate_tax(1500, @tax)

-- DROP PROCEDURE calculate_tax;

SELECT @tax