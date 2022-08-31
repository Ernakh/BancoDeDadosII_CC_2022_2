create database aulatrigger

create table java
(
	professor varchar(50) not null
)

create table dotnet
(
	professor varchar(50) not null
)

create table log
(
	id integer not null primary key identity,
	acao varchar(10) not null,
	descricao varchar(100),
	quando datetime not null
)

create trigger primeiratrigger
on java
after insert
as
begin
--function
	insert into log values('Inserção', 'Foi inserido um novo professor na academia Java', GETDATE());
	PRINT('Dados inseridos com sucesso!');
end


select * from java
select * from log

insert into java values ('Herysson')

create trigger triggerdelete
on java
after delete
as
begin
	insert into log values ('Exclusao', 'O professor foi excluido da academia Java', GETDATE());
	PRINT('Excluido com sucesso!')
end

delete from java

create trigger triggerupdate
on java
after update
as
begin
	insert into log values ('Alteracao', 'O professor foi alterado na academia Java', GETDATE());
	PRINT('Alterado com sucesso!')
end

-----------------------------------------
create trigger triggerdotnet
on dotnet
after insert
as
begin
--function
	insert into log values('Inserção', 'Foi inserido um novo professor na academia .NET', GETDATE());
	PRINT('Dados inseridos com sucesso!');
end


select * from java
select * from log

insert into dotnet values ('Ricardo')

create trigger triggerdeletenet
on dotnet
after delete
as
begin
	insert into log values ('Exclusao', 'O professor foi excluido da academia .NET', GETDATE());
	PRINT('Excluido com sucesso!')
end

delete from dotnet

create trigger triggerupdatenet
on dotnet
after update
as
begin
	insert into log values ('Alteracao', 'O professor foi alterado na academia .NET', GETDATE());
	PRINT('Alterado com sucesso!')
end