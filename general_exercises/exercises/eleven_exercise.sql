SELECT customers.name, count(orders.customer_id) as quantityOfOrders FROM orders 
	INNER JOIN customers ON customers.rowid = orders.customer_id GROUP BY customers.rowid