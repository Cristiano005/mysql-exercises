SELECT @@autocommit;

CREATE TABLE park_visitors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    paid_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ride_id INT NOT NULL,
    CONSTRAINT fk_visitor_ride
        FOREIGN KEY (ride_id) REFERENCES rides(id)
) ENGINE=InnoDB;

CREATE TABLE rides (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    occupied BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB;

ALTER TABLE rides ADD COLUMN current_quantity INT UNSIGNED NOT NULL DEFAULT 0;

INSERT INTO rides (name, occupied) VALUES
('Montanha Russa', TRUE),
('Roda Gigante', FALSE),
('Barco Viking', TRUE),
('Carrinho Bate-Bate', FALSE),
('Torre do Terror', TRUE);

DELIMITER $$

    CREATE PROCEDURE enter_to_park(IN visitorName VARCHAR(100), IN rideId INT UNSIGNED)

    BEGIN

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO park_visitors (id, name, ride_id) VALUES (NULL, visitorName, rideId);
            SAVEPOINT new_visitor_added;

            UPDATE rides SET current_quantity = (
                SELECT COUNT(*) FROM park_visitors WHERE ride_id = rideId
            ) WHERE id = rideId;

            IF (SELECT current_quantity FROM rides WHERE id = rideId) <= 20 THEN 
                COMMIT;
            ELSE 
                ROLLBACK TO new_visitor_added; -- Rollback sempre primeiro do que o signal para não atrapalhar transação
                SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Maximum capacity reached!";
            END IF;

    END $$

DELIMITER ;

CALL enter_to_park("Thayna", 6);

drop procedure enter_to_park;

SELECT * FROM park_visitors;

SELECT * FROM rides;

SELECT current_quantity FROM rides WHERE id = 4

UPDATE rides SET current_quantity = (
    SELECT COUNT(*) + 1 FROM park_visitors WHERE ride_id = 1
) WHERE id = 4;

SELECT COUNT(*) FROM park_visitors WHERE ride_id = 2

SELECT
  @@session.transaction_isolation AS session_level,
  @@global.transaction_isolation  AS global_level;
