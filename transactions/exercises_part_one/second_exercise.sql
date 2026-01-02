SET @@autocommit = OFF;

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders (id)
);

--- Cria uma tabela temporária pra evitar repetidos json_table

CREATE TEMPORARY TABLE tmp_products (
    product_id INT,
    quantity INT,
    PRIMARY KEY (product_id)
) ENGINE=InnoDB;

DELIMITER $$

CREATE PROCEDURE create_order(
    IN customerId INT,
    IN products JSON,
    IN total DECIMAL(10,2)
)
BEGIN
    DECLARE orderId INT UNSIGNED DEFAULT 0;

    -- Handler global
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

        -- valida cliente
        IF NOT EXISTS (SELECT 1 FROM customers WHERE id = customerId) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Customer does not exist';
        END IF;

        -- valida JSON
        IF JSON_LENGTH(products) = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Products list is empty';
        END IF;

        -- cria pedido
        INSERT INTO orders (customer_id, total)
        VALUES (customerId, total);

        SET orderId = LAST_INSERT_ID();

        IF orderId = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Order could not be created';
        END IF;

        -- tabela temporária
        CREATE TEMPORARY TABLE IF NOT EXISTS tmp_products (
            product_id INT NOT NULL,
            quantity   INT NOT NULL
        );

        -- JSON → tabela
        INSERT INTO tmp_products (product_id, quantity)
        SELECT jt.productId, jt.quantity
        FROM JSON_TABLE(
            products,
            '$[*]' COLUMNS (
                productId INT PATH '$.productId',
                quantity  INT PATH '$.quantity'
            )
        ) AS jt;

        -- trava apenas os produtos do pedido
        SELECT p.id
        FROM products p
        JOIN tmp_products t ON t.product_id = p.id
        ORDER BY p.id
        FOR UPDATE;

        -- valida estoque
        IF EXISTS (
            SELECT 1
            FROM products p
            JOIN tmp_products t ON t.product_id = p.id
            WHERE p.stock < t.quantity
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for one or more products';
        END IF;

        -- itens do pedido
        INSERT INTO order_items (order_id, product_id, quantity)
        SELECT orderId, product_id, quantity
        FROM tmp_products;

        -- baixa estoque
        UPDATE products p
        JOIN tmp_products t ON t.product_id = p.id
        SET p.stock = p.stock - t.quantity;

        COMMIT;

        DROP TEMPORARY TABLE IF EXISTS tmp_products;

END $$

DELIMITER ;

drop procedure create_order;

call create_order (
    2,
    '[
    {
        "productId": 1,
        "quantity": 10
    },
    {
        "productId": 7,
        "quantity": 15
    },
    {
        "productId": 3,
        "quantity": 5
    }
]',
    250
);

select * from orders;

select * from order_items;

select * from customers;

select * from products;

SELECT @@AUTOCOMMIT;
