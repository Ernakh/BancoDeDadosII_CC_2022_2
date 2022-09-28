CREATE DATABASE AvaliaçãoI_Q4

USE AvaliaçãoI_Q4

CREATE TABLE Historico_escolar
(
	id_aluno integer not null identity primary key,
	nome_aluno varchar(50) not null, 
	parecer varchar(200), 
	notas float not null, 
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
		period for system_time (inicio, fim) 
)
with (system_versioning = ON)

select *
from Historico_escolar

insert into Historico_escolar (nome_aluno, parecer, notas)
values ('Tobias', 'Bota cara top de bola', 7.5)

update Historico_escolar
set parecer = 'Nem tão bom assim' 
where id_aluno = 1
