CREATE DATABASE reservahotel



CREATE TABLE hospedes (
id_hospede SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE quartos (
id_quarto SERIAL PRIMARY KEY,
numero_quarto INT NOT NULL UNIQUE,
cama INT NOT NULL
);



CREATE TABLE reservas (
id_reserva SERIAL PRIMARY KEY,
data_reserva DATE NOT NULL DEFAULT CURRENT_DATE,
horario_reserva TIME NOT NULL,
data_inicio DATE NOT NULL,
data_termino DATE NOT NULL,
id_hospede INT NOT NULL,
id_quarto INT NOT NULL,
CONSTRAINT fk_hospedes FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
CONSTRAINT fk_qurtos FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
);


INSERTS:


INSERT INTO hospedes (nome, email) 
VALUES 
('caio', 'caio@gmail.com'),
('bernardo', 'benzinho@gmail.com'),
('Luiz', 'Luiz@gmail.com'),
('Andre', 'Andre@gmail.com'),
('luana', 'luana@gmail.com');


INSERT INTO quartos (numero_quarto, cama) VALUES 
(304, 5),
(305, 2),
(301, 1),
(302, 1),
(303, 2);


INSERT INTO reservas (id_hospede, id_quarto, horario_reserva, data_inicio, data_termino) VALUES 
(1,3,'23:15','2024-11-05','2024-11-06'),
(2,1,'11:30','2024-11-05','2024-11-06'),
(3,2,'15:30','2024-11-05','2024-11-06');


SELECT /* todos os clientes com reserva */
	r.id_reserva,
	h.nome,
	h.email,
	q.numero_quarto,
	q.cama AS quantidade_cama,
	r.data_inicio,
	r.data_termino,
	r.data_reserva,
	r.horario_reserva
FROM
	reservas r
JOIN
	hospedes h ON r.id_hospede = h.id_hospede
JOIN
	quartos q ON r.id_quarto = q.id_quarto

/* todos os clientes até quem não tem reserva */

SELECT 
    r.id_reserva,
    h.nome,
    h.email,
    q.numero_quarto,
    q.cama AS quantidade_cama,
    r.data_inicio,
    r.data_termino,
    r.data_reserva,
    r.horario_reserva
FROM
    reservas r
RIGHT JOIN
    hospedes h ON r.id_hospede = h.id_hospede
LEFT JOIN
    quartos q ON r.id_quarto = q.id_quarto


    /* todos os quartos que não foram reservados */
SELECT
    r.id_reserva,
    h.nome,
    h.email,
    q.numero_quarto,
    q.cama AS quantidade_cama,
    r.data_inicio,
    r.data_termino,
    r.data_reserva,
    r.horario_reserva
FROM
    quartos q
LEFT JOIN
    reservas r ON q.id_quarto = r.id_quarto

LEFT JOIN
    hospedes h ON r.id_hospede = h.id_hospede
WHERE
    r.id_reserva IS NULL;





