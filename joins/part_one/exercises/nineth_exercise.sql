
SELECT * FROM orders;

SELECT * FROM payments;

SELECT orders.id AS orderId, user.name, orders.total, payment.status
FROM orders
    LEFT JOIN payments payment 
        ON payment.order_id = orders.id
    INNER JOIN users user ON user.id = orders.user_id
WHERE status = 'paid';
