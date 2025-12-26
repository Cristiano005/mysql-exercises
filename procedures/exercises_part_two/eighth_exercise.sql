
DELIMITER $$

    CREATE PROCEDURE calc_stats(
        IN numberOne int unsigned, 
        IN numberTwo int unsigned, 
        OUT numberSum int unsigned, 
        OUT greatestNumber int unsigned, 
        OUT leastNumber int unsigned
    )

    BEGIN

        SET numberSum = numberOne + numberTwo;
        SET greatestNumber = GREATEST(numberOne, numberTwo);
        SET leastNumber = LEAST(numberOne, numberTwo);

    END $$

DELIMITER ;

-- drop procedure calc_stats;

call calc_stats(15, 16, @numberSum, @greatestNumber, @leastNumber);

SELECT @numberSum, @greatestNumber, @leastNumber;