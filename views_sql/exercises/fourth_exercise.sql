SELECT * FROM orders;

CREATE VIEW view_big_orders AS
    SELECT orders.id, orders.total FROM orders
        WHERE orders.total > (
            SELECT AVG(orders.total) FROM orders
        );

SELECT * FROM view_big_orders