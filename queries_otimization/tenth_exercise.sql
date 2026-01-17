SELECT * FROM orders 
    WHERE user_id = 555 
ORDER BY 
    created_at DESC LIMIT 10;

-- BEFORE

-- -> Limit: 10 row(s)  (cost=0.35 rows=1) (actual time=0.107..0.112 rows=1 loops=1

--     -> Sort: orders.created_at DESC, limit input to 10 row(s) per chunk  (cost=0.35 rows=1) (actual time=0.0988..0.1 rows=1 loops=1)

--         -> Index lookup on orders using fk_orders_user (user_id=555)  (cost=0.35 rows=1) (actual time=0.0698..0.0735 rows=1 loops=1)


CREATE INDEX idx_created_user_id_users ON orders 
    (created_at DESC, user_id);

-- Isso causa um filesort, ou seja, um passo a mais que precisa ser executado depois de buscados.

EXPLAIN ANALYZE SELECT * FROM orders 
    WHERE user_id = 555 
ORDER BY 
    created_at DESC LIMIT 10;

    -- FIRST TIME

-- -> Limit: 10 row(s)  (cost=0.35 rows=1) (actual time=0.0931..0.0979 rows=1 loops=1)

--     -> Sort: orders.created_at DESC, limit input to 10 row(s) per chunk  (cost=0.35 rows=1) (actual time=0.0845..0.0865 rows=1 loops=1)

--         -> Index lookup on orders using fk_orders_user (user_id=555)  (cost=0.35 rows=1) (actual time=0.052..0.0568 rows=1 loops=1)

DROP INDEX idx_created_user_id_users ON orders;

-- Índice criado da maneira correta!

CREATE INDEX idx_created_user_id_users ON orders 
    (user_id, created_at DESC);

EXPLAIN ANALYZE SELECT * FROM orders 
    WHERE user_id = 555 
ORDER BY 
    created_at DESC LIMIT 10;

-- -> Limit: 10 row(s)  (cost=0.35 rows=1) (actual time=0.0511..0.0577 rows=1 loops=1)

--     -> Index lookup on orders using idx_created_user_id_users (user_id=555)  (cost=0.35 rows=1) (actual time=0.0439..0.0472 rows=1 loops=1)


---- Resultado Final:

/*
    Na última linha... o resultado diz que apenas precisou procurar os 
    registros específicos com dados já ordenados devido a aplicação correta
    na criação dos índices.
*/