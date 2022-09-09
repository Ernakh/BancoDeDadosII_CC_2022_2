create database aula

create table produtos
(
    id integer not null unique,
    nome varchar(50) not null,
    estoque integer
)

create sequence produtos_id_seq owned by produtos.id
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence produtos_id_seq
owned by produtos.id

alter table produtos
alter column id
set default nextval('produtos_id_seq'::regclass);

create table vendas
(
    id integer not null unique,
    fk_produto integer,
    quantidade integer not null,
    constraint fk_produtos_id foreign key
        (fk_produto) references produtos(id)
)

create sequence vendas_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence vendas_id_seq
owned by vendas.id

alter table vendas
alter column id
set default nextval('vendas_id_seq'::regclass)

insert into produtos (nome, estoque) values ('produto 1', 5)
insert into produtos (nome, estoque) values ('produto 2', 25)
insert into produtos (nome, estoque) values ('produto 3', 17)

select * from produtos

create or replace function verificaestoque() 
returns trigger as $BODY$
DECLARE
    estoqueatual integer := 0;
BEGIN
    estoqueatual :=(select produtos.estoque
                     from produtos where produtos.id = NEW.fk_produto);
    IF(estoqueatual > NEW.quantidade) then
       update produtos set estoque = (estoqueatual - NEW.quantidade)
                       where produtos.id = NEW.fk_produto;
    ELSE
        RAISE EXCEPTION 'Sem estoque para efetuar a venda!!';
    END IF;
    RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;

create trigger trigger_estoque_vendas
AFTER INSERT OR UPDATE
ON vendas
FOR EACH ROW EXECUTE PROCEDURE verificaestoque();

select * from produtos

insert into vendas(fk_produto, quantidade) values (2,5)

insert into vendas(fk_produto, quantidade) values (1, 10)