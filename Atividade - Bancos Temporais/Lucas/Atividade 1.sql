create database Consultorio

create table Paciente
(
	idPaciente integer not null primary key identity,
	nome varchar(50) not null,
	cpf varchar(15) not null,
	endereco varchar(30) not null,
	dataNasc date not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time(inicio,fim)
)


create table Medico
(
	idMedico integer not null primary key identity,
	nome varchar(50) not null,
	cpf varchar(15) not null,
	crm varchar(10) not null, 
	endereco varchar(30) not null,
	dataNasc date not null,
	especialidade varchar(20) not null, 
	cargo varchar(30) not null, 
	salario float not null, 
	inicio datetime2 generated always as row start not null, 
	fim datetime2 generated always as row end not null, 
	period for system_time(inicio,fim)

)

create table Exame
(
	idExame integer not null primary key identity,
	info varchar(100) not null, 
)

create table consulta
(
	idPaciente integer not null,
	idMedico integer not null, 
	idExame integer not null, 
	inicio datetime2 generated always as row start not null, 
	fim datetime2 generated always as row end not null, 
	period for system_time(inicio,fim),
	foreign key (idPaciente) references Paciente(idPaciente),
	foreign key (idMedico) references Medico(idMedico),
	foreign key (idExame) references Exame(idExame),
	primary key (idPaciente,idMedico,idExame,inicio),

)


insert into Paciente (nome,cpf,endereco,dataNasc)
values ('Lucas','036.678.300-92','rua tuiuti 898','2000-12-27')
insert into Paciente (nome,cpf,endereco,dataNasc)
values ('Paulo','444.343.123-90','rua do dale 111','1988-10-01')
insert into Paciente (nome,cpf,endereco,dataNasc)
values ('Cleber','123.055.311-21','rua aham 99','2004-01-12')
insert into Paciente (nome,cpf,endereco,dataNasc)
values ('Tiburcio','001.011.111-01','rua uau numero sim','1973-11-30')
insert into Paciente (nome,cpf,endereco,dataNasc)
values ('Gabriel','124.690.033-33','rua top kkk1','1998-05-22')



select * 
from Paciente

insert into Medico (nome,cpf,crm,endereco,dataNasc,especialidade,cargo,salario)
values('Jose','210.999.322-11','233342','rua ira 1423','1964-03-17','clinico','gestor',2300.12)
insert into Medico (nome,cpf,crm,endereco,dataNasc,especialidade,cargo,salario)
values('Percival','123.321.111-21','382912','rua media 112','1979-04-12','pediatra','chefe de pediatria',10000.00)
insert into Medico (nome,cpf,crm,endereco,dataNasc,especialidade,cargo,salario)
values('Enzo','111.222.333-44','895666','rua valentina 0','2001-11-12','geral','estagiario',100.11)

select *
from Medico

insert into Exame
values('Raio-X')
insert into Exame
values('Ultrasonografia')
insert into Exame
values('Exame de sangue')
insert into Exame
values('Exame de toque')
insert into Exame
values('Exame de urina')
insert into Exame
values('Teste covid')
insert into Exame
values('Ultrasom')
insert into Exame
values('Exame de fezes')

select *
from Exame

insert into Consulta (idPaciente,idMedico,idExame)
values(1,2,6)
insert into Consulta (idPaciente,idMedico,idExame)
values(5,1,2)
insert into Consulta (idPaciente,idMedico,idExame)
values(4,3,1)
insert into Consulta (idPaciente,idMedico,idExame)
values(2,1,3)
