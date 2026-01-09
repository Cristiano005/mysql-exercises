 SELECT rowid, strftime('%d/%m/%Y', order_date) FROM orders WHERE strftime('%m-%Y', order_date) > '06-2024'

 --- Improved Version

  SELECT order_id, strftime('%d/%m/%Y', order_date) AS formatted_date FROM orders WHERE order_date > '2024-06-30'