SELECT * FROM products

SELECT * FROM order_items;

CREATE VIEW view_product_sales AS 
    SELECT product.id, product.name, 
        SUM(COALESCE(item.quantity, 0)) AS quantitySold,
        SUM(COALESCE(item.quantity, 0) * product.price) AS totalSold 
    FROM products product
        LEFT JOIN order_items item
            ON item.product_id = product.id
    GROUP BY product.id, product.name

DROP VIEW IF EXISTS view_product_sales;

SELECT * FROM view_product_sales
    ORDER BY id, name;