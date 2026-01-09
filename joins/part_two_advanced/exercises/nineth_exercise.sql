SELECT * FROM appointments;

SELECT 
    professional.name, COUNT(*) AS aprovation_percentage
FROM professionals professional
    
    INNER JOIN appointments appointment
        ON appointment.professional_id = professional.id

WHERE professional.active = 1 

GROUP BY professional.id, professional.name

HAVING COUNT(*) >= 10 AND ( (
    SELECT COUNT(*) FROM appointments WHERE status = 'success' AND professional_id = professional.id
) / COUNT(*) ) * 100 >= 80; 

-- SELECT * FROM appointments WHERE professional_id = 1 AND status = 'canceled';

-- SELECT COUNT(*) FROM appointments WHERE status = 'canceled' AND professional_id = 2