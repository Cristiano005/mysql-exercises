DELETE FROM professionals WHERE id = 12;

SELECT * FROM professionals;

SELECT * FROM appointments

SELECT appointment.id AS appointmentId, professional.id AS professionalId
FROM appointments appointment
    LEFT JOIN professionals professional 
        ON professional.id = appointment.professional_id
    WHERE professional.id IS NULL 

