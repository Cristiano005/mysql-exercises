CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(150) NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1
);

INSERT INTO users (username, active) VALUES ("Cristiano S.", 1); 

select * from users;

DELIMITER $$

    CREATE PROCEDURE toggle_user_status(IN user_id int unsigned)

    BEGIN

        SELECT active INTO @active_from_user FROM users 
            WHERE id = user_id;

        IF @active_from_user = 1 THEN
            SET @active_from_user = 0;
        ELSE 
            SET @active_from_user = 1;
        END IF;

        UPDATE users SET active = @active_from_user 
            WHERE id = user_id;

        SELECT @active_from_user;

    END $$

DELIMITER ;

drop procedure toggle_user_status;

call toggle_user_status(1);