SELECT * FROM appointments;

SELECT * FROM professionals;

SELECT professional.id, professional.name, `appoitmentTwo`.status 
    FROM professionals professional
        INNER JOIN appointments appointment
            ON appointment.professional_id = professional.id
        LEFT JOIN appointments appoitmentTwo
            ON appoitmentTwo.professional_id = professional.id AND appoitmentTwo.status = 'success'
    WHERE professional.active = 1 AND appoitmentTwo.id IS NULL