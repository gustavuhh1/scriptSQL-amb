-- Empréstimos ativos e históricos
INSERT INTO Emprestimo (idEmprestimo, usuario_id, gestor_id, livro_id, data_emprestimo, data_devolucao, created_at, RFID_user) VALUES
-- Empréstimos ativos
(1, 1, 3, 4, now() - INTERVAL 5 DAY, now() + INTERVAL 10 DAY, now() - INTERVAL 5 DAY, 'RFID001'),
(2, 2, 3, 12, now() - INTERVAL 3 DAY, now() + INTERVAL 12 DAY, now() - INTERVAL 3 DAY, 'RFID002'),
(3, 3, 4, 7, now() - INTERVAL 1 DAY, now() + INTERVAL 15 DAY, now() - INTERVAL 1 DAY, 'RFID003'),

-- Empréstimos já devolvidos
(4, 4, 3, 2, now() - INTERVAL 20 DAY, now() - INTERVAL 10 DAY, now() - INTERVAL 20 DAY, 'RFID004'),
(5, 5, 2, 14, now() - INTERVAL 15 DAY, now() - INTERVAL 5 DAY, now() - INTERVAL 15 DAY, 'RFID005'),
(6, 1, 4, 5, now() - INTERVAL 30 DAY, now() - INTERVAL 20 DAY, now() - INTERVAL 30 DAY, 'RFID001'),
(7, 3, 3, 19, now() - INTERVAL 25 DAY, now() - INTERVAL 15 DAY, now() - INTERVAL 25 DAY, 'RFID003'),

-- Atrasos recentes (1-7 dias)
(8, 1, 3, 3, now() - INTERVAL 15 DAY, now() - INTERVAL 1 DAY, now() - INTERVAL 15 DAY, 'RFID001'),
(9, 2, 3, 5, now() - INTERVAL 20 DAY, now() - INTERVAL 3 DAY, now() - INTERVAL 20 DAY, 'RFID002'),

-- Atrasos médios (8-30 dias)
(10, 3, 4, 7, now() - INTERVAL 40 DAY, now() - INTERVAL 15 DAY, now() - INTERVAL 40 DAY, 'RFID003'),
(11, 6, 3, 10, now() - INTERVAL 50 DAY, now() - INTERVAL 25 DAY, now() - INTERVAL 50 DAY, 'RFID006'),

-- Atrasos graves (+30 dias)
(12, 7, 2, 14, now() - INTERVAL 90 DAY, now() - INTERVAL 60 DAY, now() - INTERVAL 90 DAY, 'RFID007'),
(13, 8, 4, 19, now() - INTERVAL 120 DAY, now() - INTERVAL 80 DAY, now() - INTERVAL 120 DAY, 'RFID008'),

-- Caso especial: obra rara com atraso
(14, 4, 3, 23, now() - INTERVAL 45 DAY, now() - INTERVAL 10 DAY, now() - INTERVAL 45 DAY, 'RFID004');

-- Registros de devolução para os empréstimos finalizados
INSERT INTO Devolucao (idFuncionario, emprestimo_id, data_entregue, data_devolucao, valor_multa, RFID_user) VALUES
-- Devoluções sem multa
(3, 4, now() - INTERVAL 10 DAY, now() - INTERVAL 10 DAY, 0.00,'RFID004'),
(2, 5, now() - INTERVAL 5 DAY, now() - INTERVAL 5 DAY, 0.00, 'RFID005'),

-- Devoluções com multa (atraso)
(4, 6, now() - INTERVAL 18 DAY, now() - INTERVAL 20 DAY, 15.50,'RFID001'),
(3, 7, now() - INTERVAL 12 DAY, now() - INTERVAL 15 DAY, 8.75,'RFID003');