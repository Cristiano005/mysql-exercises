-- CREATE TABLE products (
--     id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
--     product_name VARCHAR(150) NOT NULL,
--     price DECIMAL(10,2) NOT NULL
-- );

-- INSERT INTO products (product_name, price) VALUES
-- ('Notebook Dell Inspiron', 3899.90),
-- ('Mouse Logitech', 129.99),
-- ('Teclado Mecânico', 499.50),
-- ('Monitor LG 24"', 899.00),
-- ('Headset Gamer', 299.90);

-- drop table products;

DELIMITER $$

    CREATE PROCEDURE apply_discount(IN product_id int unsigned, IN percentage decimal(5,2) unsigned)

    BEGIN

        DECLARE response VARCHAR(50);
        DECLARE priceWithDiscount DECIMAL(10,2) DEFAULT 0;

        IF percentage > 50 THEN

            SET response = "Não foi possível aplicar desconto!";

        ELSE 

            SELECT price INTO @product_price FROM products WHERE id = product_id;

            SET priceWithDiscount = @product_price - (@product_price * (percentage / 100));

            UPDATE products SET price = priceWithDiscount WHERE id = product_id;

            SET response = CONCAT_WS(" ", "Desconto de", percentage, "aplicado com sucesso!");

        END IF;

        SELECT response as message;

    END $$

DELIMITER ;

SELECT * FROM products;

-- drop procedure apply_discount;

call apply_discount(1, 49);