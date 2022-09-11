CREATE TABLE JAVA(
	PROFESSOR VARCHAR(50) NOT NULL
) 

CREATE TABLE DOTNET(
	PROFESSOR VARCHAR(50) NOT NULL
)

CREATE TABLE LOG(
	ID INTEGER NOT NULL PRIMARY KEY IDENTITY,
	ACAO VARCHAR(10) NOT NULL,
	DESCRICAO VARCHAR(100),
	QUANDO DATETIME NOT NULL
)

CREATE TRIGGER PRIMEIRATRIGGER
ON JAVA AFTER INSERT AS BEGIN
	--aqui no postrgres chamaria uma function
	INSERT INTO LOG VALUES('Inserção', 'Foi inserido um novo professor na academia Java', GETDATE());
	PRINT('Professor inserido com sucesso')
END

CREATE TRIGGER TRIGGERDELETE
ON JAVA AFTER DELETE AS BEGIN
	INSERT INTO LOG VALUES('Deleção', 'Foi deletado um professor da academia Java', GETDATE());
	PRINT('Professor removido com sucesso')
END

CREATE TRIGGER TRIGGERUPDATE
ON JAVA AFTER UPDATE AS BEGIN
	INSERT INTO LOG VALUES('Alteração', 'Foi alterado um professor da academia Java', GETDATE());
	PRINT('Professor alterado com sucesso')
END

INSERT INTO JAVA VALUES('Fabricio Tonetto')
SELECT * FROM LOG

UPDATE JAVA SET PROFESSOR = 'Fabricio Londero' WHERE PROFESSOR LIKE 'Fabricio Tonetto'
SELECT * FROM LOG

DELETE FROM JAVA
SELECT * FROM LOG

CREATE TRIGGER TRIGGERINSERTDOTNET
ON DOTNET AFTER INSERT AS BEGIN
	INSERT INTO LOG VALUES('Inserção', 'Foi inserido um professor da academia dotnet', GETDATE());
	PRINT('Professor inserido com sucesso')
END

CREATE TRIGGER TRIGGERUPDATEDOTNET
ON DOTNET AFTER UPDATE AS BEGIN
	INSERT INTO LOG VALUES('Alteração', 'Foi alterado um professor da academia dotnet', GETDATE());
	PRINT('Professor alterado com sucesso')
END

CREATE TRIGGER TRIGGERDELETEDOTNET
ON DOTNET AFTER DELETE AS BEGIN
	INSERT INTO LOG VALUES('Deleção', 'Foi deletado um professor da academia dotnet', GETDATE());
	PRINT('Professor removido com sucesso')
END

INSERT INTO DOTNET VALUES('Ana Paula')
SELECT * FROM LOG

UPDATE DOTNET SET PROFESSOR = 'Ana Paula Canal'
SELECT * FROM LOG

DELETE FROM DOTNET
SELECT * FROM LOG