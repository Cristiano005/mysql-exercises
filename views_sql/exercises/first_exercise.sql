-- Active: 1766198979246@@127.0.0.1@3306@test_views
CREATE VIEW view_users_over_25 AS
    SELECT * FROM users user
        WHERE user.age > 25;

SELECT * FROM view_users_over_25;

-- details about view created!

SHOW CREATE VIEW view_users_over_25;