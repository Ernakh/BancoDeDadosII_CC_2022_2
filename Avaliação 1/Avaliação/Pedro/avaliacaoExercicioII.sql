-- CREATE DATABASE db_vendas;

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

CREATE TABLE vendas
(
	id_venda integer not null primary key identity,
	fk_id_cliente integer foreign key references clientes(id_cliente),
	fk_id_produto integer foreign key references produtos(id_produto),
	quantidade integer not null
);

-- INSERTs

INSERT INTO clientes(nome_cliente) VALUES('Bob');
INSERT INTO clientes(nome_cliente) VALUES('Maria');

INSERT INTO produtos(nome_produto, estoque) VALUES ('Caneca', 100);
INSERT INTO produtos(nome_produto, estoque) VALUES ('Camisa', 75);

SELECT * FROM produtos; -- mostra os valores iniciais
GO

-- TRIGGER

CREATE trigger tgr_calcula_estoque
ON vendas
AFTER INSERT
AS
BEGIN
	DECLARE -- declara as variáveis que serão usadas
	@valor_venda integer,
	@id_mod integer,
	@print_estoque integer

	SELECT @valor_venda = quantidade, @id_mod = fk_id_produto FROM INSERTED -- valores vêm da tabela temporária dos valores que estão sendo inderidos

	UPDATE produtos 
	SET estoque = (estoque - @valor_venda) 
	WHERE id_produto = @id_mod -- altera o valor na local correto
	
	SELECT @print_estoque = estoque FROM produtos WHERE id_produto = @id_mod -- pega o valor da tabela alterada

	PRINT 'Estoque do produto após operação: ' + CAST(@print_estoque AS NVARCHAR(100)) -- mostra a mensagem de sucesso

END
GO

INSERT INTO vendas(fk_id_cliente, fk_id_produto, quantidade) 
VALUES (1, 1, 10);
INSERT INTO vendas(fk_id_cliente, fk_id_produto, quantidade) 
VALUES (2, 2, 20);

-- SELECTs

SELECT * FROM clientes;
SELECT * FROM produtos; -- executar essa linhas para checar o update
SELECT * FROM vendas;

-- DROPs

DROP TABLE vendas;
DROP TABLE clientes;
DROP TABLE produtos;
DROP TRIGGER tgr_calcula_estoque;

