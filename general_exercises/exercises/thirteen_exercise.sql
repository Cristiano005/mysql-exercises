SELECT category.category_name, 
    ROUND(SUM(item.quantity * item.unit_price), 2) AS totalByCategory 
FROM order_items item
	INNER JOIN products product ON product.product_id = item.product_id 
    INNER JOIN categories category ON category.category_id = product.category_id
GROUP BY product.category_id