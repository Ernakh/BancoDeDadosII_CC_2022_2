

create database trabalhoDinossauro

create table dinossauro
(
      id_dinossauro int not null primary key identity,
      nome varchar(50),
      toneladas int,
      anoDescoberta int,
      anoInicio int,
      anoFim int,
      fk_grupos int,
      fk_descobridor int,
      fk_eras int,
      fk_pais int,
      foreign key (fk_grupos) references grupos(id_grupo),
      foreign key (fk_descobridor) references descobridor(id_descobridor),
      foreign key (fk_eras) references eras(id_eras),
      foreign key (fk_pais) references pais(id_pais)
)


create table grupos
(
      id_grupo integer not null primary key identity,
      nome varchar(50)
)


create table descobridor
(
      id_descobridor integer not null primary key identity,
      nome varchar(50)
)


create table eras
(
      id_eras integer not null primary key identity,
      nome varchar(50),
      inicio int,
      fim int
)


create table pais
(
      id_pais integer not null primary key identity,
      nome varchar(45)
)


select * from dinossauro;

select * from grupos;

select * from descobridor;

select * from eras;

select * from pais;


INSERT INTO dinossauro values ('Saichania', 4, 1977, 145, 66, 1, 1, 1, 1)
INSERT INTO dinossauro values ('Triceratops', 6, 1887, 70, 66, 2, 2, 1, 2)
INSERT INTO dinossauro values ('Kentrossauro', 2, 1909 , 200, 145, 3, 3, 2, 3)
INSERT INTO dinossauro values ('Pinacossauro',6, 1999, 85, 75, 1, 4, 3, 4)
INSERT INTO dinossauro values ('Alossauro',3, 1877, 155, 150, 4, 5, 2, 5)



INSERT INTO grupos values ('Anquilossauros')
INSERT INTO grupos values ('Ceratopsídeos')
INSERT INTO grupos values ('Estegossauro')
INSERT INTO grupos values ('Anquilossauros')
INSERT INTO grupos values ('Terápodes')


INSERT INTO descobridor values ('Maryanska')
INSERT INTO descobridor values ('John Bell Hatcher')
INSERT INTO descobridor values ('Cientistas Alemaes')
INSERT INTO descobridor values ('Museu Americano de História Natural')
INSERT INTO descobridor values ('Othniel Charles Marsh')


INSERT INTO eras values ('Cretaceo','145','66')
INSERT INTO eras values ('Cretaceo','70','66')
INSERT INTO eras values ('Jurassico','200','145')
INSERT INTO eras values ('Triassico','85','75')
INSERT INTO eras values ('Jurassico','155','150')


INSERT INTO pais values ('Mongolia')
INSERT INTO pais values ('Canada')
INSERT INTO pais values ('Tanzania')
INSERT INTO pais values ('China')
INSERT INTO pais values ('America do Norte')


create trigger triggerano
on dinossauro
after insert, update
as
	declare @idade integer
	
	select @idade = (select(anoInicio - anoFim) from inserted)

	if(@idade >= 0)
	begin
		print('Foi inserido com sucesso.');
		return;
	end
	else
	begin
		rollback;
		raiserror('Tempo de existência inválido!');
		return;
	end