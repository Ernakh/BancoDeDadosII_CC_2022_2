-- Criação do banco de dados
--CREATE DATABASE db_dinossauros;

-- Criação das tabelas
CREATE TABLE eras
(
    id integer not null unique,
    nome varchar(30) not null,
    anoInicioEra integer not null,
    anoFimEra integer not null
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

CREATE TABLE dinossauros
(
    id integer not null unique,
    nome varchar(30) not null,
    toneladas integer not null,
    anoDescoberta integer not null,
    territorio varchar(30),
    anoInicio integer not null,
    anoFim integer not null,
    fk_grupo integer not null,
    fk_descobridor integer not null,
    fk_era integer not null,
    constraint fk_grupo_id foreign key(fk_grupo) references grupos(id),
    constraint fk_descobridor_id foreign key(fk_descobridor) references descobridores(id),
    constraint fk_era_id foreign key(fk_era) references eras(id)
);

-- Criação das sequências para auto-incrementação das tabelas id
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

-- INSERTS nas tabelas
-- Eras
INSERT INTO eras (nome, anoInicioEra, anoFimEra) VALUES ('Triássico', 251, 200);
INSERT INTO eras (nome, anoInicioEra, anoFimEra) VALUES ('Jurássico', 200, 145);
INSERT INTO eras (nome, anoInicioEra, anoFimEra) VALUES ('Creatáceo', 145, 65);

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

-- Criação da função I -> valida os anos iniciais e finais da existência do dinossauros inserido ou atualizado
CREATE OR REPLACE FUNCTION func_valida_periodo() RETURNS TRIGGER AS $BODY$
DECLARE
    inicioEra integer := (SELECT anoInicioEra FROM eras WHERE id = NEW.fk_era);
    fimEra integer := (SELECT anoFimEra FROM eras WHERE id = NEW.fk_era);  
BEGIN
    IF (NEW.anoInicio > inicioEra OR NEW.anoInicio < fimEra OR NEW.anoFim < fimEra OR NEW.anoFim > inicioEra) THEN
        RAISE NOTICE 'Erro, período de existência do dinossauro não condiz com a era associada a ele; OPERAÇÃO CANCELADA!';
        ROLLBACK;
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

-- Criação da Trigger
CREATE OR REPLACE TRIGGER trigger_valida_periodo BEFORE INSERT OR UPDATE
ON dinossauros
FOR EACH ROW EXECUTE PROCEDURE func_valida_periodo();

-- Dinossauros
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, anoInicio, anoFim, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Saichania', 4, 1977, 'Mongólia', 145, 66, 1, 1, 3);
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, anoInicio, anoFim, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Tricerátops', 6, 1887, 'Canadá', 70, 66, 2,  2, 3);
INSERT INTO dinossauros (nome, toneladas, anoDescoberta, territorio, anoInicio, anoFim, fk_grupo, fk_descobridor, fk_era) 
VALUES ('Kentrossauro', 2, 1909, 'Tanzânia', 200, 145, 3, 3, 2);
INSERT INTO dinossauros ( nome, toneladas, anoDescoberta, territorio, anoInicio, anoFim, fk_grupo, fk_descobridor, fk_era)
VALUES ('Pinacossauro', 6, 1999, 'China', 85, 75, 1, 4, 1);

-- Remoção de dados/testes
--TRUNCATE eras;
--DELETE FROM eras;
--ALTER SEQUENCE eras_id_seq RESTART;

--TRUNCATE dinossauros;
--DELETE FROM dinossauros;
--ALTER SEQUENCE dinossauros_id_seq RESTART;

--drop table dinossauros cascade;

-- SELECTS nas tabelas
--SELECT * FROM eras;
--SELECT * FROM grupos;
--SELECT * FROM descobridores;
SELECT * FROM dinossauros;























