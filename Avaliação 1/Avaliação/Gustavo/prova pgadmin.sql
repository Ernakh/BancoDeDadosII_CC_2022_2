--exercicio 1

create table entrega
(
id INTEGER not null UNIQUE,
cidade_atual varchar (50) not null,
ultima_cidade_visitada varchar (50),
dias_em_trasporte integer
)


create sequence entrega_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence entrega_id_seq
owned by entrega.id

alter TABLE entrega
alter COLUMN id 
set default nextval('entrega_id_seq'::regclass);

create table cliente
(
id INTEGER not null UNIQUE,
fk_entrega_id integer not null,    
constraint fk_item foreign key(fk_entrega_id) references entrega(id)
)

create sequence cliente_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence cliente_id_seq
owned by cliente.id

alter TABLE cliente
alter COLUMN id 
set default nextval('cliente_id_seq'::regclass);

create or replace function movimentacao() returns 
trigger as $BODY$
DECLARE
    ultimo_local varchar(50) :=  (select entrega.cidade_atual from entrega where id= id);
begin
new.ultima_cidade_visitada := ultimo_local;
return new;
end;
$BODY$
language plpgsql VOLATILE;



create trigger movimentacao before
update on entrega
FOR EACH ROW EXECUTE PROCEDURE movimentacao();


SELECT * from entrega
SELECT * from cliente

insert into entrega(cidade_atual) values ('sao paulo')
insert into cliente(fk_entrega_id) values (1)
update entrega set cidade_atual = 'campinas'
update entrega set cidade_atual = 'santa maria'




--exercicio 2

create table item
(
id INTEGER not null UNIQUE,
nome varchar (50) not null,
quantidade integer
)


create sequence item_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence item_id_seq
owned by item.id

alter TABLE item
alter COLUMN id 
set default nextval('item_id_seq'::regclass);

create table venda
(
id INTEGER not null UNIQUE,
fk_item_id integer not null,    
constraint fk_item foreign key(fk_item_id) references item(id)
)

create sequence venda_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence venda_id_seq
owned by venda.id

alter TABLE venda
alter COLUMN id 
set default nextval('venda_id_seq'::regclass);

CREATE OR REPLACE FUNCTION vendeu_item()
RETURNS trigger AS $BODY$
BEGIN
/* Aqui definimos nossos códigos.*/
if( (select item.quantidade from item where id= new.fk_item_id) >= 1) then
        update item set quantidade = quantidade - 1
        where item.id = NEW.fk_item_id;
        raise notice 'venda bem sucedida,numero atual em estoque pos venda: %  %',(select item.quantidade from item where id= id), E'\n';
    else
        RAISE EXCEPTION 'nao temos mais em estoque';
    end if;
    RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;



create trigger trigger_vendeu after
insert on venda
FOR EACH ROW EXECUTE PROCEDURE vendeu_item();


SELECT * from item
SELECT * from venda

insert into item(nome,quantidade) values ('dualsense',3)
insert into venda(fk_item_id) values (1)








--exercicio 3

--execute essa linha abaixo,pra evitar conflito com exercicio 1
drop table cliente
--pode proseguir com seguranca

create table cliente
(
id INTEGER not null UNIQUE,
nome varchar (50) not null,
sexo VARCHAR(12)
)


create sequence cliente_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence cliente_id_seq
owned by cliente.id

alter TABLE cliente
alter COLUMN id 
set default nextval('cliente_id_seq'::regclass);

create or replace function verificagenero() returns 
trigger as $BODY$
DECLARE
    genero varchar(12) := 'masculino' ;
begin
genero := (select cliente.sexo 
from cliente where cliente.id = NEW.id);
if(genero = 'masculino') then
update cliente set nome = ('Sr ' || nome)
where cliente.id = NEW.id;
else
update cliente set nome = ('Ms ' || nome)
where cliente.id = NEW.id;
end if;
return new;
end;
$BODY$
language plpgsql VOLATILE;



create trigger trigger_verificagenero after
insert on cliente
FOR EACH ROW EXECUTE PROCEDURE verificagenero();


SELECT * from cliente

insert into cliente(nome,sexo) values ('gustavo','masculino')
insert into cliente(nome,sexo) values ('ana','feminino')

