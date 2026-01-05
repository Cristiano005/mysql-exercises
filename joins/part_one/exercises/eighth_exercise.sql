SELECT * FROM professionals;

SELECT * FROM appointments;

SELECT professionals.id FROM professionals WHERE professional_id NOT IN (SELECT professional.id FROM professionals professional 
    LEFT JOIN appointments appointment
        ON appointment.professional_id = professional.id
    WHERE appointment.status = 'completed'
)