SELECT product.product_name, item.quantity FROM order_items AS item 
    INNER JOIN products AS product ON product.rowid = item.product_id
	WHERE order_id = 6

-- Improved Version

SELECT product.product_name, item.quantity FROM order_items AS item 
    INNER JOIN products AS product ON product.product_id = item.product_id
	WHERE item.order_id = 6