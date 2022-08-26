-- Atividade I - Banco de Dados
-- Enunciado 1

-- Criacao das tabelas
create table pacientes
(
	idPaciente integer not null primary key identity,
	cpf varchar(14) not null,
	nome varchar(30) not null,
	endereco varchar(50) not null,
	dataNascimento date,
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
	idExame int foreign key references exames(idExame),
	dataHora varchar(20) not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.consultasHistorico))

create table exames
(
	idExame int primary key not null identity,
	tipo varchar(30),
	descricao varchar(30),
)

--Selects para verificar se as tabelas foram criadas corretamente

select * from pacientes;
select * from dbo.pacientesHistorico
select * from medicos;
select * from dbo.medicosHistorico;
select * from consultas;
select * from exames;


--Drops para derrubar tabelas para correcoes
alter table pacientes set (system_versioning = OFF)
alter table medicos set (system_versioning = OFF)
alter table consultas set (system_versioning = OFF)
alter table exames set (system_versioning = OFF)

drop table pacientes;
drop table pacientesHistorico;

drop table medicos;
drop table medicosHistorico;

drop table consultas;

drop table exames;
drop table dbo.examesHistorico;

--Inserts para inserir dados nas tabelas
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('444.555.666-77', 'Cleber', 'Boi Morto', '1999-10-20');
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('999.888.777-66', 'Maria', 'Vila Rossi', '2000-01-25');

insert into medicos(cpf, nome, endereco, dataNascimento, crm, especialidade, cargo, salario)
values('123.456.789-99', 'Rodrigo', 'Rua Acampamento', '1980-05-14', 'CRM/RS 123456', 'Cardiologia', 'Cardiologista', 8107.30);
update medicos set endereco = 'Cruz Alta' where idMedico = 1

insert into consultas(idPaciente, idMedico, idExame, dataHora)
values ('2', '1', '1', '2022-09-13 15:40:00');

insert into exames(tipo, descricao)
values ('coleta', 'coleta de sangue')
insert into exames(tipo, descricao)
values ('coleta', 'coleta de urina')
insert into exames(tipo, descricao)
values ('iamgem', 'raio-x')
insert into exames(tipo, descricao)
values ('imagem', 'ressonância magnética')

--fk consulta
--fk exame 
--resultado
--temporal