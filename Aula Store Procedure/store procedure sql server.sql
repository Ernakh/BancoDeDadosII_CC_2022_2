CREATE PROCEDURE nome_procedimento
	(@Parâmetro Tipo_dados)
AS
	Bloco de códigos



CREATE PROCEDURE procedure1
AS
SELECT 'Fabrício Tonetto Londero' AS Nome

exec procedure1



CREATE PROCEDURE p_TituloAno
AS
SELECT titulo, ano
FROM Livro
Para executar:
EXEC p_TituloAno

--visualizar conteudo de uma procedure
EXEC sp_helptext procedure1


CREATE PROCEDURE procedure2
WITH ENCRYPTION
AS
SELECT 'Fabrício Tonetto Londero' AS Nome

exec procedure2
EXEC sp_helptext procedure2



--alter
ALTER PROCEDURE
ALTER PROCEDURE nome_procedimento
bloco de código da sp


CREATE PROCEDURE procedure3 (@par1 as int)
AS
SELECT @par1

exec procedure3 22

select * from pessoas 

create PROCEDURE pessoasIdade
(@idade INT)
AS
SELECT nome 
FROM pessoas
WHERE idade = @idade

EXEC pessoasIdade 31


create PROCEDURE pessoasIdadeAlt
(@idade INT, @altura INT)
AS
SELECT nome 
FROM pessoas
WHERE idade = @idade and altura = @altura

EXEC pessoasIdadeAlt 31, 178

EXEC pessoasIdadeAlt @idade=31, @altura =178

-----------


create table livros
(
	id integer primary key identity,
	titulo varchar(50) not null,
	ano int,
	autor varchar(50) not null,
	paginas int,
	valor decimal(10,2)
)


alter  PROCEDURE p_TituloAno (@ANO INT, @TITULO varchar(50))
AS
SELECT titulo AS 'Livro', ano AS 'Ano Publicacao'
FROM Livros
WHERE ano=@ANO and 
	titulo like '%'+@titulo+'%'

select * from livros

insert into livros values ('Harry Potter', 2022, 'aaaa', 200)

EXEC  p_TituloAno @ANO= 2022, @TITULO = 'Potter'



-----------

drop procedure pessoasOutPut

create PROCEDURE pessoasOutPut
(@idade int, @altura INT OUTPUT)
AS
SELECT @altura = altura 
FROM pessoas
WHERE idade = @idade

EXEC pessoasOutPut 31, 1

DECLARE @valor AS INT = 15
EXEC pessoasOutPut 31, @valor OUTPUT
PRINT @valor


