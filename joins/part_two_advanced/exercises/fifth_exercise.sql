SELECT * FROM products;

SELECT * FROM order_items;

SELECT * FROM categories;

SELECT product.name FROM products product
    INNER JOIN categories category 
        ON category.id = product.category_id
    LEFT JOIN order_items item 
        ON item.product_id = product.id
WHERE product.active = 1 AND item.id IS NULL;

