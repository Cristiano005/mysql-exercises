
SELECT SUM(order_items.quantity * order_items.unit_price) AS total 
    FROM order_items 
inner JOIN orders ON orders.rowid = order_items.order_id 
    AND orders.status = 'completed' 