
create table grupo
(
	id_grupo integer not null primary key identity,
	nome varchar(45)
)


create table descobridor
(
	id_descobridor integer not null primary key identity,
	nome varchar(45)
)

create table eras
(
	id_eras integer not null primary key identity,
	nome varchar(45),
	inicio INT,
	final INT
)


create table pais
(
	id_pais integer not null primary key identity,
	nome varchar(45)
)

create table dinossauro
(
	id_dinossauro integer not null primary key identity,
	nome varchar(45),
	toneladas INT,
	ano_descoberta INT,
	inicio_ano INT,
	final_ano INT,
	fk_grupo integer,
	fk_descobridor integer,
	fk_eras integer,
	fk_pais integer,
	foreign key (fk_grupo) references grupo(id_grupo),
	foreign key (fk_descobridor) references descobridor(id_descobridor),
	foreign key (fk_eras) references eras(id_eras),
	foreign key (fk_pais) references pais(id_pais)
)

select * from grupo;
select * from descobridor;
select * from eras;
select * from pais;
select * from dinossauro;

create triggers teste_ano
on eras
after update
as
	declare @ini integer
	declare @fim integer

	select @ini = (select inserted.inicio from inserted)
	select @fim = (select inserted.final from inserted)

	IF @ini <= @fim 
		begin
			print ('Era inserida com sucesso!');
		end
	ELSE
			rollback;
			RAISERROR('INVALIDO - Era incorreta');
			RETURN;
		end
end