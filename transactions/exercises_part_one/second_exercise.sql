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

DELIMITER $$

CREATE PROCEDURE create_order(IN customerId int, IN products json, IN total decimal(10,2)) 

    BEGIN

        DECLARE customerFound INT UNSIGNED DEFAULT 0;

        -- Declaro um handler que fica ouvindo se há algum erro, se houver ele dá ROLLBACK e lança-o.
        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN 
            ROLLBACK;
            RESIGNAL; 
            -- Recupera a mensagem de ero sql setada
        END;

        START TRANSACTION;

            SELECT EXISTS( SELECT 1 FROM customers WHERE id = customerId) INTO customerFound;

            IF customerFound = 1 THEN

                IF JSON_LENGTH(products) > 0 THEN

                    INSERT INTO orders (id, customer_id, total) VALUES (NULL, customerId, total);

                    IF LAST_INSERT_ID() THEN 

                        IF EXISTS (
                            SELECT 1
                                FROM JSON_TABLE(
                                    products,
                                    '$[*]'
                                    COLUMNS (
                                        productId INT PATH '$.productId',
                                        quantity INT PATH '$.quantity'
                                    )
                                ) JT
                            JOIN products p ON p.id = JT.productId
                            WHERE p.stock < JT.quantity
                        ) THEN
                            SIGNAL SQLSTATE '45000'
                            SET MESSAGE_TEXT = 'Insufficient stock for one or more products';
                        END IF;

                        INSERT INTO order_items (order_id, product_id, quantity) SELECT LAST_INSERT_ID(), JT.productId, JT.quantity FROM JSON_TABLE(products, '$[*]' 
                        COLUMNS (productId INT PATH '$.productId', quantity INT PATH '$.quantity')) AS JT;

                        UPDATE products p
                            JOIN JSON_TABLE(
                                products,
                                '$[*]'
                                COLUMNS (
                                    productId INT PATH '$.productId',
                                    quantity INT PATH '$.quantity'
                                )
                            ) jt ON jt.productId = p.id
                            
                            SET p.stock = p.stock - jt.quantity;

                        COMMIT;

                    ELSE 
                        ROLLBACK;
                        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "It wasn't possible added order!";
                    END IF;

                ELSE 
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data empty!";
                END IF;

            ELSE 
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Customer doesn't exist!";
            END IF;

    END $$

DELIMITER;

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
