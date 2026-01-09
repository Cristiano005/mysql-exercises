
SELECT SUM(order_items.quantity * order_items.unit_price) AS total 
    FROM order_items item
inner JOIN orders ON orders.order_id = item.order_id 
    AND orders.status = 'completed' 