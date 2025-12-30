SELECT @@AUTOCOMMIT;

SET @@AUTOCOMMIT = OFF;

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    balance DECIMAL(10,2) NOT NULL
);

INSERT INTO accounts (code, balance) VALUES
('ACC-001', 1500.00),
('ACC-002', 2350.50),
('ACC-003', 980.75),
('ACC-004', 4200.00),
('ACC-005', 300.25),
('ACC-006', 12500.00),
('ACC-007', 760.00),
('ACC-008', 1890.90),
('ACC-009', 50.00),
('ACC-010', 6700.00);

DELIMITER $$

    CREATE PROCEDURE transfer_balance(IN origin_account varchar(7), IN to_account varchar(7), IN p_transfer_amount decimal(10,2) unsigned) 

    BEGIN

        DECLARE balanceFromAccount DECIMAL(10,2) unsigned DEFAULT 0;
        DECLARE balanceToAccount DECIMAL(10,2) unsigned DEFAULT 0;  

        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transfer failed. Transaction rolled back.';
        END;

        START TRANSACTION;

            SELECT balance INTO balanceFromAccount FROM accounts WHERE code = origin_account;

            IF origin_account AND to_account THEN

                IF balanceFromAccount >= p_transfer_amount THEN

                    UPDATE accounts SET balance = balanceFromAccount - p_transfer_amount WHERE code = origin_account;

                    SELECT balance INTO balanceToAccount FROM accounts WHERE code = to_account;

                    UPDATE accounts SET balance = balanceToAccount + p_transfer_amount WHERE code = to_account; 

                    COMMIT;

                ELSE  
                    SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Insufficient balance!";
                    ROLLBACK;
                END IF;

            ELSE 
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Accout's Error!";
            END IF;
    END $$

DELIMITER ;

drop procedure transfer_balance;

select * from accounts;

call transfer_balance("ACC-005", "ACC-007", 300);


SELECT balance FROM accounts WHERE code = "ACC-008"