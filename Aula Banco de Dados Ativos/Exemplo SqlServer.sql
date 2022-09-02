-- teste

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



drop trigger triggerdelete



create trigger triggerdelete 
on java
after delete
as 

declare @nome varchar(10)
select @nome = (select deleted.professor from deleted)

begin
	insert into log values ('Exclusão', 
		'O professor ' + @nome + ' foi excluído 
			da academia Java',
		GETDATE());
	PRINT(@nome + ' excluído com sucesso!')
end

select * from java
select * from log

insert into java values ('Fabrício')

delete from java
-------------------
drop trigger triggerinsert
create trigger triggerinsert
on java
after insert
as 
	declare @quantidade integer
	select @quantidade = (select count(professor) from java)
begin
	print('Quantidade de registros: ' + CONVERT(varchar(5), @quantidade));

	IF @quantidade <= 3
		begin
			insert into log values ('Inserção', 'Novo professor inserido'
				, GETDATE());
			print ('Professor inserido com sucesso!');
		end
	ELSE
		begin
			ROLLBACK;
			insert into log values ('Inserção', 'Um novo professor não pdoe ser inserido'
				, GETDATE());
			RAISERROR('INVALIDO - regra de 3 professor bloqueia a 
				inserção', 14, 1);
			RETURN;
		end
end

select * from java

insert into java values ('Fabrício 3')

create trigger triggerupdate
on java
after update
as
	declare @novo varchar(10)
	declare @antigo varchar(10)

	select @novo = (select inserted.professor from inserted)
	select @antigo = (select deleted.professor from deleted)

	IF(ROWCOUNT_BIG() = 0)--boa prática, que analisa o montante de dados alterados - se nada foi alterado, encerra a trigger
		return;

	IF @novo = @antigo
	begin
		raiserror('Sem alterações, pois os dados são os mesmos!', 14, 1);
		rollback transaction;
		insert into log values ('Alteração', 'Nada foi alterado pois o 
			nome do ('+ @novo +') professor é o mesmo'
			, getdate());
	end
	ELSE
	begin
		insert into log values ('Alteração', @antigo + ' alteado para ' + @novo
			, getdate())
	end

	select * from log
	select * from java
	update java set professor = 'Fabrício' where professor = 'Fabrício'
