SELECT sum(total_amount) FROM orders 
GROUP BY customer_id 
ORDER BY total_amount DESC LIMIT 3

-- Improved Version

SELECT customer.name AS customer, sum(total_amount) AS total_spent FROM orders 
    INNER JOIN customers customer ON customer.customer_id = orders.customer_id
GROUP BY customer.customer_id 
ORDER BY total_spent DESC LIMIT 3