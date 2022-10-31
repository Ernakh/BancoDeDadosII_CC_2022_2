/*
1. Crie um banco de dados que relacione Clientes - Compras e
Produtos. Insira vários registros neste banco.
*/

create database db_281022;
use db_281022;
go

create table cliente
(
      idCliente integer not null primary key identity,
      nomeCliente varchar(60),
        cpf varchar(11),  
)
go

create table compra
(
      idCompra integer not null primary key identity,
      dataHora varchar(50),
        fk_idCliente integer,
        foreign key (fk_idCliente) references CLIENTE(idCliente)    
)
go

create table produto
(
      idProduto integer not null primary key identity,
      nomeProduto varchar(60),
      precoUnitario decimal(10,2),
      qtdEstoque integer
)
go

create table pedido
(
      precoVenda decimal(10,2),
      qtd integer,
        fk_idCompra integer,
      foreign key (fk_idCompra) references COMPRA(idCompra),
        fk_idProduto integer,
      foreign key (fk_idProduto) references PRODUTO(idProduto)
)
go


insert into cliente(nomeCliente, cpf) values ('Eduardo', '02059056098');
insert into cliente(nomeCliente, cpf) values ('Ana', '02619132045');
insert into cliente(nomeCliente, cpf) values ('Alex', '04487094122');
insert into cliente(nomeCliente, cpf) values ('Emanuele', '32047756831');
insert into cliente(nomeCliente, cpf) values ('Jessica', '78947032280');

insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 1);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 1);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 2);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 3);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 3);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 4);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 4);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 5);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 5);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 1);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 2);
insert into compra(dataHora, fk_idCliente) values ('2022-10-30', 3);

insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Lapis Verde', 1.9, 100);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Caderno Azul', 4.9, 50);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Caneta Preta', 2.9, 80);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Marcador Texto Amarelo', 4.9, 30);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Papel A4', 18.9, 20);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Caixa Grampos', 7.6, 20);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Grampeador', 29.8, 5);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Lapis Preto', 1.8, 80);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Caderno Amarelo', 5.2, 50);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Caneta Vermelha', 2.9, 60);
insert into produto(nomeProduto, precoUnitario, qtdEstoque)  values ('Marcador Texto Verde', 4.9, 30);

insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (2.8, 2, 1, 1);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (6.7, 1, 1, 2);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (6.8, 2, 2, 2);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (3.5, 1, 3, 3);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (4.9, 1, 4, 4);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (19.8, 1, 4, 5);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (19.9, 1, 5, 5);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (8.5, 2, 6, 6);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (35.6, 2, 7, 7);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (2.7, 2, 8, 8);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (7.8, 2, 9, 9);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (2.8, 1, 10, 10);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (4.9, 1, 11, 11);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (2.85, 2, 11, 1);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (6.95, 3, 12, 2);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (3.49, 1, 12, 3);
insert into pedido(precoVenda, qtd, fk_idCompra, fk_idProduto) values (5.1, 1, 12, 4);

/*
select cliente.nomeCliente, compra.idCompra, sum(pedido.precoVenda*pedido.qtd) as 'subtotal'
from pedido
inner join compra on pedido.fk_idCompra = compra.idCompra
inner join cliente on compra.fk_idCliente = cliente.idCliente
where pedido.fk_idCompra = compra.idCompra
group by cliente.nomeCliente, compra.idCompra


select cliente.nomeCliente as 'Cliente', sum(pedido.precoVenda*pedido.qtd) as 'Total Gasto'
from pedido
inner join compra on pedido.fk_idCompra = compra.idCompra
inner join cliente on compra.fk_idCliente = cliente.idCliente
where pedido.fk_idCompra = compra.idCompra
group by cliente.nomeCliente, compra.fk_idCliente */

/*



2. Crie o seguinte: um SELECT para retornar o nome do cliente e o valor
total de cada uma das suas compras.
*/

drop view viewSubtotalGastoCliente;
go

create view viewSubtotalGastoCliente as
select cliente.nomeCliente, compra.idCompra, sum(pedido.precoVenda*pedido.qtd) as 'subtotal'
from pedido, compra, cliente
where pedido.fk_idCompra = compra.idCompra
and cliente.idCliente = compra.fk_idCliente
group by cliente.nomeCliente, compra.fk_idCliente, compra.idCompra
go

select * from viewSubtotalGastoCliente;
go

/* 3. Depois utilize os dados gerados na última pesquisa em uma nova
pesquisa onde agrupe o total de gastos por cada pessoa. (GROUP BY,
e ORDER BY). Use as palavras reservadas AS para nomear o o
resultado da consulta do passo 2

*/

drop view viewTotalGastoCliente;
go

create view viewTotalGastoCliente as
select cliente.nomeCliente as 'Cliente', sum(pedido.precoVenda*pedido.qtd) as 'Total Gasto'
from pedido, compra, cliente
where pedido.fk_idCompra = compra.idCompra
and cliente.idCliente = compra.fk_idCliente
group by cliente.nomeCliente, compra.fk_idCliente
go

select * from viewTotalGastoCliente;
go

