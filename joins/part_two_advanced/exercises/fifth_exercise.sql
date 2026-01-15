-- Active: 1766198979246@@127.0.0.1@3306@test_joins
SELECT * FROM products;

SELECT * FROM order_items;

SELECT * FROM categories;

EXPLAIN ANALYZE SELECT product.name FROM products product
    INNER JOIN categories category 
        ON category.id = product.category_id
    LEFT JOIN order_items item 
        ON item.product_id = product.id
WHERE product.active = 1 AND item.id IS NULL;

SHOW INDEXES FROM products;
