SELECT * FROM orders;

select * from users;

SELECT * FROM payments;

SELECT user.id, user.name, COUNT(DISTINCT orders.id) AS quantity FROM orders
    INNER JOIN users user 
        ON user.id = orders.user_id
    LEFT JOIN payments payment
        ON payment.order_id = orders.id
        AND payment.status = 'paid'
WHERE payment.id IS NULL
GROUP BY user.id, user.name;

-- INSERT INTO payments(id, order_id, status) 
--     VALUES (4, 105, "paid")