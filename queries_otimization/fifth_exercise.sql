SELECT * FROM orders;

SELECT * FROM orders WHERE user_id = '96904'

SELECT COUNT(*) FROM orders WHERE total = '251.06';

CREATE INDEX idx_covering_index ON orders 
    (total, status, created_at)

DROP INDEX idx_covering_index ON orders;