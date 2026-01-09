SELECT customer.name, count(orders.customer_id) as quantityOfOrders 
	FROM orders 
		INNER JOIN customers customer
			ON customer.customer_id = orders.customer_id 
	GROUP BY customer.customer_id

	-- Improved Version

SELECT customer.name, count(*) as quantityOfOrders 
	FROM orders 
		INNER JOIN customers customer
			ON customer.customer_id = orders.customer_id 
	GROUP BY customer.customer_id, customer.name