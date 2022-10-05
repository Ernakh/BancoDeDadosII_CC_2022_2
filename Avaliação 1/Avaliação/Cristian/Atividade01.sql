create database ecomerce 

create table cliente
(
	id_cliente integer not null primary key identity,
	nome varchar (45),
	CPF varchar (11),
	endereco varchar (50)
)

create table pedido
(
	id_pedido integer not null primary key identity,
	fk_cliente integer,
	numero_pedido varchar (20),
	valor float,
	foreign key (fk_cliente) references cliente(id_cliente)
)

create table entrega
(
	id_entrega integer not null primary key identity,
	fk_cliente integer,
	fk_pedido integer,
	valor_frete int,
	situacao varchar(20),
	localizacao varchar (30),
	foreign key (fk_cliente) references cliente(id_cliente),
	foreign key (fk_pedido) references pedido(id_pedido),
	inicio datetime2 generated always as row start not null,
    fim datetime2 generated always as row end not null,
        period for system_time (inicio, fim)
)
with
(
	system_versioning = ON (history_table = dbo.entrega_historico)
)

select * from cliente
select * from pedido 
select * from entrega 

insert into cliente (nome, CPF, endereco)
values ('Cristian', '12345678910', 'Coronel Niederauer')

insert into pedido (numero_pedido, valor)
values ('N1257QW', '10.25')

insert into entrega (valor_frete, situacao, localizacao)
values (20, 'Enviado', 'Porto Alegre')


update entrega  set localizacao = 'Santa Maria' where id = 1

