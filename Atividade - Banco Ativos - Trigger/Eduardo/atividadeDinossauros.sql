CREATE DATABASE db_dinos;
USE db_dinos;

CREATE TABLE DINOSSAURO(
      idDino integer not null primary key identity,
      nomeDino varchar(25),
      toneladas decimal(3,1),
      anoDescoberta decimal(4),
      anoInicio integer,
      anoFim integer,
      fk_idDescobridor integer,
	  fk_idGrupo integer,
      foreign key (fk_idDescobridor) references DESCOBRIDOR(idDescobridor),
      foreign key (fk_idGrupo) references GRUPO(idGrupo)
)

SELECT *FROM DINOSSAURO;

INSERT INTO DINOSSAURO(nomeDino,toneladas,anoDescoberta,anoInicio,anoFim,fk_idDescobridor,fk_idGrupo)
VALUES ('Saichania',4,1977,145,66,1,1),
	   ('Tricerátops',6,1887,70,66,2,2),
	   ('Kentrossauro',2,1909,200,145,3,3),
	   ('Pinacossauro',6,1999,85,75,4,1),
	   ('Alossauro',3,1877,155,150,5,4),
	   ('Torossauro',8,1891,67,65,2,2),
	   ('Anquilossauro',8,1906,66,63,6,1);
		

CREATE TABLE DESCOBRIDOR(
      idDescobridor integer not null primary key identity,
      nomeDescobridor varchar(50),
)

SELECT *FROM DESCOBRIDOR;

INSERT INTO DESCOBRIDOR(nomeDescobridor)
VALUES ('Maryanska'),
	   ('John Bell Hatcher'),
	   ('Cientistas Alemães'),
	   ('Museu Americano de História Natural'),
	   ('Othniel Charles Marsh'),
	   ('Barnum Brown');

CREATE TABLE PAIS(
      idPais integer not null primary key identity,
      nomePais varchar(30)
)

SELECT *FROM PAIS;

INSERT INTO PAIS(nomePais)
VALUES ('Mongólia'),
	   ('Canadá'),
	   ('Tanzânia'),
	   ('China'),
	   ('América do Norte'),
	   ('USA');


CREATE TABLE PAIS_DESCOBRIDOR(
      fk_idPais integer,
      fk_idDescobridor integer,
      foreign key (fk_idPais) references PAIS(idPais),
      foreign key (fk_idDescobridor) references DESCOBRIDOR(idDescobridor)
)

SELECT *FROM PAIS_DESCOBRIDOR;

INSERT INTO PAIS_DESCOBRIDOR(fk_idDescobridor,fk_idPais)
VALUES (1,1),
	   (2,2),
	   (3,3),
	   (4,4),
	   (5,5),
	   (2,6),
	   (6,5);

CREATE TABLE GRUPO(
      idGrupo integer not null primary key identity,
      nomeGrupo varchar(25),
	  fk_idDieta integer,
      foreign key (fk_idDieta) references DIETA(idDieta),
)

SELECT *FROM GRUPO;

INSERT INTO GRUPO(nomeGrupo, fk_idDieta)
VALUES ('Anquilossauros', 1),
	   ('Ceratopsídeos', 1),
	   ('Estegossauros', 1),
	   ('Terápodes', 2);

CREATE TABLE ERA(
      idEra integer not null primary key identity,
      nomeEra varchar(20),
      anoInicio integer,
      anoFim integer,
)

SELECT *FROM ERA;

INSERT INTO ERA(nomeEra, anoInicio, anoFim)
VALUES ('Cretáceo', 145,65),
	   ('Jurássico', 201,145),
	   ('Triássico', 252,63);


CREATE TABLE ERA_GRUPO(
      fk_idEra integer,
      fk_idGrupo integer,
      foreign key (fk_idEra) references ERA(idEra),
      foreign key (fk_idGrupo) references GRUPO(idGrupo)
)

SELECT *FROM ERA_GRUPO;

INSERT INTO ERA_GRUPO(fk_idEra, fk_idGrupo)
VALUES (1,1),
	   (1,2),
	   (2,3),
	   (3,1),
	   (2,4),
	   (1,2),
	   (3,1);

CREATE TABLE DIETA(
      idDieta integer not null primary key identity,
      nomeDieta varchar(10)
)

SELECT *FROM DIETA;

INSERT INTO DIETA(nomeDieta)
VALUES ('Herbívoros'),
	   ('Carnívoros');


create trigger trigger1
on DINOSSAURO
after insert, update
as
	declare @idade integer
	select @idade = (select(anoInicio - anoFim) from inserted)

	if(@idade >= 0)
	begin
		--print('Inserido com sucesso!');
		return;
	end
	else
	begin
		rollback;
		raiserror('Tempo de existência inválido!', 14, 1);
		return;
	end

create trigger trigger2
on DINOSSAURO
after insert, update
as
	declare @inicio integer
	declare @fim integer
	declare @era integer
	select @inicio = (select(anoInicio) from inserted)
	select @fim = (select(anoFim) from inserted)
	select @era = (select(idEra) from ERA)

	if(@inicio <= 145 and @fim >= 65 and @era = 1 )
	begin
		return;
	end
	else if
	(@inicio <= 201 and @fim >= 145 and @era = 2 )
	begin
		return;
	end
	else if(@inicio <= 252 and @fim >= 63 and @era = 3 )
	begin
		return;
	end
	else
	begin
		rollback;
		raiserror('Tempo de existência INVÁLIDO!', 14, 1);
		return;
	end