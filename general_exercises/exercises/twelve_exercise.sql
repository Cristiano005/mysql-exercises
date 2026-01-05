SELECT * FROM products WHERE NOT EXISTS (SELECT 1 FROM order_items WHERE product_id = products.rowid)

-- OR

SELECT * FROM products WHERE rowid NOT IN (SELECT order_items.product_id FROM order_items)