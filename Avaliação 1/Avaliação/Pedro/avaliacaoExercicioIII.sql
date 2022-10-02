--CREATE DATABASE db_prefixos;

CREATE TABLE clientes
(
	id_cliente integer not null primary key identity,
	nome_cliente varchar(30) not null,
	sexo_cliente varchar(9) not null
);
GO

-- TRIGGER

CREATE trigger adiciona_prefixo
ON clientes
INSTEAD OF INSERT
AS
BEGIN
	DECLARE -- declara as variáveis que serão usadas
	@sexo varchar(9),
	@nome varchar(30)

	SELECT @sexo = sexo_cliente, @nome = nome_cliente FROM INSERTED -- valores vêm da tabela temporária dos valores que estão sendo inderidos

	IF (@sexo = 'Masculino')
	BEGIN
		SELECT @nome = 'Sr. ' + @nome
		INSERT INTO clientes(nome_cliente, sexo_cliente) 
		VALUES (@nome, @sexo);
	END

	ELSE IF (@sexo = 'Feminino')
	BEGIN
		SELECT @nome = 'Sra. ' + @nome
		INSERT INTO clientes(nome_cliente, sexo_cliente) 
		VALUES (@nome, @sexo);
	END

	ELSE
	BEGIN
		RAISERROR('ERRO!', 10, 11)
	END

END
GO

-- INSERT

INSERT INTO clientes(nome_cliente, sexo_cliente) 
VALUES ('Pedro', 'Masculino');

INSERT INTO clientes(nome_cliente, sexo_cliente) 
VALUES ('Rita', 'Feminino');

SELECT * FROM clientes;

-- DROPs

DROP TABLE clientes;
DROP TRIGGER adiciona_prefixo;
