create table produtos (
    id integer not null unique,
    nome varchar(50) not null,
    estoque integer
)

create sequence seq_produtos
increment by 1 no maxvalue no minvalue
cache 1

alter sequence seq_produtos owned by produtos.id

alter table produtos alter column id set default nextval('seq_produtos':: regclass)

insert into produtos(nome, estoque) values ('teclado dell 10PH', 23), ('monitor dell P22H27', 7), ('monitor dell 77F24', 10), ('mouse dell MS22', 18)

create table vendas (
    id integer not null unique,
    fk_produto integer,
    quantidade integer not null,
    constraint fk_produto_id foreign key (fk_produto) references produtos(id)
)

create sequence seq_vendas increment by 1 no maxvalue no minvalue cache 1

alter sequence seq_vendas owned by vendas.id

alter table vendas alter column id set default nextval('seq_vendas'::regclass)

select * from produtos

--criando uma função cujo retorno será uma trigger
create or replace function verificaestoque() returns trigger as $BODY$
declare
    estoqueatual integer := 0;
begin
    estoqueatual := (select produtos.estoque from produtos where produtos.id = new.fk_produto);
    --new representa o dado que está sendo inserido na tabela
    if(estoqueatual >= new.quantidade) then
        update produtos set estoque = (estoqueatual - new.quantidade) where produtos.id = new.fk_produto;
    else
        new.quantidade = estoqueatual;
        update produtos set estoque = (estoqueatual - new.quantidade) where produtos.id = new.fk_produto;
    end if;
    return new;
end;
$BODY$
language plpgsql volatile; --definindo que a linguagem dessa trigger é plpgsql

create trigger trigger_estoque_vendas after insert or update
on vendas
for each row execute procedure verificaestoque();

insert into vendas (fk_produto, quantidade) values (2, 3);