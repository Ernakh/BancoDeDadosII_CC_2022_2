create database universidade

create table professores
(
	id integer primary key identity,
	nome varchar(40) not null,
	rg varchar(15) unique,
	sexo char check(sexo in('M', 'F', 'N')),
	idade integer check(idade between 21 and 70),
	titulacao varchar(15),
	categoria varchar(15),
	numeroTurmas integer default 0
)

create table cursos
(
	id integer primary key identity,
	nome varchar(40) not null,
	duracao integer check(duracao between 6 and 12),
	coordenador integer,
	foreign key (coordenador) references professores(id)
)

create table alunos
(
	id integer primary key identity,
	nome varchar(40) not null,
	cpf varchar(11) unique,
	fk_curso integer,
	foreign key (fk_curso) references cursos(id)
)

create table disciplinas
(
	id integer primary key identity,
	nome varchar(40) not null,
	creditos integer check(creditos between 2 and 12),
	semestre integer check(semestre between 1 and 12)
)

create table curriculo
(
	id integer primary key identity,
	semestre integer check(semestre between 1 and 12),
	fk_curso integer,
	fk_disciplina integer,
	foreign key (fk_curso) references cursos (id),
	foreign key (fk_disciplina) references disciplinas (id)
)

create table turmas
(
	id integer primary key identity,
	vagas integer check(vagas > 0),
	fk_professor integer,
	fk_disciplina integer,
	foreign key (fk_professor) references professores (id),
	foreign key (fk_disciplina) references disciplinas (id)
)

create trigger turmasprofs
on professores
after insert
as
	declare @turmas integer
	declare @turmaprof integer
	declare @profid integer

	select @profid = (select id from professores)
	select @turmaprof = (select fk_professor from turmas)
	select @turmas = (select count(fk_professor) from turmas where @turmaprof = @profid)
	
	begin
		update professores set numeroTurmas = @turmas
			where @turmaprof = @profid
	end

create trigger titulos
on professores
after insert
as
	declare @titulacao varchar(20)
	declare @categoria varchar(20)

	select @titulacao = (select titulacao from inserted)
	select @categoria = (select categoria from inserted)

	if(@titulacao = 'especialista')
		begin
			if(@categoria = 'auxiliar')
				begin
					print('Professor inserido com sucesso');
				end
			else
				begin
					print('Erro quanto a titulação e categoria');
					rollback;
				end
		end
	else if(@titulacao = 'mestre')
		begin
			if(@categoria = 'assistente')
				begin
					print('Professor inserido com sucesso');
				end
			else
				begin
					print('Erro quanto a titulação e categoria');
					rollback;
				end
		end
	else if(@titulacao = 'doutor' or @titulacao = 'pós-doutor')
		begin
			if(@categoria = 'adjunto' or @categoria = 'titular')
				begin
					print('Professor inserido com sucesso');
				end
			else
				begin
					print('Erro quanto a titulação e categoria');
					rollback;
				end
		end
	else
		begin
			print('Titulação ou categoria inválida');
		end


