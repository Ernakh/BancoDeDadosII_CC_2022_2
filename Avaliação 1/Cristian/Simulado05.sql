
create table aluno
(
	id_aluno integer not null primary key identity,
	nome_aluno varchar(45),
	cpf varchar(11),
)

create table curso
(
	id_curso integer not null primary key identity,
	nome_curso varchar(45),
	cod varchar(45),
)

create table matricula
(
	id_matricula integer not null primary key identity,
	fk_aluno integer,
    fk_curso integer,
	foreign key (fk_aluno) references aluno(id_aluno),
    foreign key (fk_curso) references curso(id_curso)
)

insert into aluno (nome_aluno, cpf) values('Cristian', '45615689778')
insert into curso (nome_curso, cod) values('Banco de Dados','G1-896')
insert into curso (nome_curso, cod) values('Sistemas Distribuidos','G1-786')


select * from aluno
select * from curso
select * from matricula


create trigger triggermatricula 
on matricula
after insert
as 
	declare @contagem integer
	declare @aluno integer
	declare @curso integer



	select @contagem = (select count(*) from matricula where fk_aluno = fk_aluno and fk_curso = fk_curso)

	IF @contagem = 0
		begin
			print ('Aluno matriculado neste curso');
		end
	 ELSE
           		  rollback;
                  RAISERROR('INVALIDO - Aluno já matriculaod neste curso');
                  RETURN;
            end
end
