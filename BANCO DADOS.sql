--comando para seleção
SELECT * FROM produtos ORDER BY id ASC;

-- DDL - linguagem de definição de  dados (interagir com a tabela inteira)
-- criação de tabala
CREATE TABLE produtos(
	id INT PRIMARY KEY NOT NULL,
	nome VARCHAR(255),
	preco DECIMAL(10,2)
);

-- exluir uma tabela
DROP TABLE produtos;

-- alterar tabela 
ALTER TABLE produtos ADD descricao TEXT; 

-- DML - linguagem de manipulação de dados (mexer com linha )
-- Inserir dado na tabela 
INSERT INTO  produtos(id, nome,preco) VALUES
(1, 'Nescau Radical', 9.00),
(2, 'Yakult activia', 3.00),
(3, 'Alpino amargo' , 5.00),
(4,  'Miojo Monica' , 11.00);

--Alterar dado da tabela
UPDATE produtos SET preco = 15.00 where id=1;
UPDATE produtos SET nome = 'Toddy'where nome LIKE 'Nescau Radical';
UPDATE produtos SET descricao='Armazenar em ambiente gelado'
where id =2 or id=3;
UPDATE produtos SET descricao='Promoção'
where preco<5.00;


--Daletar dado de um tabela
DELETE FROM produtos WHERE nome LIKE 'Alpino amargo';
DELETE FROM produtos WHERE id = 1;


--Comandos DQL (Linguagem de consulta de da dados)
-- selecionar todos(*) produtos, ordene ascendete
SELECT * FROM produtos ORDER BY id ASC;

--Ordenar pelo preço descrente( menor para maior  )
SELECT * FROM produtos ORDER BY preco ASC;

--Ordenar pelo preço descrente( maior para menor )
SELECT * FROM produtos ORDER BY preco DESC;

--Selecionar Colunas
SELECT nome , preco FROM produtos ORDER BY id;

--Selecionar produtos maior que R$ 4,00
SELECT nome , preco FROM produtos WHERE preco > 4.00 ;

--Selecionar produtos mais caro 
SELECT MAX (preco) AS titulo FROM produtos;

SELECT  preco , nome  FROM produtos  ORDER BY preco DESC LIMIT 1;

-- simulando busca por nome exato
SELECT * FROM produtos WHERE nome LIKE 'Toddy';

-- busca polos primeiros caractres, o resto não importa
SELECT * FROM produtos WHERE nome LIKE 'To%';

-- A parte anterior não importa, busca o ultimo
SELECT * FROM produtos WHERE nome LIKE '%Moni';

--busca por qualquer parte  do nome 
SELECT * FROM produtos WHERE nome LIKE '% %';

-- fase 2 ------------------------------------
-- Criando tabela Funcinonário----------------
CREATE TABLE funcionario(
id SERIAL  PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	data_nasc DATE,
	sexo CHAR(1),
	salario DECIMAL (10,2),
	ativo BOOLEAN
);

select * from funcionario;

INSERT INTO fucionario(nome, data_nasc, sexo, salario, ativo ) VALUES
('Bob','1990-05-15','M',200.00, true),
('Auguto','200-01-01','M',1500.00 , false),
('Joanir','1995-10-02','F',1800.00 , true),
('Elisa','1970-04-011','F',1900.00 , true);
--Selecionar funcionario que nasceram após010-01-1992 
select * from funcionario WHERE data_nasc > '1992-01-01';
--Selecionar funcionario em um periodo 
select nome,  data_nasc from funcionario 
WHERE data_nasc  BETWEEN '1990-01-01'AND'1997-01-01';

--Contabilzar
SELECT sexo, 
COUNT(*) AS total_pessoas, 
AVG (salario) AS media_salarial
FROM funcionario GROUP BY sexo;


--1. Criar uma tabela "Clientes" com campos para ID, Nome e Email.
--2. Adicionar uma coluna "telefone" à tabela "clientes" usando ALTER TABLE.
--3. Remover a coluna "Email" da tabela "clientes" usando ALTER TABLE.
--4. Criar uma tabela "Item" com campos para ID, Nome e Preço.
--5. Inserir ua novo cliente na tabela "clientes" INSERT. 
--6. Inserir 3 novos itens na tabela "Itens" INSERT. 
--7.Atualizar o nome de um  cliente na tabela "clientes" UPDATE.
--8.Atualizar o de um produto na tabela "Produtos" UPDATE.
--9. Excluir um cliente da tabela "clientes" DELETE.
--10.Excluir um produto da tabela "Produtos" DELETE.



--1. Criar uma tabela "Clientes" com campos para ID, Nome e Email
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Email VARCHAR(255)
);






--2. Adicionar uma coluna "telefone" à tabela "clientes" usando ALTER TABLE.
ALTER TABLE Clientes
ADD telefone VARCHAR(20);




--3. Remover a coluna "Email" da tabela "clientes" usando ALTER TABLE.
ALTER TABLE Clientes
DROP COLUMN Email;


--6. Inserir 3 novos itens na tabela "Itens" INSERT.
INSERT INTO Item (ID, Nome, Preco)
VALUES (1, 'Item1', 10.99);

