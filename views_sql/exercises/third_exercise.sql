
SELECT * FROM orders

CREATE VIEW view_total_per_user AS 
    SELECT user.id, user.name, SUM(orders.total) FROM users user 
        INNER JOIN orders 
            ON orders.user_id = user.id
    GROUP BY user.id;

SELECT * FROM view_total_per_user;

