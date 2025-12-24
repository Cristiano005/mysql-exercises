DELIMITER $$

    CREATE PROCEDURE sp_hello()

    BEGIN 

        SELECT "Hello, MySQL Procedures!" AS greeting;

    END

DELIMITER $$

call sp_hello;