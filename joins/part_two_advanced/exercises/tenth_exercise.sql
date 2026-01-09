SELECT * FROM users;

SELECT * FROM orders;

SELECT * FROM payments;

SELECT * FROM logs;

SELECT orders.id, 'Order with inexistent User Id' AS issueType FROM orders
    LEFT JOIN users user 
        ON user.id = orders.user_id
    WHERE user.id IS NULL

UNION ALL 

SELECT payment.id AS paymentId, 
    'Payment with inexistent Order Id' AS issueType 
    FROM payments payment
        LEFT JOIN orders 
            ON orders.id = payment.order_id
        WHERE orders.id IS NULL

UNION ALL

SELECT logs.id, 'Log with inexistent User Id' AS issueType
    FROM logs  
        LEFT JOIN users user
            ON user.id = logs.user_id
        WHERE user.id IS NULL;