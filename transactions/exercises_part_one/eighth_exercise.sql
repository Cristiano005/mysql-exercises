ALTER TABLE customers ADD COLUMN deleted_at DATETIME NULL;

DELIMITER $$

    CREATE PROCEDURE delete_customer(IN customerId INT UNSIGNED)

    BEGIN

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            IF (SELECT 1 FROM customers WHERE id = customerId) = 1 THEN

                UPDATE customers SET deleted_at = now() WHERE id = 4;

                UPDATE orders SET status = "CANCELLED" WHERE customer_id = customerId AND status = "PENDING";

                COMMIT;

            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Customer doesn't exist!";
            END IF;
        

    END $$

DELIMITER ;

drop procedure delete_customer;

call delete_customer(4);

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM order_items