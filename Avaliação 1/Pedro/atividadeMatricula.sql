--CREATE DATABASE db_matricula;

CREATE TABLE alunos
(
    id integer not null unique,
    nome varchar(30) not null
);

CREATE TABLE cursos
(
    id integer not null unique,
    nome varchar(30) not null
);

CREATE TABLE matriculas
(
    id integer not null unique,
    fk_aluno integer not null,
    fk_curso integer not null,
    constraint fk_aluno_id foreign key(fk_aluno) references alunos(id),
    constraint fk_curso_id foreign key(fk_curso) references cursos(id)
);

CREATE SEQUENCE alunos_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE alunos_id_seq
OWNED BY alunos.id;

ALTER TABLE alunos
ALTER COLUMN id
SET DEFAULT nextval('alunos_id_seq'::regclass);

CREATE SEQUENCE cursos_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE cursos_id_seq
OWNED BY cursos.id;

ALTER TABLE cursos
ALTER COLUMN id
SET DEFAULT nextval('cursos_id_seq'::regclass);

CREATE SEQUENCE matriculas_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE matriculas_id_seq
OWNED BY matriculas.id;

ALTER TABLE matriculas
ALTER COLUMN id
SET DEFAULT nextval('matriculas_id_seq'::regclass);

INSERT INTO alunos (nome) VALUES ('Pedro');
INSERT INTO alunos (nome) VALUES ('Roger');
INSERT INTO alunos (nome) VALUES ('Maria');

INSERT INTO cursos (nome) VALUES ('Direito');
INSERT INTO alunos (nome) VALUES ('Medicina');
INSERT INTO alunos (nome) VALUES ('Engenharia');

INSERT INTO matriculas(fk_aluno, fk_curso) VALUES ('1', '1');

-- FUNCTION

-- TRIGGER




























