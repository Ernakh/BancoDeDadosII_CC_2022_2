create database estoque

create table produtos
(
	id integer primary key identity,
	nome varchar(30),
	estoqueIdeal integer,
	estoqueAtual integer
)

create table vendas
(
	id integer primary key identity,
	quantidade integer,
	fk_produto integer,
	foreign key (fk_produto) references produtos(id)
)

insert into produtos values ('caneta', 100, 80), ('lápis', 500, 380),
	('grampeador', 20, 18)

select * from produtos

create trigger atualizaestoque
on vendas
after insert
as
	declare @quantidade integer
	declare @estoqueatual integer
	declare @produto varchar(30)
	declare @estoqueimpresso varchar(5)

	select @quantidade = (select inserted.quantidade from inserted)
	select @produto = (select inserted.fk_produto from inserted)
	select @estoqueatual = (select produtos.estoqueAtual from produtos where produtos.id = @produto)
	select @estoqueimpresso = (select @estoqueatual - @quantidade)

	begin
		update produtos set estoqueAtual = estoqueAtual - @quantidade
			where produtos.id = @produto;
		print('A quantidade atual do estoque é de ' + @estoqueimpresso);
	end

insert into vendas values (20, 2)
insert into vendas values (3, 3)
insert into vendas values (5,1)

select * from vendas