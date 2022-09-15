-- 1 - Faça um banco de dados que, ao inserir uma pessoa, informa em um campo a informação 
-- 'SIM' ou 'NÃO' referente a pessoa ser maior de idade ou NÃO.
-- No "INSERT", o ano de nascimento deve ser inserido.

-- Aluno: Pedro Cassenote Batista
-- Data: 14/09/2022

------

create table pessoas
(
    id integer not null unique,
    nome varchar(50) not null,
    dataNascimento date not null,
    maioridade varchar(3)
)

create sequence pessoas_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence pessoas_id_seq
owned by pessoas.id;

alter table pessoas
alter column id
set default nextval('pessoas_id_seq '::regclass);

------

create or replace function verifica_idade() returns trigger as $BODY$
DECLARE 
    dataNascimento date := CURRENT_DATE;
BEGIN
    dataNascimento := (SELECT pessoas.dataNascimento 
                       FROM pessoas);
    IF(dataNascimento < (current_date - '18 years'::interval)::date) THEN
        update pessoas set maioridade = 'Sim' WHERE;
    ELSE
        update pessoas set maioridade = 'Não';
    END IF;
    RETURN NEW;
END
$BODY$
language plpgsql VOLATILE;

------

CREATE TRIGGER trigger_verifica_maioridade AFTER INSERT OR UPDATE
ON pessoas
FOR EACH ROW EXECUTE PROCEDURE verifica_idade();

------

insert into pessoas (nome, dataNascimento) values ('Pedro', '2002-11-13')
insert into pessoas (nome, dataNascimento) values ('Fulano', '2010-09-09')

DELETE FROM pessoas WHERE id = 2;

select * from pessoas

-- retorna MAIOR de 18 anos
SELECT * FROM pessoas WHERE dataNascimento < (current_date - '18 years'::interval)::date;
-- retorna MENOR de 18 anos
SELECT * FROM pessoas WHERE dataNascimento > (current_date - '18 years'::interval)::date;

------























