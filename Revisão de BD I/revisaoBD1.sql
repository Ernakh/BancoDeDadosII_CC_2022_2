create database consultorio

create table pessoas
(
	id integer primary key identity,
	nome varchar (50) not null,
	data_nasc date,
	rg varchar (10) not null,
	cpf varchar (20) not null unique,
	endereco varchar (90),
	altura integer
)

create table medicos
(
	id integer primary key identity,
	crm varchar (20),
	fk_pessoa integer,
	foreign key (fk_pessoa) references pessoas (id)
)

create table telefones
(
	id integer primary key identity,
	cod_area varchar(2) not null,
	numero varchar (10) not null,
	descricao varchar (100),
	fk_pessoa integer,
	foreign key (fk_pessoa) references pessoas(id)
)

create table medicamentos
(
	id integer primary key identity,
	descricao varchar (50),
	nome varchar (20)
)

create table patologias
(
	id integer primary key identity,
	cod_cid10 varchar(20),
	descricao varchar(50)
)

create table especialidades
(
	id integer primary key identity,
	nome varchar (20)
)

create table medico_espec
(
	fk_medico integer not null,
	fk_espec integer not null,
	foreign key (fk_medico) references medicos(id),
	foreign key (fk_espec) references especialidades(id),
	primary key (fk_medico, fk_espec)
)

create table consultas
(
	id integer primary key identity,
	data date,
	hist_clinica varchar(100),
	pressao varchar(7),
	massa integer,
	fk_pessoa integer,
	fk_medico integer,
	foreign key (fk_pessoa) references pessoas(id),
	foreign key (fk_medico) references medicos(id)
)

create table cons_pat
(
	fk_consulta integer not null,
	fk_patologia integer not null,
	observacao varchar(60),
	tratamento varchar(60),
	foreign key (fk_consulta) references consultas(id),
	foreign key (fk_patologia) references patologias(id),
	primary key (fk_consulta, fk_patologia)
)

create table cons_medic
(
	fk_consulta integer not null,
	fk_medicamento integer not null,
	uso varchar (100),
	foreign key (fk_consulta) references consultas(id),
	foreign key (fk_medicamento) references medicamentos(id),
	primary key (fk_consulta, fk_medicamento)
)
