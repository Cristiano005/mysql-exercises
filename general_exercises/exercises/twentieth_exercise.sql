SELECT customer.name FROM customers customer 
	INNER JOIN orders ON orders.customer_id = customer.rowid
    INNER JOIN order_items item ON item.order_id = orders.rowid
    INNER JOIN products product ON product.rowid = item.product_id
 group by customer.rowid
 HAVING COUNT(distinct product.category_id) > 1