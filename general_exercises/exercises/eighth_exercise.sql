SELECT city, COUNT(name) AS quantityByCity FROM customers 
GROUP BY city ORDER BY quantityByCity DESC