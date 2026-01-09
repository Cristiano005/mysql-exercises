SELECT order_id AS id, total_amount FROM orders 
    WHERE total_amount > 
        (SELECT avg(total_amount) FROM orders)

--