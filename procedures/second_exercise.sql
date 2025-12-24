DELIMITER $$

    CREATE PROCEDURE custom_greeting(IN name varchar(100))

    BEGIN
        SELECT CONCAT_WS(" ", "Welcome,", name) AS custom_message;
    END
    
DELIMITER $$

call custom_greeting("Cristiano");

-- drop procedure custom_greeting;