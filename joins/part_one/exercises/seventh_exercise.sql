SELECT * FROM professionals;

SELECT * FROM appointments

SELECT professional.name, appointment.status FROM professionals professional
    INNER JOIN appointments appointment
        ON appointment.professional_id = professional.id