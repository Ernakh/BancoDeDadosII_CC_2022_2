-- Atividade 1
-- Questão 1
 

create table pacientes
(
      id_pacientes integer not null primary key identity,
      cpf varchar(45) not null,
      nome varchar(45) not null,
      endereço varchar(45) not null,
      data_nascimento date not null,
      inicio datetime2 generated always as row start not null,
      fim datetime2 generated always as row end not null,
            period for system_time (inicio, fim)
)
with
 (
 system_versioning = ON (history_table = dbo.pacientes_historico)
 )

create table medicos
(
    id_medicos integer not null primary key identity,
    crm varchar(45) not null,
    cargo varchar(45) not null,
    salario varchar(45) not null,
    especialidade varchar(45) not null,
    nome varchar(45) not null,
    cpf varchar(45) not null,
    endereço varchar(45) not null,
    data_nascimento date not null,
    inicio datetime2 generated always as row start not null,
    fim datetime2 generated always as row end not null,
          period for system_time (inicio, fim)
)
with
(
system_versioning = ON (history_table = dbo.medicos_historico)
)

create table exames
(
	id_exames integer not null primary key identity,
	fk_pacientes integer,
	fk_medicos integer,
	exames_descrição varchar(45) not null,
	hemograma varchar(45),
	raio_x varchar(45)
	foreign key (fk_pacientes) references pacientes(id_pacientes),
	foreign key (fk_medicos) references medicos(id_medicos),
	inicio datetime2 generated always as row start not null,
    fim datetime2 generated always as row end not null,
    		period for system_time (inicio, fim)
)
with
(
system_versioning = ON (history_table = dbo.exames_historico)
)

create table consultas
(
	id_consultas integer not null primary key identity,
	fk_pacientes integer,
	fk_medicos integer,
	fk_exames integer,
	horario varchar(45) not null,
	data_consulta date not null,
	historico varchar(45) not null,
	medicamentos varchar(45),
	inicio datetime2 generated always as row start not null,
    fim datetime2 generated always as row end not null,
    		period for system_time (inicio, fim)
)
with
(
system_versioning = ON (history_table = dbo.consultas_historico)
)

select * from pacientes;
select * from medicos;
select * from exames;
select * from consultas;

alter table pacientes set (system_versioning = OFF)
alter table medicos set (system_versioning = OFF)
alter table exames set (system_versioning = OFF)
alter table consultas set (system_versioning = OFF)



insert into pacientes (nome, cpf, endereço, data_nascimento) values
('Cristian', '1236589878', 'Rua Brasil', '2012-12-12')

insert into pacientes (nome, cpf, endereço, data_nascimento) values
('Maria', '6596589832', 'Rua Floriano', '2008-07-10')

insert into pacientes (nome, cpf, endereço, data_nascimento) values
('João', '5476583662', 'Rua Niderauer', '2005-02-01')

insert into medicos (crm, cargo, salario, especialidade, nome, cpf, endereço, data_nascimento) values
('123456', 'Medico', 'R$:10.000,00', 'Clinico Geral', 'Victor', '69845236312', 'Rua Medianeira', '2000-10-20' )

insert into medicos (crm, cargo, salario, especialidade, nome, cpf, endereço, data_nascimento) values
('654321', 'Medico', 'R$:15.000,00', 'Anestesista', 'Nathalia', '21842536999', 'Rua Acampamento', '2001-06-22' )

insert into medicos (crm, cargo, salario, especialidade, nome, cpf, endereço, data_nascimento) values
('224398', 'Resitende', 'R$:4.000,00', 'Enfermeiro', 'Vinicius', '547411136968', 'Rua Medianeira', '2003-08-24' )

insert into exames (exames_descrição, hemograma, raio_x) values
('Rotina', ' 25mg', 'imagem torax')

insert into exames (exames_descrição, hemograma, raio_x) values
('Diabetes', ' 35mg', 'imagem cranio')

insert into exames (exames_descrição, hemograma, raio_x) values
('Rotina', ' 20mg', 'imagem cranio')

insert into consultas (horario, data_consulta, historico, medicamentos) values
('14:00', '2021-10-10', 'Pressão alta', 'Paracetamol')

insert into consultas (horario, data_consulta, historico, medicamentos) values
('08:00', '2022-08-15', 'Renite alergica', 'Loratamed')

insert into consultas (horario, data_consulta, historico, medicamentos) values
('15:00', '2022-10-20', 'Infarto na Familia', 'Dipirona')

-- Informações temporais pacientes
update pacientes set endereço = 'Avenida Jõao Pessoa' where id_pacientes = 1
delete from pacientes where id_pacientes = 1
select * from pacientes
for system_time all
where id_pacientes = 1

-- Informações temporais medicos 
update medicos set salario = 'R$:20.000,00' where id_medicos = 1
delete from medicos where id_medicos = 1
select * from medicos
for system_time all
where id_medicos = 1

update medicos set cargo = 'Pediatra' where id_medicos = 1
delete from medicos where id_medicos = 1
select * from medicos
for system_time all
where id_medicos = 1

update medicos set endereço = 'Rua Niederauer' where id_medicos = 1
delete from medicos where id_medicos = 1
select * from medicos
for system_time all
where id_medicos = 1

-- Informações temporais exames
update exames set hemograma = '30mg' where id_exames = 1
delete from exames where id_exames = 1
select * from exames
for system_time all
where id_exames = 1

-- Informações temporais consultas
update consultas set horario = '16:00' where id_consultas = 3
delete from consultas where id_consultas = 4
select * from consultas
for system_time all
where id_consultas = 4

update consultas set data_consulta = '2022-12-14' where id_consultas = 3
delete from consultas where id_consultas = 4
select * from consultas
for system_time all
where id_consultas = 4

delete from consultas where id_consultas = 4

drop table pacientes

drop table medicos

drop table exames

drop table consultas