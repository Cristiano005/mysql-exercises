SELECT orders.order_id, customer.name AS customer, 
  COUNT(*) AS quantityOfItems 
FROM orders 
  INNER JOIN customers customer ON customer.customer_id = orders.customer_id
  INNER JOIN order_items item ON item.order_id = orders.order_id
GROUP BY item.order_id