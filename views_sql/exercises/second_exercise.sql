
CREATE VIEW view_user_orders AS 
    SELECT user.name, orders.id, orders.total 
        FROM users user
            INNER JOIN orders 
                ON orders.user_id = user.id;

SELECT name, total FROM view_user_orders;