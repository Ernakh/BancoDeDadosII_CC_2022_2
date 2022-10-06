create database pessoal

create table pessoas
(
	id integer primary key identity,
	nome varchar(40),
	idade integer,
	genero varchar(15)
)

create trigger prefixo
on pessoas
after insert
as
	declare @id integer
	declare @genero varchar(15)
	declare @nome varchar(40)
	select @id = (select inserted.id from inserted)
	select @genero = (select inserted.genero from inserted)
	select @nome = (select inserted.nome from inserted)

	if(@genero = 'masculino')
		begin
			update pessoas set nome = ('Sr. ' + @nome)
			where pessoas.id = @id
		end
	else if (@genero = 'feminino')
		begin
			update pessoas set nome = ('Sra. ' + @nome)
			where pessoas.id = @id
		end
	else
		begin
			rollback;
		end

insert into pessoas values ('Pedro Pereira', 45, 'masculino')
insert into pessoas values ('Isadora Silva', 37, 'feminino')

select * from pessoas