-- Criação do banco de dados

--CREATE DATABASE db_dinossauros;

-- Criação das tabelas
CREATE TABLE dinossauros
(
    id integer not null unique,
    nome varchar(30) not null,
    toneladas integer not null,
    anoDescoberta integer not null,
    territorio varchar(30),
    fk_grupo integer not null,
    fk_descobridor integer not null,
    fk_era integer not null,
    constraint fk_grupo_id foreign key(fk_grupo) references grupos(id),
    constraint fk_descobridor_id foreign key(fk_descobridor) references descobridores(id),
    constraint fk_era_id foreign key(fk_era) references eras(id)
);

CREATE TABLE eras
(
    id integer not null unique,
    nome varchar(30) not null,
    anoInicio integer not null,
    anoFim integer not null
);

CREATE TABLE grupos
(
    id integer not null unique,
    nome varchar(30) not null,
    tipoAlimentacao varchar(30) not null
);

CREATE TABLE descobridores
(
    id integer not null unique,
    nome varchar(50) not null
);

DROP TABLE descobridores CASCADE

-- Criação das sequências para auto-incrementação das tabelas id

-- Dinossauros
CREATE SEQUENCE dinossauros_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE dinossauros_id_seq
OWNED BY dinossauros.id;

ALTER TABLE dinossauros
ALTER COLUMN id
SET DEFAULT nextval('dinossauros_id_seq'::regclass);

-- Eras
CREATE SEQUENCE eras_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE eras_id_seq
OWNED BY eras.id;

ALTER TABLE eras
ALTER COLUMN id
SET DEFAULT nextval('eras_id_seq'::regclass);

-- Grupos
CREATE SEQUENCE grupos_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE grupos_id_seq
OWNED BY grupos.id;

ALTER TABLE grupos
ALTER COLUMN id
SET DEFAULT nextval('grupos_id_seq'::regclass);

-- Descobridores
CREATE SEQUENCE descobridores_id_seq
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;

ALTER SEQUENCE descobridores_id_seq
OWNED BY descobridores.id;

ALTER TABLE descobridores
ALTER COLUMN id
SET DEFAULT nextval('descobridores_id_seq'::regclass);

-- INSERTS nas tabelas

-- Eras
INSERT INTO eras (nome, anoInicio, anoFim) VALUES ('Triássico', 251, 199);
INSERT INTO eras (nome, anoInicio, anoFim) VALUES ('Jurássico', 200, 145);
INSERT INTO eras (nome, anoInicio, anoFim) VALUES ('Creatáceo', 144, 65);

-- Grupos
INSERT INTO grupos (nome, tipoAlimentacao) VALUES ('Anquilossauros', 'herbívoro');
INSERT INTO grupos (nome, tipoAlimentacao) VALUES ('Ceratopsídeos', 'herbívoro');
INSERT INTO grupos (nome, tipoAlimentacao) VALUES ('Estegossauros', 'herbívoro');
INSERT INTO grupos (nome, tipoAlimentacao) VALUES ('Terápodes', 'carnívoro ou onívoro');

-- Descobridores
INSERT INTO descobridores (nome) VALUES ('Maryanska');
INSERT INTO descobridores (nome) VALUES ('John Bell Hatcher');
INSERT INTO descobridores (nome) VALUES ('Cientistas alemães');
INSERT INTO descobridores (nome) VALUES ('Museu Americano de História Natural');
INSERT INTO descobridores (nome) VALUES ('Othniel Charles Marsh');
INSERT INTO descobridores (nome) VALUES ('Barnum Brown');

-- Dinossauros
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Saichania', 4, 1977, 'Mongólia', 1, 1, 3);
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Tricerátops', 6, 1887, 'Canadá', 2,  2, 3);
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Kentrossauro', 2, 1909, 'Tanzânia', 3, 3, 2);

-- SELECTS nas tabelas
SELECT * FROM eras;
SELECT * FROM grupos;
SELECT * FROM descobridores;
SELECT * FROM dinossauros;




