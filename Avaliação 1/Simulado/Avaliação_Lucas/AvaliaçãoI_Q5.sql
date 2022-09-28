create database AvaliaçãoI_Q5

use AvaliaçãoI_Q5
 
create table Curso
(
	id_curso integer not null identity primary key, 
	nome_curso varchar(50)
)

create table Aluno
(
	id_aluno integer not null identity primary key,
	nome_aluno varchar(50) not null, 
)

create table Matricula
(
	id_matricula integer not null identity primary key, 
	fk_aluno integer not null, 
	fk_curso integer not null, 
	foreign key (fk_aluno) references Aluno(id_aluno),
	foreign key (fk_curso) references Curso(id_curso)
)

select *
from Matricula

create trigger Valida_matricula
on Matricula
after insert
as
	declare @count integer
	declare @aluno integer
	declare @curso integer
	select @aluno = (select inserted.fk_aluno)
	IF @count > 0