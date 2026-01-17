EXPLAIN SELECT * FROM orders 
    WHERE status = 0;

EXPLAIN ANALYZE 
    SELECT * FROM orders 
        WHERE status = 0;

SELECT * FROM orders 
    WHERE status = ;

SELECT * FROM orders;

CREATE INDEX idx_status_orders ON orders (status);

DROP INDEX idx_status_orders ON orders;

SHOW INDEX FROM orders;

/*
    A cardinalidade é baixa e neste caso específico não
    compensa porque de 10, 9 registros são um único valor 
    e adicionar um índice gastaria desempenho de insert, 
    update etc.!
*/