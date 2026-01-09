SELECT product.product_id, product.product_name 
    FROM products product
        WHERE NOT EXISTS 
            (SELECT 1 FROM order_items item
                WHERE item.product_id = product.product_id)

-- OR

SELECT * FROM products product
    WHERE product.product_id NOT IN 
        (SELECT item.product_id FROM order_items item)