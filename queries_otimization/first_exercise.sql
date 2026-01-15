-- +/- 333ms for user not found and without index
SELECT * FROM users WHERE email = 'user50000@email.com';

CREATE UNIQUE INDEX idx_user_email ON users (email);

-- +/- 3ms for the same case, but with index
SELECT * FROM users WHERE email = 'user50000@email.com';

DROP INDEX idx_user_email ON users;

/*
    Foi utilizado o tipo de índice único devido ao fato do tipo de dado
    ser um dado único por registro e por ser uma busca por igualdade,
    fazendo com que seja utilizado o tipo de índice "B-tree" no MySQL
    ao invés do hash por exemplo.
*/