CREATE TABLE products (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stock INT NOT NULL DEFAULT 0
) ENGINE = InnoDB;

-- INSERT INTO products (name, stock) VALUES ("Go Pro", 443)

select * from products

--- InnoDB para ativar uso de transactions.

DELIMITER $$

CREATE PROCEDURE low_stock(IN productId int unsigned, IN quantity int unsigned) 

    BEGIN

        DECLARE quantityStock int unsigned DEFAULT 0;

        DECLARE erro_sql TINYINT DEFAULT FALSE; -- Tem que vir depois!
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro_sql = TRUE;

        START TRANSACTION;

            SELECT stock INTO quantityStock FROM products WHERE id = productId;

            SET quantityStock = quantityStock - quantity;

            IF quantityStock < quantity THEN
                ROLLBACK;
                SELECT 'Insufficient stock' AS result;
                LEAVE proc;
            END IF;

            UPDATE products SET stock = quantityStock WHERE id = productId;

        IF erro_sql = FALSE THEN
            COMMIT;
            SELECT 'Transaction done succefully' AS result;
        ELSE
            ROLLBACK;
            SELECT 'Transaction Error' AS result;
        END IF;

    END $$

DELIMITER ;

-- SHOW TABLE STATUS WHERE Name = 'products';

drop procedure low_stock

call low_stock (1, 10);