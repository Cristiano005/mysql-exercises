SELECT * FROM view_product_sales;

CREATE OR REPLACE VIEW view_product_sales AS
    SELECT product.id, product.name, 
        SUM(COALESCE(item.quantity, 0)) AS quantitySold,
        SUM(COALESCE(item.quantity, 0) * product.price) AS totalSold 
    FROM products product
        LEFT JOIN order_items item
            ON item.product_id = product.id
        WHERE item.quantity IS NOT NULL
    GROUP BY product.id, product.name;

SELECT * FROM view_product_sales;