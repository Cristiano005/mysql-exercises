SELECT 
	id,
    month,
	MAX(total_amount_by_month)
FROM (
  SELECT  
  	  rowid AS id,
  	  strftime('%m', order_date) as month,
      SUM(total_amount) AS total_amount_by_month
  FROM 
     orders 
 	WHERE status = 'completed' GROUP BY strftime('%m', order_date)
) orders