create table pessoa
(
id INTEGER not null UNIQUE,
nome varchar (50) not null,
maior VARCHAR(10),
ano_nascimento INTEGER not null
)
drop table pessoa

create sequence pessoas_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence pessoas_id_seq
owned by pessoa.id

alter TABLE pessoa
alter COLUMN id 
set default nextval('pessoas_id_seq'::regclass);

create or replace function verificaidade() returns 
trigger as $BODY$
DECLARE
    ano_nascimento integer := 0;
begin
ano_nascimento := (select pessoa.ano_nascimento 
from pessoa where pessoa.id = NEW.id);
if(ano_nascimento <= 2004) then
update pessoa set maior = ('SIM')
where pessoa.id = NEW.id;
else
update pessoa set maior = ('NAO')
where pessoa.id = NEW.id;
end if;
return new;
end;
$BODY$
language plpgsql VOLATILE;



create trigger trigger_confirma_maioridade after
insert on pessoa
FOR EACH ROW EXECUTE PROCEDURE verificaidade();


SELECT * from pessoa

insert into pessoa(nome,ano_nascimento) values ('gustavo',1996)
insert into pessoa(nome,ano_nascimento) values ('joao',2007)
insert into pessoa(nome,ano_nascimento) values ('vitoria',2010)
insert into pessoa(nome,ano_nascimento) values ('jessica',2003)

