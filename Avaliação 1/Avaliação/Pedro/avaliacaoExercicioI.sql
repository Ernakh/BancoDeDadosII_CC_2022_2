--CREATE DATABASE db_entregas;

-- CREATEs

CREATE TABLE clientes
(
	id_cliente integer not null primary key identity,
	nome_cliente varchar(30) not null
);

CREATE TABLE produtos
(
	id_produto integer not null primary key identity,
	nome_produto varchar(30) not null,
	estoque integer not null default 0
);

CREATE TABLE entregas
(
	id_entrega integer not null primary key identity,
	fk_id_cliente int foreign key references clientes(id_cliente),
	fk_id_produto int foreign key references produtos(id_produto),
	quantidade int not null,
	localizacao varchar(30) not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio, fim)
) 
with (system_versioning = ON (history_table = dbo.entregasHistorico));

-- INSERTs

INSERT INTO clientes(nome_cliente) VALUES('Pedro');
INSERT INTO clientes(nome_cliente) VALUES('Gi');

INSERT INTO produtos(nome_produto, estoque) VALUES ('PC Gamer', 10);
INSERT INTO produtos(nome_produto, estoque) VALUES ('Mochila', 18);

INSERT INTO entregas(fk_id_cliente, fk_id_produto, quantidade, localizacao) VALUES (1, 1, 1, 'São Sepé');
INSERT INTO entregas(fk_id_cliente, fk_id_produto, quantidade, localizacao) VALUES (2, 2, 3, 'Ponta Porã');

-- ALTERs

UPDATE entregas SET localizacao = 'Santa Maria' WHERE id_entrega = 1;
UPDATE entregas SET localizacao = 'Cruz Alta' WHERE id_entrega = 2;

-- SELECTS para testagem

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM entregas;
SELECT * FROM dbo.entregasHistorico;

-- DROPs

--DROP TABLE entregas;
--ALTER TABLE entregas SET (system_versioning = OFF);
--DROP TABLE clientes;
--DROP TABLE produtos;
--DROP TABLE dbo.entregasHistorico;