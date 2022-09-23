--CREATE DATABASE db_dados_desmatamento;

CREATE TABLE regioes
(
	idRegiao int primary key not null identity,
	nome varchar(30) not null,
	localizacao varchar(30) not null,
)

create table desmatamento
(
	idDesmatamento integer not null primary key identity,
	idRegiao_fk int foreign key references regioes(idRegiao),
	ano varchar(10) not null,
	area float not null,
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim)
)
with (system_versioning = ON (history_table = dbo.desmatamentoHistorico))

INSERT INTO regioes(nome, localizacao) VALUES ('Pantanal', 'Centro-oeste');
INSERT INTO regioes(nome, localizacao) VALUES ('Pampas', 'Sul');

INSERT INTO desmatamento(idRegiao_fk, ano, area) VALUES (1, '2018', 200.32);
INSERT INTO desmatamento(idRegiao_fk, ano, area) VALUES (1, '2019', 230.89);
INSERT INTO desmatamento(idRegiao_fk, ano, area) VALUES (2, '2018', 150.15);
INSERT INTO desmatamento(idRegiao_fk, ano, area) VALUES (2, '2019', 148.72);

UPDATE desmatamento SET area = 210.35 WHERE idDesmatamento = 1;

SELECT * FROM regioes;
SELECT * FROM desmatamento;
SELECT * FROM desmatamentoHistorico;

alter table desmatamento set (system_versioning = OFF);
drop table desmatamento;
