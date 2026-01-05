SELECT categories.category_name, ROUND(SUM(order_items.quantity * order_items.unit_price), 2)  AS totalByCategory from order_items 
	INNER JOIN products ON products.rowid = order_items.product_id 
    INNER JOIN categories ON categories.rowid = products.category_id
 GROUP BY products.category_id