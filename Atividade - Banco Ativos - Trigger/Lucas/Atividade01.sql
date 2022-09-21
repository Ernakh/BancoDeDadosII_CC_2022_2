create database Atividade01

use Atividade01

create table pessoa
(
	id integer not null identity primary key,
	nome varchar(50) not null,
	ano integer not null,
	maioridade varchar(3)
)

delete from pessoa

drop trigger pessoatrigger

create trigger pessoatrigger
on pessoa
after insert
as

	declare @ano integer
	select @ano = (select inserted.ano from inserted)
	
	IF @ano > 17
	begin
		update pessoa set maioridade = 'sim'  where pessoa.id = (select inserted.id from inserted
												  join pessoa
												  on inserted.id = pessoa.id)
	end
	ELSE
	begin
		update pessoa set maioridade = 'nao' where pessoa.id = (select inserted.id from inserted
												  join pessoa
												  on inserted.id = pessoa.id)
	end


	insert into pessoa(nome, ano) values ('Lucas', 12)

	insert into pessoa(nome, ano) values ('Tobias ', 21)
	
	insert into pessoa(nome, ano) values ('Jessica', 71)

	insert into pessoa(nome, ano) values ('Cirila', 6)
	
	select * from pessoa