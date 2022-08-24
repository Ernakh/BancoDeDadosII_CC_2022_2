-- Atividade I - Banco de Dados
-- Enunciado 1

-- Criação das tabelas
create table pacientes
(
	idPaciente integer not null primary key identity,
	cpf varchar(14) not null,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	dataNascimento date not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.pacientesHistorico))

create table medicos
(
	idMedico integer not null primary key identity,
	cpf varchar(14) not null,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	dataNascimento date not null,
	crm varchar(30) not null,
	especialidade varchar(20) not null,
	cargo varchar(30) not null,
	salario float not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.medicosHistorico))

create table consultas
(
	idConsulta int primary key not null identity,
	idPaciente int foreign key references pacientes(idPaciente),
	idMedico int foreign key references medicos(idMedico),
	exame varchar(30) not null,
	exameDescricao varchar(30) not null,
	dataHora datetime,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.consultasHistorico))

--Selects para verificar se as tabelas foram criadas corretamente
select * from pacientes;
select * from medicos;
select * from consultas;

--Drops para derrubar tabelas para correções
alter table pacientes set (system_versioning = OFF)
alter table medicos set (system_versioning = OFF)
alter table consultas set (system_versioning = OFF)

drop table pacientes;
drop table pacientesHistorico;

drop table medicos;
drop table medicosHistorico;

drop table consultas;
drop table consultasHistorico;

--Inserts para inserir dados nas tabelas
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('444.555.666-77', 'Cléber', 'Boi Morto', '1999-10-20');
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('111.222.333-44', 'Roger', 'Camobi', '2010-05-05');
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('999.888.777-66', 'Maria', 'Vila Rossi', '2000-01-25');

insert into medicos(cpf, nome, endereco, dataNascimento, crm, especialidade, cargo, salario)
values('123.456.789-99', 'Rodrigo', 'Rua Acampamento', '1980-05-14', 'CRM/RS 123456', 'Cardiologia', 'Cardiologista', 8107.30);
