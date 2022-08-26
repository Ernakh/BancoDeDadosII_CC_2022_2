
create database Hospital

create table equipamento
(
	id integer not null primary key identity,
	tag varchar (50) not null unique,
	sala_de_utilizacao varchar (50) not null
)

create table medico
(
	id integer not null primary key identity,
	nome varchar (50) not null,
	area varchar(25) not null
)
create table motorista
(
	id integer not null primary key identity,
	nome varchar (50) not null,
	anos_de_experiencia integer
)


create table paciente
(
	id integer not null primary key identity,
	nome varchar (50) not null,
	pressao_arterial decimal(5,2),
	batimentos decimal(5,2),
	nivel_oxigenacao decimal(5,2),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio,fim)
)

with (system_versioning = ON)


create table ambulancia
(
	id integer not null primary key identity,
	id_motorista integer not null,
	foreign key (id_motorista) references motorista(id),
	id_tripulacao integer not null,
	longitude decimal(7,3) not null,
	latitude decimal(7,3) not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio,fim)
)
with (system_versioning = ON)

create table resgate
(
	id integer not null primary key identity,
	id_ambulancia integer not null,
	foreign key (id_ambulancia) references ambulancia(id),
	id_medico integer,
	foreign key (id_medico) references medico(id),
	id_dados_saude_paciente integer not null,
	foreign key (id_dados_saude_paciente) references paciente(id),
)

create table salas
(
	id integer not null primary key identity,
	id_resgate integer,
	foreign key (id_resgate) references resgate(id),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio,fim)
)

with (system_versioning = ON)




alter table equipamento add id_sala integer foreign key (id_sala) references salas(id)

