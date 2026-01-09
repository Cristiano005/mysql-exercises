SELECT * FROM orders;

SELECT orders.id AS orderId, orders.total, orders.status
FROM orders 
    INNER JOIN payments payment 
        ON payment.order_id = orders.id AND
            payment.status = 'paid'
    LEFT JOIN order_items item
        ON item.order_id = orders.id
WHERE item.order_id IS NULL;