INSERT INTO Item (ID, Nome, Preco)
VALUES (2, 'Item2', 20.49);

INSERT INTO Item (ID, Nome, Preco)
VALUES (3, 'Item3', 15.75);

--7.Atualizar o nome de um  cliente na tabela "clientes" UPDATE.
UPDATE Clientes
SET Nome = 'NovoNomeCliente'
WHERE ID = 1;

--8.Atualizar o de um produto na tabela "Produtos" UPDATE.
UPDATE Item
SET Preco = 25.99
WHERE ID = 2;



--9. Excluir um cliente da tabela "clientes" DELETE.
DELETE FROM Clientes
WHERE ID = 1;


--10.Excluir um produto da tabela "Produtos" DELETE
DELETE FROM Item
WHERE ID = 3;


SELECT * FROM Clientes ;

SELECT * FROM Item;
 
 drop table estados
CREATE TABLE estados(
id_estado SERIAL PRIMARY KEY,
	nome_estado VARCHAR (50) NOT NULL,
	sigla CHAR(2)
);

CREATE TABLE cidades(
	id_cidade SERIAL PRIMARY KEY,
	nome_cidade VARCHAR (50) ,
	cep VARCHAR(50),
	id_estado INT REFERENCES estados (id_estado)
);

drop table estado
INSERT INTO estados (id_estado, nome_estado , sigla) VALUES
(1,'Parana', 'PR'),
(2,'SÃO PAULO','SP'),
(3,'MATO GORSO','MT');

drop table cidade
INSERT INTO cidades (id_cidade, nome_cidade ,cep,id_estado ) VALUES
(10,'marilena', '87970-000',1),
(11,'terra rica', '87890-000',1),
(12,'Osasco	', '06000-000',2),
(13,'Alta Floresta	', '78580-000',3);

SELECT * FROM estados;

SELECT * FROM cidades;



SELECT cidades.nome_cidade, estados.nome_estado
FROM estados INNER JOIN cidades
ON cidades.id_estado = estados.id_estado;




SELECT cidades.nome_cidade, estados.sigla,cidades.cep
FROM estados INNER JOIN cidades
ON cidades.id_estado = estados.id_estado
WHERE estados.sigla LIKE 'PR'
ORDER BY cidades.nome_cidade ASC;



SELECT estados.nome_estado,COUNT(cidades.id_cidade)AS total_cidades
FROM estados INNER JOIN cidades
ON estados.id_estado = cidades.id_estado
GROUP BY estados.nome_estado
ORDER BY total_cidades DESC;

drop table pessoa
CREATE TABLE pessoa(
	id_pessoa SERIAL PRIMARY KEY,
	nome_pessoa VARCHAR(60),
	data_nascimento DATE,
	sexo CHAR(1),
	estado_civli VARCHAR(60),
	profissao VARCHAR(60),
	id_cidade INT REFERENCES cidades(id_cidade)
);

INSERT INTO pessoa 
(id_pessoa, nome_pessoa ,data_nascimento,sexo ,estado_civli ,profissao,id_cidade)
VALUES
(1,'Bob','1990-05-15','M','soltero','Agronomia',10),
(2,'Auguto','200-01-01','M','casado' ,'Fisioterapia',11),
(3,'Joanir','1995-10-02','F','soltero','Engenharia ',12),
(4,'Elisa','1970-04-11','F', 'casada','Zootecnia',13);

SELECT * FROM pessoa;



SELECT pessoa.nome_pessoa,cidades.nome_cidade
FROM pessoa INNER JOIN cidades
ON pessoa.id_cidade = cidades.id_cidade
INNER JOIN estados 
ON cidades.id_estado = estados.id_estado;



SELECT * FROM estados;
SELECT * FROM cidades;
SELECT * FROM pessoa;



SELECT pessoa.nome_pessoa,cidades.nome_cidade,pessoa.profissao
FROM pessoa INNER JOIN cidades
ON pessoa.id_cidade = cidades.id_cidade;

--1 -Selecine todas as pessoas

--2 -Selecine todas as pessoas do sexo Maculino "m";

--3 -Selecine todas as pessoas com estado  civil solteiro;

--4 -Selecine as pessoas e sua profissão

--5 -Selecine todas as pessoas que nasceram estre 1980-01-01 e 2000-01-01

--6 -Selecine todas as pessoas do Estado de São Paulo


--1 -Selecine todas as pessoas
SELECT pessoa.nome_pessoa FROM pessoa;

--2 -Selecine todas as pessoas do sexo Maculino "m";
SELECT pessoa.nome_pessoa FROM pessoa WHERE sexo = 'm';

--3 -Selecine todas as pessoas com estado  civil solteiro;
SELECT * FROM pessoa WHERE  estado_civli = 'solteiro';

--4 -Selecine as pessoas e sua profissão
SELECT nome,profissao FROM pessoa;

--5 -Selecine todas as pessoas que nasceram estre 1980-01-01 e 2000-01-01
SELECT nome_pessoa FROM pessoa WHERE data_nascimento BETWEEN '1980-01-01' AND '2000-01-01';

--6 -Selecine todas as pessoas do Estado de São Paulo
SELECT pessoa.nome_pessoa FROM pessoa WHERE id_cidade = 'São Paulo';

