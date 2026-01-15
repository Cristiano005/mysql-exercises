
/* 
    Pesuisa sem índice: +/- 270ms.
*/
SELECT id, name FROM users WHERE 
    status = 'active' ORDER BY created_at DESC LIMIT 20;

CREATE INDEX idx_status_created_at_from_users ON users 
    (status, created_at);

-- CREATE INDEX idx_status_created_at_from_users ON users 
--     (status);

CREATE INDEX idx_status_created_at_from_users ON users 
    (created_at);

/* Pesuisa sem índice: +/- 3ms. */
EXPLAIN ANALYZE SELECT id, name FROM users WHERE 
    status = 'active' ORDER BY created_at DESC LIMIT 20;

DROP INDEX idx_status_created_at_users ON users;

/*
    O uso do índice composto se dá devido ao campos status e created_at
    serem utilizados, e com isso minimiza o scan, ou seja, a busca por
    linhas em toda tabela. É preciso criar índice, sendo um para
    o campo crated_at porque se não tiver ele e só tiver pro status, 
    ele vai fazer a busca pelo filtro e depois vai ter que ordernar tudo
    e só depois usar o limit de 20, fazendo com que seja mais lento, 
    usando o filesort, conceito do MySQL que realiza um aordenação de dados
    caso não seja realizados na busc ado índice.
*/

-- Final Answer

CREATE INDEX idx_status_created_at_users ON users 
    (status, created_at DESC)