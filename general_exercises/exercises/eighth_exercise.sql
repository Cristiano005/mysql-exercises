SELECT city, COUNT(name) AS quantityByCity FROM customers 
GROUP BY city ORDER BY quantityByCity DESC

-- Improved Version 

SELECT city, COUNT(*) AS quantityByCity FROM customers 
GROUP BY city ORDER BY quantityByCity DESC

-- "*" É mais semâtico e garante que não ocorra de uma coluna não ser contada caso seja NULL.