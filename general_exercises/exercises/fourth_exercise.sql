SELECT products.product_name, categories.category_name FROM products INNER JOIN categories ON categories.rowid = products.category_id
	WHERE products.category_id = 1;