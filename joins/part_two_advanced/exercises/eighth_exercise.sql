SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM products;

SELECT orders.id AS orderId, 
    COUNT(DISTINCT product.category_id) AS DistinctCategories
FROM orders 
    INNER JOIN order_items item 
        ON item.order_id = orders.id
    INNER JOIN products product 
        ON product.id = item.product_id
GROUP BY orders.id;