SELECT 
	id,
    only_month,
	MAX(total_amount_by_month)
FROM (
  SELECT  
  	  order_id AS id,
  	  strftime('%m', order_date) AS only_month,
      SUM(total_amount) AS total_amount_by_month
  FROM 
     orders 
 	WHERE status = 'completed' GROUP BY strftime('%m', order_date)
) orders