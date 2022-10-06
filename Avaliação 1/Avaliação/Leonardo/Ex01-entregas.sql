create database delivery

create table produtos
(
	id integer primary key identity,
	nome varchar(30) not null,
	descrição varchar(30)
)

create table entregadores
(
	id integer primary key identity,
	nome varchar(30) not null,
	placa varchar(7)
)

create table entregas
(
	id integer primary key identity,
	valor money not null,
	status varchar(15) not null,
	endereco varchar(60) not null,
	fk_produto integer not null,
	fk_entregador integer,
	coordenadas varchar(20),
	foreign key (fk_produto) references produtos (id),
	foreign key (fk_entregador) references entregadores (id),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio, fim)
)
with
(
	system_versioning = ON (history_table = dbo.entregasHistorico)
)

insert into produtos values ('Pizza', 'Pizza de calabresa'), ('Refri', 'Coca-Cola lata'),
	('Chocolate', 'Barra de chocolate 300g')

insert into entregadores values ('Pedro', 'IXC2D37'), ('Lucas', 'IRY8009'), ('Gilmar', 'JBX0B34')

insert into entregas(valor, status, endereco, fk_produto, fk_entregador, coordenadas)
			values ('45', 'Em produção' , 'Rua Tuiuti 480', 1, 1, '90 W 110 S')


update entregas set status = 'A caminho' where id = 1
update entregas set coordenadas = '89 W 111 S' where id = 1
update entregas set coordenadas = '88 W 112 S' where id = 1

select * from entregas
select * from entregasHistorico








--create table log
--(
--	id integer primary key identity,
--	fk_entregador integer,
--	coordenadas varchar(20),
--	quando datetime not null,
--	foreign key (fk_entregador) references entregadores (id)
--)

create trigger atualizarloc
on entregas
after insert
as 
	begin
		insert into log values (1, '40 W 90 S', GETDATE());
		print('Produto saiu para entrega!');
	end