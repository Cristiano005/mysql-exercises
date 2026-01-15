SELECT * FROM orders;

SELECT * FROM orders 
    WHERE status = 0 AND created_at >= '2026-01-01';

CREATE INDEX idx_status_created_at_orders ON orders 
    (status, created_at);

-- Reverse
CREATE INDEX idx_status_created_at_orders ON orders 
    (created_at, status);

DROP INDEX idx_status_created_at_orders ON orders;

SELECT * FROM orders 
    WHERE status = 0 AND created_at >= '2026-01-01'
ORDER BY created_at DESC;