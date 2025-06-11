-- Exemplares para livros (2 por livro)
INSERT INTO Exemplar (obra_id, situacao) VALUES
(2, 'disponivel'), (2, 'emprestado'),
(3, 'disponivel'), (3, 'manutencao'),
(4, 'disponivel'), (4, 'emprestado'),
(5, 'disponivel'), (5, 'descartado'),
(6, 'emprestado'), (6, 'disponivel'),
(7, 'manutencao'), (7, 'disponivel'),
(8, 'disponivel'), (8, 'disponivel'),
(10, 'emprestado'), (10, 'disponivel'),
(11, 'disponivel'), (11, 'emprestado'),
(12, 'disponivel'), (12, 'disponivel'),
(13, 'emprestado'), (13, 'disponivel'),
(14, 'descartado'), (14, 'disponivel'),
(15, 'disponivel'), (15, 'emprestado'),
(16, 'disponivel'), (16, 'disponivel'),
(17, 'emprestado'), (17, 'manutencao'),
(19, 'disponivel'), (19, 'disponivel'),
(20, 'emprestado'), (20, 'disponivel'),
(21, 'disponivel'), (21, 'disponivel'),
(22, 'manutencao'), (22, 'disponivel'),
(23, 'emprestado'), (23, 'disponivel'),
(24, 'disponivel'), (24, 'descartado'),
(25, 'disponivel'), (25, 'disponivel');

-- Exemplares únicos para revistas
INSERT INTO Exemplar (obra_id, situacao) VALUES
(9, 'disponivel'),
(18, 'emprestado');
