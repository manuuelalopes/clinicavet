CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(150) NULL,
    data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabela animais
CREATE TABLE animais (
    id_animal SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(20) NOT NULL,
    raca VARCHAR(30) NULL,
    data_nasc SMALLINT NULL CHECK (data_nasc BETWEEN 1900 AND 2100),
    data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_animais_clientes 
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. Tabela consultas
CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_animal INT NOT NULL,
    data_consulta DATE NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_consultas_animais 
        FOREIGN KEY (id_animal) REFERENCES animais(id_animal) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO clientes (nome, telefone, email) VALUES ('Carlos Eduardo', '19991112233', 'carlos.edu@email.com');
INSERT INTO clientes (nome, telefone, email) VALUES ('Mariana Souza', '19992223344', 'mariana.souza@email.com');
INSERT INTO clientes (nome, telefone, email) VALUES ('Roberto Alves', '19993334455', 'roberto.alves@email.com');
INSERT INTO clientes (nome, telefone, email) VALUES ('Fernanda Lima', '19994445566', 'fernanda.lima@email.com');
INSERT INTO clientes (nome, telefone, email) VALUES ('Lucas Mendes', '19995556677', 'lucas.mendes@email.com');

-- Inserindo 8 Animais
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (1, 'Thor', 'Cachorro', 'Golden Retriever', 2020);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (1, 'Luna', 'Gato', 'Persa', 2022);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (2, 'Mel', 'Cachorro', 'Poodle', 2019);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (3, 'Rex', 'Cachorro', 'Pastor Alemão', 2021);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (3, 'Mingau', 'Gato', 'Siamês', 2023);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (4, 'Bob', 'Cachorro', 'Vira-lata', 2018);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (4, 'Pipoca', 'Hamster', 'Sírio', 2024);
INSERT INTO animais (id_cliente, nome, especie, raca, data_nasc) VALUES (5, 'Max', 'Cachorro', 'Bulldog', 2022);

-- Inserindo 10 Consultas
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (1, '2026-08-10', 'Vacinação anual V10 e exame de rotina.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (2, '2026-08-15', 'Limpeza de tártaro e avaliação bucal.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (3, '2026-09-01', 'Consulta dermatológica por alergia na pele.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (4, '2026-09-10', 'Check-up geral e vermifugação.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (5, '2026-09-18', 'Tratamento de otite no ouvido esquerdo.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (6, '2026-10-02', 'Retorno pós-operatório de castração.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (7, '2026-10-12', 'Avaliação de perda de apetite e suplementação.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (8, '2026-10-20', 'Exame de sangue preventivo.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (1, '2026-11-01', 'Reavaliação ortopédica da pata traseira.');
INSERT INTO consultas (id_animal, data_consulta, descricao) VALUES (3, '2026-11-03', 'Acompanhamento da resposta ao tratamento dermatológico.');
--------------------------------- lista todos os animais com o nome do  Dono
SELECT 
    a.nome AS nome_animal,
    a.especie,
    a.raca,
    c.nome AS nome_dono,
    c.telefone AS contato_dono
FROM animais a
JOIN clientes c ON a.id_cliente = c.id_cliente
ORDER BY a.nome ASC;

-- lista toda as consultas ordenadas por data 
SELECT 
    co.id_consulta,
    co.data_consulta,
    an.nome AS nome_animal,
    an.especie,
    cl.nome AS dono,
    co.descricao
FROM consultas co
JOIN animais an ON co.id_animal = an.id_animal
JOIN clientes cl ON an.id_cliente = cl.id_cliente
ORDER BY co.data_consulta ASC;