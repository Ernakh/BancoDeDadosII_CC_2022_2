create database people

create table pessoas
(
	id integer primary key identity,
	nome varchar(50) not null,
	anoNasc integer,
	maioridade varchar(3)
)
select * from pessoas

create trigger triggeridade
on pessoas
after insert
as
	declare @idade integer
	select @idade = (select(2022 - anoNasc) from inserted)

	if(@idade < 18)
	begin
		update pessoas set maioridade = 'Não'
		where pessoas.id = (select inserted.id from inserted
									join pessoas on inserted.id = pessoas.id)
	end
	else
	begin
		update pessoas set maioridade = 'Sim'
		where pessoas.id = (select inserted.id from inserted
									join pessoas on inserted.id = pessoas.id)
	end



drop trigger triggeridade

delete from pessoas

insert into pessoas (nome, anoNasc) values ('Leo', 2005)
insert into pessoas (nome, anoNasc) values('Dani', 1999)
insert into pessoas (nome, anoNasc) values('Julio', 2008)

select * from pessoas