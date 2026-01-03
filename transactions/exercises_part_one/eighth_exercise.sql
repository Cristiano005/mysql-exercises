ALTER TABLE customers ADD COLUMN deleted_at DATETIME NULL;

DELIMITER $$

    CREATE PROCEDURE delete_customer(IN customerId INT UNSIGNED)

    BEGIN

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            IF EXISTS (SELECT 1 FROM customers WHERE id = customerId AND deleted_at IS NULL FOR UPDATE) THEN

                UPDATE customers SET deleted_at = now() WHERE id = customerId;
                UPDATE orders SET status = "CANCELLED" WHERE customer_id = customerId AND status = "PENDING";

                COMMIT;

            ELSE
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Customer doesn't allowed!";
            END IF;
        

    END $$

DELIMITER ;

drop procedure delete_customer;

call delete_customer(1);

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM order_items