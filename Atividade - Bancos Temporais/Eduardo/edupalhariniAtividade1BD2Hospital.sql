CREATE DATABASE hospital;

CREATE TABLE PESSOA
(
      idPessoa integer not null primary key identity,
      nomePessoa varchar(50),
      cpf char(11),
      endereco varchar(100),
      dataNascimento date,
      inicio datetime2 generated always as row start not null,
   	  fim datetime2 generated always as row end not null,
      period for system_time (inicio, fim)
)
with
 (system_versioning = ON (history_table = dbo.pessoa_historico))

CREATE TABLE ESPECIALIDADE
(
      idEspecialidade integer not null primary key identity,
      nomeEspecialidade varchar(40)
)

CREATE TABLE RECEBIVEIS
(
      idRecebiveis integer not null primary key identity,
      nomeRecebiveis varchar(40),
      remuneracao decimal(10,2),
      inicio datetime2 generated always as row start not null,
      fim datetime2 generated always as row end not null,
      period for system_time (inicio, fim)
)
with
 (system_versioning = ON (history_table = dbo.recebiveis_historico))


CREATE TABLE PACIENTE
(
      idPaciente integer not null primary key identity,
      fk_idPessoa integer,
      foreign key (fk_idPessoa) references PESSOA(idPessoa)
)

CREATE TABLE EXAME
(
      idExame integer not null primary key identity,
      nomeExame varchar(40),
      descricaoResultado varchar(1000),
      inicio datetime2 generated always as row start not null,
      fim datetime2 generated always as row end not null,
      period for system_time (inicio, fim)
)
with
 (system_versioning = ON (history_table = dbo.exame_historico))

CREATE TABLE FUNCIONARIO
(
      idFuncionario integer not null primary key identity,
      cargo varchar(20),
      fk_idPessoa integer,
      foreign key (fk_idPessoa) references PESSOA(idPessoa),
      inicio datetime2 generated always as row start not null,
      fim datetime2 generated always as row end not null,
      period for system_time (inicio, fim)
)
with
 (system_versioning = ON (history_table = dbo.funcionario_historico))

CREATE TABLE MEDICO
(
      idMedico integer not null primary key identity,
      crm varchar(10),
      fk_idFuncionario integer,
      foreign key (fk_idFuncionario) references FUNCIONARIO(idFuncionario)
)

CREATE TABLE ATENDIMENTO
(
      idAtendimento integer not null primary key identity,
      data date,
      hora time,
      fk_idPaciente integer,
      fk_idMedico integer,
      foreign key (fk_idPaciente) references PACIENTE(idPaciente),
      foreign key (fk_idMedico) references MEDICO(idMedico),
)

CREATE TABLE ATENDIMENTO_EXAME
(     
      descricaoAtendimento_Exame varchar(1000),
      fk_idAtendimento integer,
      fk_idExame integer,
      foreign key (fk_idAtendimento) references ATENDIMENTO(idAtendimento),
      foreign key (fk_idExame) references EXAME(idExame),
)

CREATE TABLE MEDICO_ESPECIALIDADE
(     
      fk_idMedico integer,
      fk_idEspecialidade integer,
      foreign key (fk_idMedico) references MEDICO(idMedico),
      foreign key (fk_idEspecialidade) references ESPECIALIDADE(idEspecialidade)
)


CREATE TABLE FUNCIONARIO_RECEBIVEIS
(     
      fk_idFuncionario integer,
      fk_idRecebiveis integer,
      foreign key (fk_idFuncionario) references FUNCIONARIO(idFuncionario),
      foreign key (fk_idRecebiveis) references RECEBIVEIS(idRecebiveis)
)


SELECT *FROM PESSOA;

SELECT *FROM ESPECIALIDADE;

SELECT *FROM RECEBIVEIS;

SELECT *FROM PACIENTE;

SELECT *FROM EXAME;

SELECT *FROM FUNCIONARIO;

SELECT *FROM MEDICO;

SELECT *FROM ATENDIMENTO;

SELECT *FROM ATENDIMENTO_EXAME;

SELECT *FROM MEDICO_ESPECIALIDADE;

SELECT *FROM FUNCIONARIO_RECEBIVEIS;



INSERT INTO PESSOA (nomePessoa,cpf,endereco,dataNascimento)
VALUES  ('ANA CAROLINA', '00000000000', 'Rua Silva Jardim', '1996-06-07'),
        ('EDUARDO', '00000000001', 'Rua Andradas', '1995-10-19'),
        ('VIVIAN', '00000000002', 'Rua Margaridas', '1975-08-03'),
        ('CRISTINE', '00000000003', 'Rua Venancio Aires', '1976-07-02'),
        ('JAMES', '00000000004', 'Rua Coronel Niederauer', '1960-04-18'),
        ('FERNANDO', '00000000005', 'AV Dores', '1965-10-05');

INSERT INTO ESPECIALIDADE (nomeEspecialidade)
VALUES ('CLINICO GERAL'),
       ('CARDIOLOGISTA');

INSERT INTO RECEBIVEIS(nomeRecebiveis, remuneracao)
VALUES ('SALÁRIO BASE MÉDICO', 10000),
       ('ESPECIALIDADE CARDIOLOGISTA', 5000),
       ('PLANTAO MEDICO 12H', 2000);

INSERT INTO EXAME(nomeExame, descricaoResultado)
VALUES ('COLESTEROL LDL', 125),
       ('TRIGLICERIDEOS', 105);

INSERT INTO PACIENTE(fk_idPessoa)
VALUES (2),
	   (5),
	   (6);

INSERT INTO FUNCIONARIO(cargo, fk_idPessoa)
VALUES  ('MEDICO', 1),
	    ('ENFERMEIRA', 3),
		('MEDICO', 4); 

INSERT INTO MEDICO(crm, fk_idFuncionario)
VALUES (12887, 3);

INSERT INTO ATENDIMENTO(data, hora, fk_idMedico,fk_idPaciente)
VALUES	('2022-08-30', '12:00:00', 1, 1),
		('2022-08-30', '13:25:00', 1, 2),
	    ('2022-08-30', '14:00:00', 1, 3);

INSERT INTO ATENDIMENTO_EXAME(descricaoAtendimento_Exame, fk_idAtendimento, fk_idExame)
VALUES ('Foi solicitado exame de colesterol LDL no paciente visto que há problemas genéticos e o paciente está obeso', 2, 1),
	   ('', 3, 2);

INSERT INTO MEDICO_ESPECIALIDADE(fk_idMedico, fk_idEspecialidade)
VALUES (1, 1),
	   (3, 2);

INSERT INTO FUNCIONARIO_RECEBIVEIS(fk_idFuncionario, fk_idRecebiveis)
VALUES (1, 1),
	   (1, 3),
	   (1, 3),
	   (1, 3),
	   (3, 1),
	   (3, 2),
	   (3, 3);
	   






UPDATE PRODUTOS SET codBarras = '326068406549804964' WHERE id = 1;
SELECT * FROM PRODUTOS FOR system_time all WHERE id =1 ORDER BY INICIO ASC;