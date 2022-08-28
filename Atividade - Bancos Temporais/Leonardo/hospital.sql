--create database hospital

create table pessoas
(
	id integer primary key identity,
	cpf varchar(11) not null,
	nome varchar(50) not null,
	endereco varchar(80),
	dataNasc date not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON)


create table medicos
(
	id integer primary key identity,
	crm varchar(11) not null,
	cargo varchar (20),
	salario numeric(7,2),
	fk_pessoa integer,
	foreign key(fk_pessoa) references pessoas(id),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio, fim)
)
with
(
	system_versioning = ON (history_table = dbo.medicosHistorico)
)

create table exames
(
	id integer primary key identity,
	tipo varchar(50) not null,
	descricao varchar(60)
)

create table consultas
(
	id integer primary key identity,
	atendimento datetime,
	fk_pessoa integer not null,
	fk_medico integer not null,
	foreign key (fk_pessoa) references pessoas(id),
	foreign key (fk_medico) references medicos(id),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON)

create table especialidades
(
	id integer primary key identity,
	nome varchar(25)
)

create table consultas_exames
(
	fk_consulta integer not null,
	fk_exame integer not null,
	foreign key (fk_consulta) references consultas(id),
	foreign key (fk_exame) references exames(id),
	primary key (fk_consulta, fk_exame)
)

create table medico_espec
(
	fk_medico integer not null,
	fk_espec integer not null,
	foreign key (fk_medico) references medicos(id),
	foreign key (fk_espec) references especialidades(id),
	primary key (fk_medico, fk_espec)
)

insert into pessoas (cpf, nome, endereco, dataNasc) values('09453678945', 'Bruno Silva', 'Rua Tuiuti, 1598', '28/12/1975'),
	('48625715936', 'Henrique Ferreira', 'Avenida Medianeira 236', '23/09/1994'),
	('75369841258', 'Julia Teixeira', 'Rua Dr. Bozano, 1021', '03/03/2005'),
	('36925814775', 'Isabela Lins' , 'Rua Antonio Botega 893', '06/05/1986'),
	('15948263571', 'Daniel Neves' , 'Rua Floriano Peixoto 1345', '02/01/1948')

insert into medicos (crm, cargo, salario, fk_pessoa) values('753846', 'medico', 34560.00, 1),
	('485926', 'diretor', 42220.74, 4)

select * from pessoas
select * from medicos

insert into consultas (atendimento, fk_pessoa, fk_medico) values ('15/08/2022 15:28', 2, 1)
insert into consultas (atendimento, fk_pessoa, fk_medico) values ('16/08/2022 10:45', 3, 1)
insert into consultas (atendimento, fk_pessoa, fk_medico) values ('17/08/2022 14:09', 5, 2)
select * from consultas 

insert into especialidades values ('Traumatologista'), ('Ortopedista'), ('Oftalmologista')

insert into exames (tipo) values('Raio-X'), ('Ressonância magnética'), ('Eletrocardiograma')
select * from exames

insert into consultas_exames values(1, 2), (4, 1)

insert into medico_espec values (1, 1), (2,3)

update medicos set salario = 37890.00 where id = 1 
update medicos set cargo = 'cirurgiao' where id = 1

delete from pessoas where id = 5

delete from consultas where id = 7

select * from pessoas
for system_time all

select * from consultas
for system_time all

select * from medicosHistorico