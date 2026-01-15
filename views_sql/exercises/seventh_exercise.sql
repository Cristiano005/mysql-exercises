CREATE VIEW view_completed_orders AS 
    SELECT order_id, user.name, orders.total
    FROM order_items item
        INNER JOIN orders
            ON orders.id = item.order_id
                AND orders.status = 'completed'
        INNER JOIN users user 
            ON user.id = orders.user_id

CREATE OR REPLACE VIEW view_completed_orders AS 
    SELECT order_id, user.name AS userName, orders.total
    FROM order_items item
        INNER JOIN orders
            ON orders.id = item.order_id
                AND orders.status = 'completed'
        INNER JOIN users user 
            ON user.id = orders.user_id
    GROUP BY orders.id;

DROP VIEW view_completed_orders;   

SELECT * FROM orders;

SELECT * FROM view_completed_orders;