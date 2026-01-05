SELECT RANK() OVER (ORDER BY quantity DESC) AS totalRank, 
product_id, sum(quantity) as total
FROM order_items GROUP BY product_id;