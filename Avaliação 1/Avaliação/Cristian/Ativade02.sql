create database loja 

create table venda
(
	id_venda integer primary key identity,
	quantidade int

)

create table estoque
(
	id_estoque integer primary key identity,
	fk_venda integer,
	estoque_atual int ,
	foreign key (fk_venda) references venda(id_venda)
)

select * from venda
select * from estoque

insert into venda (quantidade)
values (20)

insert into estoque (estoque_atual)
values (100)


CREATE trigger calcula_estoque
ON venda
AFTER INSERT
AS
BEGIN
	DECLARE 
	@valor_venda integer,
	@id_mod integer,
	@print_estoque integer

	SELECT @valor_venda = quantidade, @id_mod = fk_id_estoque FROM INSERTED 

	UPDATE estoque 
	SET estoque_atual = (estoque_atual - @valor_venda) 
	WHERE id_estoque = @id_mod
	
	SELECT @print_estoque = estoque_atual FROM estoque WHERE id_estoque = @id_mod 

	PRINT 'Estoque do produto após operação: ' + CAST(@print_estoque AS NVARCHAR(100)) 

END
GO