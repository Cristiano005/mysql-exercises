DELIMITER $$

    CREATE PROCEDURE pcd_count_active_users()

    BEGIN

        DECLARE total int DEFAULT 0;

        SELECT count(*) INTO total FROM users WHERE active = 1;

        SELECT total;

    END $$

DELIMITER ;

call pcd_count_active_users();

-- drop procedure pcd_count_active_users