-- Funcionários administrativos
INSERT INTO Funcionario (idFuncionario, nome, telefone, email, create_at, Cargo, admin) VALUES
(1, 'Carlos Silva', '(11) 98765-4321', 'carlos.silva@biblio.com', now(), 'Bibliotecário Chefe', TRUE),
(2, 'Ana Oliveira', '(11) 99876-5432', 'ana.oliveira@biblio.com', now(), 'Assistente de Biblioteca', TRUE),
(3, 'Pedro Santos', '(11) 98765-1234', 'pedro.santos@biblio.com', now(), 'Atendente', FALSE),
(4, 'Mariana Costa', '(11) 97654-3210', 'mariana.costa@biblio.com', now(), 'Estagiário', FALSE);

-- Usuários da biblioteca
INSERT INTO Usuario (id, tipo_usuario, Telefone, email, created_at, nome, endereco, RFID) VALUES
(1, 'Estudante', '(11) 91234-5678', 'joao.silva@email.com', now(), 'João Silva', 'Rua das Flores, 123 - São Paulo', 'RFID001'),
(2, 'Professor', '(11) 92345-6789', 'maria.oliveira@email.com', now(), 'Maria Oliveira', 'Av. Paulista, 1000 - São Paulo', 'RFID002'),
(3, 'Público', '(11) 93456-7890', 'lucas.souza@email.com', now(), 'Lucas Souza', 'Rua Augusta, 500 - São Paulo', 'RFID003'),
(4, 'Estudante', '(11) 94567-8901', 'ana.pereira@email.com', now(), 'Ana Pereira', 'Rua Oscar Freire, 200 - São Paulo', 'RFID004'),
(5, 'Professor', '(11) 95678-9012', 'carlos.fernandes@email.com', now(), 'Carlos Fernandes', 'Alameda Santos, 400 - São Paulo', 'RFID005'),
(6, 'Estudante', 'Celular: (11) 91111-1111, Residencial: (11) 2222-2222', 'aluno1@escola.com', now(), 'Fernando Costa', 'Rua das Acácias, 100', 'RFID006'),
(7, 'Professor', '(11) 93333-3333 (Celular)', 'prof.maria@faculdade.edu', now(), 'Maria Fernandes', 'Av. das Nações, 200', 'RFID007'),
(8, 'Público', '(11) 94444-4444', 'joao.santos@gmail.com', now(), 'João Santos', 'Rua das Flores, 300', 'RFID008');