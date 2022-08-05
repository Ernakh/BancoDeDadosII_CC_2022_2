create database consultorio

create table pessoas
(
	id_pessoa integer not null primary key identity,
	nome varchar(50) not null,
	data_nasc date,
	rg varchar(10) not null,
	cpf varchar(12) not null unique,
	endereco varchar(90),
	altura integer
)

select * from pessoas

create table telefones
(
	id_tel integer not null primary key identity,
	fk_pessoa integer,
	cod_area varchar(2) not null,
	numero varchar(10) not null,
	descricao varchar(100),
	foreign key (fk_pessoa) references pessoas(id_pessoa) 
)

select * from telefones

create table medicos
(
	id_med integer not null primary key identity,
	fk_pessoa integer,
	crm varchar(20) not null
	foreign key (fk_pessoa) references pessoas(id_pessoa)
)

select * from medicos

create table especialidades
(
	id_espec integer not null primary key identity,
	nome varchar(20) not null
)

select * from especialidades

create table medico_espec
(
	fk_med int not null,
	fk_espec int not null,
	primary key (fk_med, fk_espec),
	foreign key (fk_med) references medicos(id_med),
	foreign key (fk_espec) references especialidades(id_espec)
)

select * from medico_espec

create table medicamentos
(
	id_md int not null primary key identity,
	descricao varchar(100) not null,
	nome varchar(30) not null
)

select * from medicamentos

create table patologias
(
	id_pat int not null primary key identity,
	cod_cid10 varchar(10) not null,
	descricao varchar(100) not null
)

select * from patologias

create table consultas
(
	id_cons int not null primary key identity,
	fk_pessoa int not null,
	fk_med int not null,
	data_consulta date,
	hist_clinica varchar(30),
	pressão varchar(10),
	massa int,
	foreign key(fk_pessoa) references pessoas (id_pessoa),
	foreign key(fk_med) references medicos (id_med)
)

select * from consultas

create table cons_pat
(
	fk_cons int not null,
	fk_pat int not null,
	observacao varchar(30),
	tratamento varchar(50) not null,
	primary key(fk_cons, fk_pat),
	foreign key(fk_cons) references consultas (id_cons),
	foreign key(fk_pat) references patologias (id_pat)
)

select * from cons_pat

create table cons_medic
(
	fk_cons int not null,
	fk_md int not null,
	uso varchar(100),
	primary key(fk_cons, fk_md),
	foreign key(fk_cons) references consultas(id_cons),
	foreign key(fk_md) references medicamentos(id_md)
)

select * from cons_medic