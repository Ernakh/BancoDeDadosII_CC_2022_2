-- Atividade I - Banco de Dados
-- Enunciado 1
-- Aluno: Pedro Cassenote Batista

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

create table exames
(
	idExame int primary key not null identity,
	tipo varchar(30),
	descricao varchar(30),
)

create table consultas
(
	idConsulta int primary key not null identity,
	idPaciente int foreign key references pacientes(idPaciente),
	idMedico int foreign key references medicos(idMedico),
	idExame int foreign key references exames(idExame),
	dataHora varchar(20) not null,
	resultado varchar(30) not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.consultasHistorico))

--Inserts para inserir dados nas tabelas
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('444.555.666-77', 'Cleber Santos', 'Santa Maria', '1999-10-20');
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('999.888.777-66', 'Maria Roberta', 'Cruz Alta', '2000-01-25');
insert into pacientes(cpf, nome, endereco, dataNascimento)
values ('123.456.789-99', 'Roberto Machado', 'Porto Alegre', '1975-03-13');

insert into medicos(cpf, nome, endereco, dataNascimento, crm, especialidade, cargo, salario)
values('111.222.333-44', 'Rodrigo Souza', 'Caxias do Sul', '1980-05-14', 'CRM/RS 123456', 'Cardiologia', 'Cardiologista', 8100.00);
insert into medicos(cpf, nome, endereco, dataNascimento, crm, especialidade, cargo, salario)
values('345.567.456-77', 'Renata Morais', 'Curitiba', '1988-08-08', 'CRM/RS 345345', 'Pediatria', 'pediatra', 6800.00);

insert into exames(tipo, descricao)
values ('coleta', 'coleta de sangue')
insert into exames(tipo, descricao)
values ('coleta', 'coleta de urina')
insert into exames(tipo, descricao)
values ('iamgem', 'raio-x')
insert into exames(tipo, descricao)
values ('imagem', 'ressonância magnética')

insert into consultas(idPaciente, idMedico, idExame, dataHora, resultado)
values ('2', '1', '1', '2022-09-13 15:40:00', 'Sem alterações');
insert into consultas(idPaciente, idMedico, idExame, dataHora, resultado)
values ('1', '2', '4', '2022-09-17 18:30:00', 'Alterações no cérebro');

--Updates para mostrar versionamento
update medicos set nome = 'Rodrigo Sousa' where idMedico = 1
update pacientes set dataNascimento = '1998-01-01' where idPaciente = 3
update consultas set resultado = 'Taxa de ferritina alta' where idConsulta = 1

--Selects para verificar se as tabelas foram criadas corretamente
select * from pacientes;
select * from medicos;
select * from exames;
select * from consultas;

select * from dbo.pacientesHistorico;
select * from dbo.medicosHistorico;
select * from dbo.consultasHistorico;

--Drops para derrubar tabelas para correcoes
alter table pacientes set (system_versioning = OFF)
alter table medicos set (system_versioning = OFF)
alter table consultas set (system_versioning = OFF)

drop table consultas;
drop table dbo.consultasHistorico

drop table medicos;
drop table dbo.medicosHistorico;

drop table pacientes;
drop table dbo.pacientesHistorico;

drop table exames;
