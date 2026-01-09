SELECT * FROM logs;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM payments;

SELECT * FROM users;

SELECT DISTINCT user.id, user.name FROM users user 
    INNER JOIN orders t_order 
        ON t_order.user_id = user.id
    INNER JOIN payments payment
        ON payment.order_id = t_order.id
            AND payment.status = 'paid'
    LEFT JOIN logs t_log 
        ON t_log.user_id = user.id
WHERE t_log.user_id IS NULL;