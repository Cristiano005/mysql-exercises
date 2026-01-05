SELECT orders.rowid, customer.name, COUNT(item.order_id) AS quantityOfItems FROM orders 
   		INNER JOIN customers customer ON customer.rowid = orders.customer_id
        INNER JOIN order_items item ON item.order_id = orders.rowid
      GROUP BY item.order_id