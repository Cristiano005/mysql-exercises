ALTER TABLE orders ADD COLUMN status VARCHAR(25) NOT NULL DEFAULT "PENDING";

DELIMITER $$

    CREATE PROCEDURE cancel_order(IN orderId int unsigned) 

    BEGIN 

        DECLARE orderFound INT UNSIGNED DEFAULT 0;

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            SELECT EXISTS (SELECT 1 FROM orders WHERE id = orderId AND status = "PENDING") INTO orderFound;

            IF orderFound = 1 THEN

                UPDATE orders SET status = "CANCELLED" WHERE id = orderId;

                UPDATE products INNER JOIN order_items AS item ON item.product_id = products.id 
                    SET products.stock = products.stock + item.quantity WHERE item.order_id = orderId;

                COMMIT;
                
            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "It wasn't possible update order!";
            END IF;

    END $$

DELIMITER ;

drop procedure cancel_order;

CALL cancel_order(13); // 14, 85, 70

SELECT * FROM orders;

SELECT * FROM order_items WHERE order_id = 13;

select * from products WHERE id in (1,7,3);

select (products.stock + item.quantity) AS cancelado from products inner join order_items as item ON products.id = item.product_id;

SELECT EXISTS (SELECT 1 FROM orders WHERE id = 10 AND status = "PENDING")