create database db_historicoEntrega;
use db_historicoEntrega;

create table entrega(
	idEntrega integer primary key identity,
	descricaoVeiculo varchar(50),
	horaSaida datetime default getdate(),
	localizacaoInicial varchar (150),
	localizacaoFinal varchar (150),
	distancia numeric(10,3),
	localizacaoAtual varchar (150),
	inicio datetime2 generated always as row start not null,
	fim datetime2 generated always as row end not null,
	period for system_time (inicio, fim)
) with
( system_versioning = ON )


select *from entrega;
insert into entrega(descricaoVeiculo, localizacaoInicial, localizacaoFinal, distancia)
values ('Ford Transit Branca ITH3A00', 'Rua Andradas 1449, Centro, Santa Maria, RS, Brasil, 97010-033', 'AV Euclides da Cunha 1667, Dores, Santa Maria, RS, Brasil, 97010-050', 2.5);

update entrega set localizacaoAtual = 'Rua Andradas 1449, Centro, Santa Maria, RS, Brasil, 97010-033', distancia = 2.5 where idEntrega=1;
update entrega set localizacaoAtual = 'Rua Andradas 1273, Centro, Santa Maria, RS, Brasil, 97010-033', distancia = 2.4 where idEntrega=1;
update entrega set localizacaoAtual = 'Rua Conde de Porto Alegre 239, Centro, Santa Maria, RS, Brasil, 97010-020', distancia = 2.3 where idEntrega=1;
update entrega set localizacaoAtual = 'Rua Silva Jardim 1175, Centro, Santa Maria, RS, Brasil, 97010-491', distancia = 2.2 where idEntrega=1;
update entrega set localizacaoAtual = 'Rua Silva Jardim 1475, Centro, Santa Maria, RS, Brasil, 97010-492', distancia = 2.0 where idEntrega=1;
update entrega set localizacaoAtual = 'Rua Silva Jardim 1694, Centro, Santa Maria, RS, Brasil, 97010-492', distancia = 1.8 where idEntrega=1;

select * from entrega
for system_time all
where idEntrega = 1
order by fim desc







create database db_produtos;
use db_produtos;

create table produto(
	idProduto integer primary key identity,
	descricao varchar(100),
	qtd integer
)

create table venda(
	qtdVendida integer,
	fk_idProduto integer,
	foreign key (fk_idProduto) references produto(idProduto)
)

select *from produto;
select *from venda;

select sum(v.qtdVendida)totalVendido
from venda as v 
inner join produto as p on p.idProduto = v.fk_idProduto

insert into produto(descricao,qtd) values('Lapis',10);

insert into venda(qtdVendida, fk_idProduto) values (2, 1);
insert into venda(qtdVendida, fk_idProduto) values (3, 1);
insert into venda(qtdVendida, fk_idProduto) values (5, 1);
insert into venda(qtdVendida, fk_idProduto) values (1, 1);
insert into venda(qtdVendida, fk_idProduto) values (10, 1);
insert into venda(qtdVendida, fk_idProduto) values (4, 1);

update produto set qtd = 25 where idProduto = 1;

drop trigger trgQtd
go

create trigger trgQtd
on venda 
after update, insert
as
begin
	declare @fk_idProduto integer
	declare @qtd integer
	declare @qtdVendida integer
	declare @calculo integer
	declare @nome varchar(100)
	declare @conversao varchar(10)

	select @fk_idProduto = fk_idProduto from inserted
	select @qtd = (select qtd from produto where idProduto = @fk_idProduto)
	select @qtdVendida = qtdVendida from inserted
	select @nome = (select descricao from produto where idProduto = @fk_idProduto)

	select @calculo = (select sum(v.qtdVendida)from venda as v inner join produto as p on p.idProduto = v.fk_idProduto)
	select @conversao = @calculo + ' '
	print('Total ' + @nome + ' vendido até o momento: ' + @conversao + '.');
	select @calculo = @qtd - @calculo
	select @conversao = @calculo + ' '
	print('Tem ' + @conversao + ', ainda, em estoque.');
	if(@calculo < 0)
		begin
		rollback
		raiserror('Operação de venda está sendo desfeita por falta de itens em estoque!', 16, 1)
		end
end
go




create database db_usuarios;
use db_usuarios;

create table pessoa(
	idProduto integer not null primary key identity,
	nome varchar(50),
	sexo varchar(10)
)

insert into pessoa(nome,sexo)values('eduardo', 'm');
insert into pessoa(nome,sexo)values('ana', 'f');

drop trigger trgSexo
go

create trigger trgSexo
on pessoa
after insert
as
begin
	declare @sexo varchar(10)
	declare @nome varchar(50)
	select @sexo = (select sexo from inserted);
	select @nome = nome from inserted
	if(@sexo='m')
		begin
		select @nome = 'Mr. ' + @nome
		update pessoa set nome = @nome where sexo = 'm'
		print('MR!')
		end
	else
		begin
		select @nome = 'Ms. ' + @nome
		update pessoa set nome = @nome where sexo = 'f'
		print('MS!')
		end
end
go

select * from pessoa;

insert into pessoa(nome, sexo)values('vitor', 'm');
insert into pessoa(nome,sexo)values('vitoria', 'f');

