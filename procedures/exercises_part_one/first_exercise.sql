DELIMITER $$

    CREATE PROCEDURE sp_hello()

    BEGIN 

        SELECT "Hello, MySQL Procedures!" AS greeting;

    END $$

DELIMITER ;

-- drop procedure sp_hello;

call sp_hello;