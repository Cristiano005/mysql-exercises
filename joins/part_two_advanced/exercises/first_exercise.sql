SELECT * FROM orders

SELECT * FROM payments

SELECT user.name, SUM(orders.total) FROM orders
    INNER JOIN payments payment 
        ON payment.order_id = orders.id
    INNER JOIN users user 
        ON user.id = orders.user_id
WHERE orders.status <> 'cancelled' 
        AND payment.status = 'paid'
GROUP BY user.id
