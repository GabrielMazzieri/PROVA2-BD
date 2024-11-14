create schema QLojao2;
USE QLojao2;

CREATE TABLE cliente(
	id_cliente INT Primary KEY auto_increment,
    nome VARCHAR(30),
    cpf VARCHAR(11),
    rg VARCHAR(10),
    data_nasc DATE
);

INSERT INTO cliente(id_cliente, nome, cpf, rg, data_nasc) 
VALUES (3, "Julieta", "89786756", "21435365", "1959-02-02");

SELECT * FROM cliente; 

CREATE TABLE fornecedor(
	id_fornecedor INT primary key auto_increment,
	nome VARCHAR(30),
    setor VARCHAR(50)
);

INSERT INTO fornecedor(id_fornecedor, nome, setor)
VALUES(2, "Joana", "vendas");

UPDATE fornecedor SET setor = "Construção" WHERE id_fornecedor = 2;

select * from fornecedor;

CREATE TABLE produto(
	id_produto INT primary key auto_increment,
    nome varchar(50),
    preco INT,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) 
    references fornecedor(id_fornecedor)
    );
    
INSERT INTO produto(id_produto, nome, preco, id_fornecedor)
VALUES(2, "Concreto", 570, 2);

UPDATE produto SET id_fornecedor = 1 WHERE id_produto = 1;

select * from produto;

CREATE TABLE venda(
	id_venda INT primary key,
    id_produto INT,
	foreign key (id_produto) references produto(id_produto),
    id_cliente INT,
	foreign key (id_cliente) references cliente(id_cliente),
    data_venda date,
    qtd_vendas INT
); 

INSERT INTO venda(id_venda, id_produto, id_cliente, data_venda, 
qtd_vendas) 
values(3, 2, 3, "2024-9-20", 10);

select * from venda;

SELECT
	cliente.nome AS Nome_Cliente,
    produto.nome AS Nome_Produto,
    fornecedor.nome AS Nome_Fornecedor,
    venda.qtd_vendas AS Quantidade,
    venda.data_venda AS Data
FROM venda 
JOIN cliente ON venda.id_cliente = cliente.id_cliente
JOIN produto ON venda.id_produto = produto.id_produto
JOIN fornecedor ON produto.id_fornecedor = fornecedor.id_fornecedor
WHERE venda.data_venda BETWEEN '2024-09-17' AND '2024-10-26';

-- Soma total das vendas de todos os produtos
SELECT 
    SUM(produto.preco * venda.qtd_vendas) AS valor,
    'Soma Total das Vendas' AS descricao
FROM venda
INNER JOIN produto ON venda.id_produto = produto.id_produto

UNION

-- Soma das vendas por cliente
SELECT 
    SUM(produto.preco * venda.qtd_vendas) AS valor,
    CONCAT('Soma das Vendas por Cliente: ', cliente.nome) AS descricao
FROM venda
INNER JOIN produto ON venda.id_produto = produto.id_produto
INNER JOIN cliente ON venda.id_cliente = cliente.id_cliente
GROUP BY cliente.nome

UNION

-- Valor máximo de uma venda
SELECT 
    MAX(produto.preco * venda.qtd_vendas) AS valor,
    'Valor Máximo de Venda' AS descricao
FROM venda
INNER JOIN produto ON venda.id_produto = produto.id_produto

UNION

-- Valor mínimo de uma venda
SELECT 
    MIN(produto.preco * venda.qtd_vendas) AS valor,
    'Valor Mínimo de Venda' AS descricao
FROM venda
INNER JOIN produto ON venda.id_produto = produto.id_produto;


  
