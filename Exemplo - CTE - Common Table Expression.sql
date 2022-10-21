with tabela
as
(
	select * from Categories
)
select * from products 
join tabela on tabela.CategoryID = Products.CategoryID
