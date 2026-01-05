INSERT INTO products (name) VALUES ("TV");

SELECT * FROM order_items;

SELECT * FROM products;

SELECT * FROM products AS product LEFT JOIN order_items AS item
    ON item.product_id = product.id 
WHERE order_id IS NULL;

