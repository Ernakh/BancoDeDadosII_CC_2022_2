create database exercicio4
create database exercicio5
create database exercicio6

-- exercicio 1
--   um banco temporal é um tipo de banco de dados que inves de sobrepor 
--   os dados com dados novos,salva os antigos em um tipo de historico.
--   exemplos de aplicacoes que se benificiam dele:
--      1)historico de clientes que se beneficiaram de algum servico , nomes dos clientes que pegaram um dvd na locadora
--      2)qualquer banco que precise de contexto, exemplo  banco de jogadas de xadrez feitas por um jogador,
--        onde ele guarda no instante a jogada atual e possui o historico de jogadas anteriores
--      3)banco de dados de algum dado que vive mudando e precisa se ter um historico dele pra depois 
--        , exemplo banco de dado do batimento de um paciente a cada x minutos.

--exercicio 2
--  Banco de dados ativo é um banco baseado no uso de triggers , sendo mais complexo , mas 
--  mantendo o funcionamento de um banco convencional ao mesmo tempo que usa do poder 
--  computacional pra fazer bem mais coisas e ser mais reativo

--exercicio 3
--   exemplos de uso de trigger:
--      1)checar se um dado foi inserido dentro dos valores esperados(possiveis)
--      2)corrigir ou cancelar tentativas de inserir dados inconsistentes
--      3)automatizar alguma parte da insercao de dados nova com base nos valores fornecidos no update ou insert

--exercicio 4
-- jogadas xadrez
--nao existe como fazer temporal no postgress a tempo
create table jogada
(
	id integer not null unique,
	peca varchar (50) not null,
	movimentacao varchar (25) not null
)
create sequence jogadas_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence jogadas_id_seq
owned by jogada.id

alter TABLE jogada
alter COLUMN id 
set default nextval('jogadas_id_seq'::regclass);

-- exercico 5

create table curso
(
id INTEGER not null UNIQUE,
nome varchar (50) not null
)

create sequence curso_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence curso_id_seq
owned by curso.id

alter TABLE curso
alter COLUMN id 
set default nextval('curso_id_seq'::regclass);

create table aluno
(
id INTEGER not null UNIQUE,
nome varchar (50) not null
)

create sequence aluno_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence aluno_id_seq
owned by aluno.id

alter TABLE aluno
alter COLUMN id 
set default nextval('aluno_id_seq'::regclass);


create table matricula
(
id INTEGER not null UNIQUE,
fk_id_aluno integer not null,
constraint fk_id_aluno foreign key(fk_id_aluno) references aluno(id),
fk_curso_id integer not null,    
constraint fk_curso_id foreign key(fk_curso_id) references curso(id)
)

create sequence matricula_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence matricula_id_seq
owned by matricula.id

alter TABLE matricula
alter COLUMN id 
set default nextval('matricula_id_seq'::regclass);


CREATE OR REPLACE FUNCTION matricula_checker()
RETURNS trigger AS $BODY$
DECLARE
    --era varchar(50) := (select eras.nome from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --inicio integer := (select eras.inicio_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --fim integer := (select eras.fim_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
BEGIN
    --RAISE NOTICE 'inicio: %.',inicio;
    --RAISE NOTICE 'fim: %.',fim;
/* Aqui definimos nossos códigos.*/
if( new.fk_aluno_id = (select matricula.fk_id_aluno from matricula where id= new.fk_aluno_id) then
        RAISE EXCEPTION 'ja existe';
    else
        Raise Notice  'sucesso';
    end if;
    RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;

CREATE or REPLACE TRIGGER  matricula_checker
before INSERT or update ON matricula
FOR EACH ROW
EXECUTE PROCEDURE matricula_checker();



-- exercicio 6

create table notas_fiscais
(
id INTEGER not null UNIQUE,
dono_nome varchar (50) not null,
valor integer not null
)

create sequence notas_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence notas_id_seq
owned by notas_fiscais.id

alter TABLE notas_fiscais
alter COLUMN id 
set default nextval('notas_id_seq'::regclass);

create table logs
(
id INTEGER not null UNIQUE,
operacao varchar (50) not null
)

create sequence logs_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence logs_id_seq
owned by logs.id

alter TABLE logs
alter COLUMN id 
set default nextval('logs_id_seq'::regclass);


CREATE OR REPLACE FUNCTION block_checker()
RETURNS trigger AS $BODY$
DECLARE
    --era varchar(50) := (select eras.nome from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --inicio integer := (select eras.inicio_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --fim integer := (select eras.fim_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
BEGIN
    --RAISE NOTICE 'inicio: %.',inicio;
    --RAISE NOTICE 'fim: %.',fim;
/* Aqui definimos nossos códigos.*/
if(1=1) then
        --faltou por logs
        RAISE EXCEPTION 'proibido fazer isso';
    else
        Raise Notice  'vc burlou o sistema';
    end if;
    RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;

CREATE or REPLACE TRIGGER  block_checker
before drop or update ON notas_fiscais
FOR EACH ROW
EXECUTE PROCEDURE block_checker();


