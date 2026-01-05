SELECT user.name, orders.total FROM users AS user INNER JOIN orders  
    ON orders.user_id = user.id

SELECT * FROM orders 

SELECT * FROM customers