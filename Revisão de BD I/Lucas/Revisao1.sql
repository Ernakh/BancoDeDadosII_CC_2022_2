CREATE DATABASE Consultorio

USE consultorio

CREATE TABLE Pessoa
(
	idPessoa INTEGER not null PRIMARY KEY IDENTITY,
	nome VARCHAR(50) not null,
	dataNasc DATE,
	rg VARCHAR(11) not null,
	cpf VARCHAR(14) not null UNIQUE,
	endereco VARCHAR(90),
	altura INTEGER
)

SELECT * FROM Pessoa

CREATE TABLE Telefone
(
	idTel INTEGER not null PRIMARY KEY IDENTITY,
	fkPessoa INTEGER, 
	codArea VARCHAR(4) not null,
	numeroTel VARCHAR(11) not null, 
	descricao VARCHAR(150),
	FOREIGN KEY (fkPessoa) REFERENCES Pessoa(idPessoa)
)

SELECT * FROM Telefone

CREATE TABLE Medico
(
	idMed INTEGER not null PRIMARY KEY IDENTITY,
	fkPessoa INTEGER not null,
	crm VARCHAR(20),
	FOREIGN KEY (fkPessoa) REFERENCES Pessoa(idPessoa)
)

SELECT * FROM Medico

CREATE TABLE Consulta
(
	idConsulta INTEGER not null PRIMARY KEY IDENTITY,
	fkPessoa INTEGER not null,
	fkMed  INTEGER not null,
	data DATE,
	histClinico VARCHAR(200),
	pressao VARCHAR(10),
	massa INTEGER,
	FOREIGN KEY (fkPessoa) REFERENCES Pessoa(idPessoa),
	FOREIGN KEY (fkMed) REFERENCES Medico(idMed)
)

SELECT * FROM Consulta

CREATE TABLE Especialidade
(
	idEspec INTEGER not null PRIMARY KEY IDENTITY,
	nome VARCHAR(20)
)

SELECT * FROM Especialidade

CREATE TABLE Medico_Espec
(
	fkMed INTEGER not null,
	fkEspec INTEGER not null,
	FOREIGN KEY (fkMed) REFERENCES Medico(idMed),
	FOREIGN KEY (fkEspec) REFERENCES Especialidade(idEspec)
)

SELECT * FROM Medico_Espec

CREATE TABLE Medicamentos
(
	idMedicamento INTEGER not null PRIMARY KEY IDENTITY,
	descricao VARCHAR(200) not null,
	nome VARCHAR(50) not null
)

SELECT * FROM Medicamentos

CREATE TABLE Cons_Medic
(
	fkConsulta INTEGER not null,
	fkMedicamento INTEGER not null,
	uso VARCHAR(100),
	FOREIGN KEY (fkConsulta) REFERENCES Consulta(idConsulta),
	FOREIGN KEY (fkMedicamento) REFERENCES Medicamentos(idMedicamento),
	PRIMARY KEY (fkConsulta, fkMedicamento)
)

SELECT * FROM Cons_Medic

CREATE TABLE Patologia
(
	idPat INTEGER not null PRIMARY KEY IDENTITY,
	codCid10 VARCHAR(50) not null, 
	descricao VARCHAR(150)
)

SELECT * FROM Patologia

CREATE TABLE Cons_Pat
(
	fkConsulta INTEGER not null,
	fkPat INTEGER not null, 
	obs VARCHAR(100),
	tratamento VARCHAR(200)
	FOREIGN KEY (fkConsulta) REFERENCES Consulta(idConsulta),
	FOREIGN KEY (fkPat) REFERENCES Patologia(idPat),
	PRIMARY KEY (fkConsulta, fkPat)
)

SELECT * FROM Cons_Pat