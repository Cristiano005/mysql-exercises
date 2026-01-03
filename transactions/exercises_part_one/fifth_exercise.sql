CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    professional_id INT NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO appointments (professional_id, date, time, status) VALUES
(1, '2025-01-10', '09:00:00', 'scheduled'),
(2, '2025-01-10', '10:30:00', 'completed'),
(1, '2025-01-11', '14:00:00', 'cancelled'),
(3, '2025-01-12', '16:00:00', 'scheduled'),
(2, '2025-01-13', '08:30:00', 'pending');

DELIMITER $$

    CREATE PROCEDURE create_schedule(IN professionalId int unsigned, IN p_date DATE, IN p_time TIME)

    BEGIN 

        DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;
            INSERT INTO appointments (professional_id, date, time, status) VALUES (professionalId, p_date, p_time, "pending");
        COMMIT;
    END $$

DELIMITER ;

select * from appointments;

drop procedure create_schedule;

call create_schedule(2, "2025-12-31", "09:00:00");

ALTER TABLE appointments ADD UNIQUE INDEX idx_unique_schedule (professional_id, date, time);

--- Agebndamento tá sendo erncontrado, tá errado isso, deposi vejo!