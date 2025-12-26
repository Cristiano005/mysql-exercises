DELIMITER $$

    CREATE PROCEDURE count_rage(IN startNumber int unsigned, IN endNumber int unsigned)

    BEGIN

        range_loop: LOOP

            SELECT startNumber;

            IF startNumber = endNumber THEN
                LEAVE range_loop;
            END IF;

            IF startNumber > endNumber THEN

                SET startNumber = startNumber - 1;

            ELSEIF startNumber < endNumber THEN

                SET startNumber = startNumber + 1;

            END IF;

        END LOOP range_loop;

    END $$

DELIMITER ;

call count_rage(11,5);