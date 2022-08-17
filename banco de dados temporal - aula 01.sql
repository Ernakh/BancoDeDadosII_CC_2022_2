


create database temporal

create table produtos
(
	id integer not null primary key identity,
	nome varchar(50) not null,
	codBarras varchar(30),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON)

select * from produtos

insert into produtos (nome) values ('caneta bic vermelha')
update produtos set codbarras = '99496' where id = 1
delete from produtos where id = 1

select * from produtos
for system_time all
where id = 1



alter table produtos set (system_versioning = OFF)

update produtos set codbarras = '99496' where id = 3

drop table produtos

