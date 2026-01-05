SELECT * FROM payments

orders -> left
payments -> right (status opcional)

SELECT orders.id, orders.total, payment.status FROM orders 
    LEFT JOIN payments payment
        ON payment.order_id = orders.id