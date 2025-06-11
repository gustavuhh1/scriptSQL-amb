-- Empréstimos ativos
INSERT INTO Emprestimo (idEmprestimo, usuario_id, gestor_id, livro_id, data_emprestimo, data_devolucao, created_at, RFID_user) VALUES
(1, 1, 3, 6, NOW() - INTERVAL 5 DAY, NOW() + INTERVAL 10 DAY, NOW() - INTERVAL 5 DAY, 'RFID001'),
(2, 2, 3, 20, NOW() - INTERVAL 3 DAY, NOW() + INTERVAL 12 DAY, NOW() - INTERVAL 3 DAY, 'RFID002'),
(3, 3, 4, 11, NOW() - INTERVAL 1 DAY, NOW() + INTERVAL 15 DAY, NOW() - INTERVAL 1 DAY, 'RFID003'),

-- Empréstimos já devolvidos
(4, 4, 3, 1, NOW() - INTERVAL 20 DAY, NOW() - INTERVAL 10 DAY, NOW() - INTERVAL 20 DAY, 'RFID004'),
(5, 5, 2, 24, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 5 DAY, NOW() - INTERVAL 15 DAY, 'RFID005'),
(6, 1, 4, 7, NOW() - INTERVAL 30 DAY, NOW() - INTERVAL 20 DAY, NOW() - INTERVAL 30 DAY, 'RFID001'),
(7, 3, 3, 30, NOW() - INTERVAL 25 DAY, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 25 DAY, 'RFID003'),

-- Atrasos recentes (1-7 dias)
(8, 1, 3, 4, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 15 DAY, 'RFID001'),
(9, 2, 3, 8, NOW() - INTERVAL 20 DAY, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 20 DAY, 'RFID002'),

-- Atrasos médios (8-30 dias)
(10, 3, 4, 12, NOW() - INTERVAL 40 DAY, NOW() - INTERVAL 15 DAY, NOW() - INTERVAL 40 DAY, 'RFID003'),
(11, 6, 3, 16, NOW() - INTERVAL 50 DAY, NOW() - INTERVAL 25 DAY, NOW() - INTERVAL 50 DAY, 'RFID006'),

-- Atrasos graves (+30 dias)
(12, 7, 2, 23, NOW() - INTERVAL 90 DAY, NOW() - INTERVAL 60 DAY, NOW() - INTERVAL 90 DAY, 'RFID007'),
(13, 8, 4, 29, NOW() - INTERVAL 120 DAY, NOW() - INTERVAL 80 DAY, NOW() - INTERVAL 120 DAY, 'RFID008'),

-- Caso especial: obra rara com atraso
(14, 4, 3, 35, NOW() - INTERVAL 45 DAY, NOW() - INTERVAL 10 DAY, NOW() - INTERVAL 45 DAY, 'RFID004');


-- Registros de devolução para os empréstimos finalizados
INSERT INTO Devolucao (idFuncionario, emprestimo_id, data_entregue, data_devolucao, valor_multa, valor_multa_pago, gestor_id, RFID_user) VALUES
-- Devoluções sem multa
(3, 4, NOW() - INTERVAL 10 DAY, NOW() - INTERVAL 10 DAY, 0.00, 0.00, 3, 'RFID004'),
(2, 5, NOW() - INTERVAL 5 DAY, NOW() - INTERVAL 5 DAY, 0.00, 0.00, 2, 'RFID005'),

-- Devoluções com multa (atraso)
(4, 6, NOW() - INTERVAL 18 DAY, NOW() - INTERVAL 20 DAY, 15.50, 15.50, 4, 'RFID001'),
(3, 7, NOW() - INTERVAL 12 DAY, NOW() - INTERVAL 15 DAY, 8.75, 8.75, 3, 'RFID003');
