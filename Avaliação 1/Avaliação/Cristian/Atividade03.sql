create database ex03 

create table pessoa
(
	id_pessoa integer not null primary key identity,
	nome varchar(45),
	sexo varchar(20)
)


select * from pessoa 

insert into pessoa (nome, sexo)
values ('João', 'masculino')

insert into pessoa (nome, sexo)
values ('Maria', 'feminino')

create trigger triggerinsert
on pessoa
after insert
as
	
	 declare @sexo integer
     declare @masculino integer

     select @sexo = (select inserted.sexo from inserted)
    
	
	IF @sexo = @masculino
		begin
			insert into pessoa values ('Inserção', ' Sr. (+ @nome + )');
		end

	 ELSE
		begin
		insert into pessoa values ('Inserção', ' Sra. (+ @nome + )');
		end
end

select * from pessoa 