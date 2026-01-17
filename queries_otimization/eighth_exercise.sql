/* Tests */

SELECT * FROM users;

SELECT * FROM users WHERE name LIKE '%silva%';

CREATE INDEX idx_like_search ON users (name)

SELECT name, MATCH(name) AGAINST ('User Silva') 
    FROM users 
        WHERE MATCH(name) 
            AGAINST ('-User Silva' WITH QUERY EXPANSION);

CREATE FULLTEXT INDEX idx_search_by_name ON users 
    (name);

DROP INDEX idx_like_search ON users;

/*
    O índice não é utilizado neste caso porque os índices padrão do
    MySQL (B-tree) dependem de um valor inicial bem definido para
    realizar a busca. 

    Quando o like utiliza um wildcard assim (%texto%) ou (%texto), 
    o MySQL não consegue determinar o ponto inicial na árvore B-tree,
    perdendo a ordenação do índice. Com isso, o otimizador é obrigado
    a realizar um full table scan para avaliar todas as linhas.
*/

-- 

