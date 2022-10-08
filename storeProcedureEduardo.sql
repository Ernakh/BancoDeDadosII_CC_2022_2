create database db_procedure;
use db_procedure;

create table usuario(
	idTeste integer not null primary key identity,
	nomeUsuario varchar(50)
)
go

insert into usuario values('Fabricio'), ('Eduardo');
go


create procedure teste as select 'Fabricio' as nome;
go

select *from usuario;
go

exec teste;
go

create table livros(
	idLivro integer primary key not null identity,
	titulo varchar(50)  not null,
	ano int, 
	autor varchar(50) not null,
	paginas int
)

insert into livros values('Antes só', 2015, 'Carina Gusmão', 185), ('Depois de você', 2022, 'Andrew Nolan', 325);
go

create procedure tituloAno as select titulo, ano from livros;
go

exec tituloAno;
go

exec sp_helptext tituloAno;
go

create procedure tituloAno2 with encryption as select titulo, ano from livros;
go

exec sp_helptext tituloAno2;
go

create procedure testeProcedure(@ano as int) as select titulo as 'Antes Só', ano as '2015' from livros where ano = @ano;
go

exec testeProcedure 2014
go

exec testeProcedure 2015
go

alter procedure testeProcedure(@ano as int, @titulo as varchar(50)) as begin select @ano, @titulo end;
go

exec testeProcedure @ano = 25, @titulo = 'Laranja'; 
go

drop procedure testeProcedure2;
go

create procedure testeProcedure2(@ano as int, @titulo as varchar(50)) as select titulo as 'Depois de você', ano as '2022' from livros where ano>=@ano and titulo like '%'+@titulo+'%';
go

exec testeProcedure2 @ano=2022, @titulo='Depois de você';
go

create procedure paginasImpressas(@qtd as int, @id as int) as select titulo as 'Depois de você', paginas*@qtd as '325' from livros where idLivro=@id;
go

exec paginasImpressas @id = 2, @qtd=10;
go




