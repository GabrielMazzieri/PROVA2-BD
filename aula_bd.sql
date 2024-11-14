-- DROP: Remove uma tabela ou esquema existente.
-- CREATE: Cria uma nova tabela ou esquema.
-- USE: Define o banco de dados em uso.

CREATE SCHEMA aula_bd; -- Cria o esquema 'aula_bd'.
USE aula_bd; -- Define 'aula_bd' como o banco de dados atual.

-- Tipos de Dados:
-- Texto: VARCHAR(n)
-- Número: INT(n)
-- Datas: DATE

-- ALTER TABLE: Adiciona/Modifica colunas em uma tabela.
-- ALTER TABLE usuario ADD COLUMN profissao VARCHAR(70); -- Exemplo de como adicionar uma coluna.

-- CRUD:
-- C = Create: Insere dados com INSERT.
-- R = Read: Lê dados com SELECT.
-- U = Update: Atualiza dados com UPDATE (use WHERE).
-- D = Delete: Remove dados com DELETE (use WHERE).

-- INSERT INTO usuario (nome, idade, data_nasc, profissao)
-- VALUES ("Marcio", "10", "2014-06-09", "Estudante"); -- Exemplo de inserção de dados.

-- SELECT * FROM usuario WHERE idade > 17; -- Exemplo de consulta.

-- INSERT INTO usuario (nome, idade, data_nasc, profissao)
-- VALUES ("Gabriel", "18", "2006-06-04", "Aprendiz"); -- Outro exemplo de inserção.

SET SQL_SAFE_UPDATES = 0; -- Permite updates e deletes sem WHERE.

-- UPDATE usuario SET idade = 19 WHERE nome = "Gabriel"; -- Exemplo de atualização.

-- DELETE FROM usuario WHERE profissao = "Estudante"; -- Exemplo de exclusão.

-- CONSTRAINTS: Regras nas colunas (ex. PRIMARY KEY).

CREATE table pessoas ( -- Cria a tabela 'pessoas'.
    id_pessoa INT PRIMARY KEY auto_increment not null, -- Chave primária auto_increment.
    nome VARCHAR(50),
    salario INT,
    data_nasc DATE
);

alter table pessoas add column profissao VARCHAR(100); -- Adiciona a coluna 'profissao' à tabela.

insert into pessoas (nome, salario, data_nasc, profissao) -- Insere um registro na tabela.
VALUES ("Gabriel", "1000", "2006-04-04", "Estudante");

-- FOREIGN KEY: Relaciona uma coluna a outra tabela.

CREATE table endereco ( -- Cria a tabela 'endereco'.
    id_endereco INT PRIMARY KEY auto_increment not null,
    rua VARCHAR(50),
    numero VARCHAR(10),
    pessoa_id int not null,
    foreign key (pessoa_id) references pessoas(id_pessoa) -- Relaciona com 'id_pessoa' de 'pessoas'.
);

insert into endereco (rua, numero, pessoa_id) -- Insere um registro na tabela 'endereco'.
VALUES ("R. Flores", "10", 999);

select * from pessoas; -- Seleciona todos os registros da tabela 'pessoas'.

-- JOIN: Combina dados de múltiplas tabelas.
SELECT pessoas.nome, endereco.* -- Retorna o nome e todos os dados de 'endereco'.
FROM pessoas
JOIN endereco ON pessoas.id_pessoa = endereco.pessoa_id; -- Junta as tabelas com base em 'id_pessoa'.

-- UNION: Combina resultados de duas ou mais consultas SELECT.
SELECT nome, salario, data_nasc, profissao -- Seleciona dados da tabela 'pessoas'.
FROM pessoas
WHERE salario > 1500 -- Filtro para salários acima de 1500.
UNION
SELECT pessoas.nome, 0 AS salario, endereco.rua, endereco.numero -- Seleciona com valores de 'endereco'.
FROM pessoas
JOIN endereco ON pessoas.id_pessoa = endereco.pessoa_id
WHERE endereco.numero IS NOT NULL; -- Filtro para endereços válidos.

-- AGGREGATION FUNCTIONS: Funções de agregação para cálculos.
SELECT MAX(salario) AS soma_salario FROM pessoas; -- Retorna o maior salário.

SELECT COUNT(*) AS qtd_pessoas FROM pessoas; -- Conta o número total de registros em 'pessoas'.

SELECT COUNT(*) AS qtd_pessoas FROM pessoas 
WHERE profissao = "Estudante"; -- Conta quantos registros têm 'profissao' como "Estudante".

SELECT CONCAT("O nome é: ", nome, ", e ele ganha R$", salario) 
AS descricao FROM pessoas; -- Concatena texto e valores de colunas para criar uma descrição.

-- TRIGGER: Executa uma ação antes/depois de um evento.
CREATE TRIGGER trPessoas 
    BEFORE UPDATE ON pessoas -- Antes de um UPDATE em 'pessoas'.
    FOR EACH ROW
    SET new.data_nasc = NOW(); -- Define 'data_nasc' como a data/hora atual.

DROP TRIGGER trPessoas; -- Remove o trigger 'trPessoas'.

UPDATE pessoas 
SET data_nasc = "2009-10-01" -- Atualiza 'data_nasc' de um registro.
WHERE id_pessoa = 1;

SELECT * FROM pessoas; -- Seleciona todos os dados de 'pessoas'.

INSERT INTO pessoas(nome, salario, data_nasc, profissao) 
VALUES ("Joaquim", 3000, "2009-09-19", "Caixa"); -- Insere um novo registro.

DELETE FROM pessoas WHERE id_pessoa = 2; -- Remove um registro com 'id_pessoa' igual a 2.

UPDATE pessoas
SET id_pessoa = 2 WHERE id_pessoa = 3; -- Atualiza o 'id_pessoa' de um registro.
