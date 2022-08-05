create database exemplo;

create table pessoas
(
	id_pessoa integer not null primary key identity,
	nome varchar(50) not null,
	data_nasc date,
	rg varchar(20) not null,
	cpf varchar(20) not null unique,
	endereco varchar(50),
	altura integer
)

-- fk chave estrangeira

create table telefones
(
	id_tel integer not null primary key identity,
	fk_pessoa integer,
	cod_area varchar(2) not null,
	numero varchar(10) not null,
	descricao varchar(100),
	foreign key (fk_pessoa) references pessoas(id_pessoa)
)

create table medicos
(
	id_med integer not null primary key identity,
	fk_pessoa integer,
	crm varchar(20) not null,
	foreign key (fk_pessoa) references pessoas(id_pessoa)
)


create table especialidades
(
	id_espec integer not null primary key identity,
	nome varchar(50) not null
)

create table medico_espec
(
	fk_med integer,
	fk_espec integer,
	foreign key (fk_med) references medicos(id_med),
	foreign key (fk_espec) references especialidades(id_espec),
	PRIMARY KEY (fk_med, fk_espec)
)

create table consultas
(
	id_cons integer not null primary key identity,
	fk_pessoa integer,
	fk_med integer,
	data_cons date,
	hist_clinica varchar(100),
	pressao varchar(20) not null,
	massa numeric(10),
	foreign key (fk_pessoa) references pessoas(id_pessoa),
	foreign key (fk_med) references medicos(id_med)
)

create table patalogias
(
	id_pat integer not null primary key identity,
	cod_cid10 varchar(20) not null,
	descricao varchar(100) not null
)

create table cons_pat
(
	fk_cons integer not null,
	fk_pat integer not null,
	observacao varchar(100) not null,
	tratamento varchar(100) not null,
	foreign key (fk_cons) references consultas(id_cons),
	foreign key (fk_pat) references patalogias(id_pat),
	PRIMARY KEY (fk_cons, fk_pat)
)

create table medicamentos
(
	id_md integer not null primary key identity,
	descricao varchar(100) not null,
	nome varchar(50) not null,
)

create table cons_medic
(
	fk_cons integer,
	fk_md integer,
	uso varchar(100) not null,
	foreign key (fk_cons) references consultas(id_cons),
	foreign key (fk_md) references medicamentos(id_md),
	PRIMARY KEY (fk_cons, fk_md)
)



