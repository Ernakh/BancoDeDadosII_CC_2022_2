create database Atividade02

use Atividade02

create table Dinossauros
(
	id_dino integer not null identity primary key,
	nome varchar(50) not null, 
	grupo varchar(20) not null, 
	toneladas integer not null,
	ano_descoberta integer not null,
	descobridor varchar(50) not null, 
	fk_era integer not null, 
	inicio integer not null, 
	fim integer not null, 
	pais varchar (30) not null,
	foreign key (fk_era) references Eras(id_era)

)

drop table Dinossauros

create table Eras
(
	id_era integer not null identity primary key,
	nome varchar(20),
	ano_inicio integer not null, 
	ano_fim integer not null,
)

insert into Eras(nome, ano_inicio, ano_fim)
values('Triassico', 251, 200)

insert into Eras(nome, ano_inicio, ano_fim)
values('Jurassico', 200, 145)

insert into Eras(nome, ano_inicio, ano_fim)
values('Cretaceo', 145, 65)

select *
from Eras

insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Saichania', 'Anquilossauros', 4, 1977, 'Maryanska', 3, 145, 66, 'Mongolia')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Triceratops', 'Ceratopsideos', 6, 1887, 'John Bell Hatcher', 3, 70, 66, 'Canada')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Kentrossauro', 'Estegossauros', 2, 1909, 'Cientistas Alemaes', 2, 200, 145, 'Tanzania')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Pinacossauro', 'Anquilossauros', 6, 1999, 'Museu Americano de Historia Natural', 1, 85, 75,  'China')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Alossauro', 'Teropodes', 3, 1877, 'Othniel Charles March', 2, 155, 150, 'America do Norte')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Torossauro', 'Ceratopsideos', 8, 1891, 'John Bell Hatcher', 3, 67, 65, 'USA')
insert into Dinossauros(nome, grupo, toneladas, ano_descoberta, descobridor, fk_era, inicio, fim, pais)
values('Anquilossauro', 'Anquilossauros', 8, 1977, 'Barnum Brown', 1, 66, 63, 'America do Norte')

select *
from Dinossauros