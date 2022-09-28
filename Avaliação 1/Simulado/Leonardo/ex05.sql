create database universidade

create table alunos
(
	id integer primary key identity,
	nome varchar(50) not null,
	cpf varchar(11) not null,
	email varchar(30) not null
)

create table cursos
(
	id integer primary key identity,
	nome varchar (30) not null,
	area varchar (30)
)

create table alunos_cursos
(
	id integer primary key identity,
	matricula varchar(8),
	fk_aluno integer,
	fk_curso integer,
	foreign key (fk_aluno) references alunos(id),
	foreign key (fk_curso) references cursos(id)
)

insert into alunos values ('Leonardo Pereira', '15926835747', 'leo@ufn.edu.br'),
	('Bruno Silva', '47895126347', 'bruno@ufn.edu.br'),
	('Rafael Moreira', '36547128945', 'rafael@ufn.edu.br'),
	('Julia Teixeira', '23148657948', 'julia@ufn.edu.br')
select * from alunos

insert into cursos values ('Medicina', 'Ciências da Saúde'),
	('Sistemas de Informação', 'Ciências Tecnolológicas'),
	('Direito', 'Ciências Sociais')
select * from cursos

drop trigger verificamatricula

create trigger verificamatricula
on alunos_cursos
after insert 
as
	declare @aluno integer 
	declare @curso integer
	declare @contagem integer
	select @aluno = (select fk_aluno from inserted)
	select @curso = (select fk_curso from inserted)
	select @contagem = (select count(*) from alunos_cursos where fk_aluno = @aluno and fk_curso = @curso)
	print (@contagem);
	if(@contagem = 1)
	begin
		print('Aluno matriculado!');
	end
	else
	begin
		rollback;
		raiserror('Aluno já matriculado no curso.', 16, 1);
	end

insert into alunos_cursos values ('2021001', 1, 1)
insert into alunos_cursos values ('2021002', 1, 1)
insert into alunos_cursos values ('2021033', 2, 2)

select * from alunos_cursos