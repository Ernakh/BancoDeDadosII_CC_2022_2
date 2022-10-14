--create database db_exercicio_integridade;

create table professores
(
	id int primary key not null,
	nome varchar(50) not null,
	rg varchar(20) unique not null,
	sexo char check(sexo in ('M', 'F')),
	idade integer check (idade between 21 and 70),
	titulacao varchar(30) check (titulacao in 
		('especialista', 'mestre', 'doutor', 'pós-doutor')),
	categoria varchar(30) check (categoria in
		('auxiliar', 'assistente', 'adjunto', 'titular')),
	numeroTurmas integer not null default 0
);
go

create table alunos
(
	id int primary key not null,
	nome varchar(30)
);
go

create table disciplinas
(
	id int primary key not null,
	nome varchar(30) not null,
	creditos integer check (creditos between 2 and 12)
);
go

create table cursos
(
	id int primary key not null,
	nome varchar(30) not null,
	duracao integer check (duracao between 6 and 12),
	coordenador integer not null,
	foreign key (coordenador) references professores(id)
);
go

create table curriculos
(
	id int primary key not null,
	semestre integer check (semestre between 1 and 12),
	fk_id_curso integer not null,
		foreign key (fk_id_curso) references cursos(id),
	fk_id_disci integer not null,
		foreign key(fk_id_disci) references disciplinas(id)
);
go

create table turmas
(
	id int primary key not null,
	vagas integer check (vagas > 0),
	fk_id_prof integer not null,
		foreign key (fk_id_prof) references professores(id),
	fk_id_disci integer not null,
		foreign key(fk_id_disci) references disciplinas(id)
);


-- INSERTS NAS TABELAS

--não tem as triggers de verificação, apenas as restrições de integridade da tabela
insert into professores(id, nome, rg, sexo, idade, titulacao, categoria)
	values(1, 'Jorge', '12 345 678-9', 'M', 25, 'especialista', 'auxiliar');

insert into professores(id, nome, rg, sexo, idade, titulacao, categoria)
	values(2, 'Maria', '98 765 432-1', 'F', 65, 'pós-doutor', 'titular');

insert into alunos(id, nome) values(1, 'Pedro');
insert into alunos(id, nome) values(2, 'Júlio');
insert into alunos(id, nome) values(3, 'Roberta');

insert into disciplinas(id, nome, creditos) values(1, 'Banco de Dados II', 4);
insert into disciplinas(id, nome, creditos) values(2, 'Programação Pyhon', 2);

insert into cursos(id, nome, duracao, coordenador) 
	values(1, 'Ciência da Computação', 8, 2);

insert into curriculos(id, semestre, fk_id_curso, fk_id_disci) 
	values(1, 8, 1, 2);

insert into turmas(id, vagas, fk_id_prof, fk_id_disci) values(1, 30, 1, 1);
insert into turmas(id, vagas, fk_id_prof, fk_id_disci) values(2, 12, 2, 2);

--SELECTS

select * from professores;
select * from alunos;
select * from disciplinas;
select * from cursos;
select * from curriculos;
select * from turmas;