

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
	insert into log values ('Inserção', 
		'Foi inserido um novo professor na academia Java', GETDATE());
		PRINT('Dados Inseridos com sucesso!');
end

select * from java
select * from log

INSERT INTO JAVA values('Herysson')

create trigger triggerdelete 
on java
after delete
as 
begin
	insert into log values ('Exclusão', 'O professor foi excluído da academia Java',
	GETDATE());
	PRINT('Excluído com sucesso!')
end

delete from java

select * from java
select * from log

