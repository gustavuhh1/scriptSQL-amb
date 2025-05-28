create database biblio;
use biblio;
-- Tabela Usuario 	
CREATE TABLE Usuario 
( id INT PRIMARY KEY, 
tipo_usuario VARCHAR(20), 
Telefone TEXT, 
email TEXT(50), 
created_at DATETIME, 
nome VARCHAR(80), 
endereco VARCHAR(80), 
RFID VARCHAR(80) );

-- Tabela Funcionario 
CREATE TABLE Funcionario 
( idFuncionario INT PRIMARY KEY, 
nome TEXT, 
telefone TEXT, 
email TEXT, 
create_at DATETIME, 
Cargo TEXT, 
admin BOOLEAN );

-- Tabela Obra 
CREATE TABLE Obra 
( idLivro INT PRIMARY KEY, 
nome_obra TEXT, 
isbn VARCHAR(20) UNIQUE,
data_publicacao DATE, 
autor VARCHAR(80), 
tags VARCHAR(80), 
genero VARCHAR(80), 
created_at DATETIME, 
tipo_obra VARCHAR(80) );

-- Tabela Exemplar
CREATE TABLE Exemplar (
    idExemplar INT PRIMARY KEY AUTO_INCREMENT,
    obra_id INT NOT NULL,
    situacao ENUM('disponivel', 'emprestado', 'manutencao', 'descartado') DEFAULT 'disponivel',
    FOREIGN KEY (obra_id) REFERENCES Obra(idLivro)
);

-- Tabela Emprestimo 
CREATE TABLE Emprestimo 
( idEmprestimo INT PRIMARY KEY, 
usuario_id INT, 
gestor_id INT, 
livro_id INT, 
data_emprestimo DATETIME, 
data_devolucao DATETIME, 
created_at DATETIME, 
RFID_user VARCHAR(80), 
FOREIGN KEY (usuario_id) REFERENCES Usuario(id), 
FOREIGN KEY (gestor_id) REFERENCES Funcionario(idFuncionario), 
FOREIGN KEY (livro_id) REFERENCES Exemplar(idExemplar) );

-- Tabela Devolucao 
CREATE TABLE Devolucao 
( idFuncionario INT, 
emprestimo_id INT, 
data_entregue DATETIME, 
data_devolucao DATETIME, 
valor_multa DECIMAL(10,2),
valor_multa_pago DECIMAL(10,2) 
gestor_id INT, 
RFID_user VARCHAR(80), 
PRIMARY KEY (idFuncionario, emprestimo_id), 
FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario), 
FOREIGN KEY (emprestimo_id) REFERENCES Emprestimo(idEmprestimo)
)