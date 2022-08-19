

create database temporal;


create table carros
(
	id integer primary key identity,
	ano integer,
	marca varchar(15),
	modelo varchar(15),
	cor varchar(10),
	kilometragem integer not null default 0,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio, fim)
)
with
(
	system_versioning = ON (history_table = dbo.carrosHistorico)
)

select * from carros

select * from carrosHistorico


insert into carros (ano, marca, modelo, cor)
values (2020, 'Ford', 'Fusion', 'Prata')

insert into carros (ano, marca, modelo, cor, kilometragem)
values (2008, 'Fiat', 'Punto', 'Amarelo', 250000)

insert into carros (ano, marca, modelo, cor, kilometragem)
values (2022, 'Hyundai', 'HB20', 'Preto', 8000)

insert into carros (ano, marca, modelo, cor, kilometragem)
values (1976, 'Volks', 'Fusca', 'Verde', 478000)

select * from carros
select * from carrosHistorico

update carros set kilometragem = 800 where id = 1
update carros set kilometragem = 480800 where id = 4
update carros set kilometragem = 1800 where id = 1
update carros set kilometragem = 266000 where id = 2

delete from carros where id = 3


select * from carros

select * from carros
for system_time as of '2022-08-19 11:22:14.6697626'

select * from carros
for system_time all
where id = 1

select carrosHistorico.modelo from carros
right join carrosHistorico on carrosHistorico.id = carros.id
where carros.id is null

