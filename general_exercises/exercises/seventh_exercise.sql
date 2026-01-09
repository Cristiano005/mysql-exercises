SELECT product_name AS product_name, MAX(price) AS product_price FROM products

-- Improved Version

SELECT product_name, price FROM products 
	WHERE price = (SELECT MAX(price) FROM products);

/*

Como estou lidando com funções de agregações, a minha primeira query rodou por o SQL Lite ser
permisivo, porém continha falhas, falhas essas devido a função de agregação MAX que em bancos menos
permisivos não deixariam ocultas, ou seja, funções de agregação buscam registros e retornam os 
específicos, mas fora dele, os outros campos na lista de select continuam buscando registros
na tabela inteira, o que gera incositência... então por isso executa-se primeiro a busca pelo
maior preço e só depois pega o(s) nome(s)

*/

-- E se fosse pra resgatar o produto mais cara de cada categoria?

SELECT product_name, category_id, price
FROM products AS p1
WHERE price = (
    SELECT MAX(price) 
    FROM products AS p2 
    WHERE p2.category_id = p1.category_id
);