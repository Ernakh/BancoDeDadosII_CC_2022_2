--Exerc�cio 1:

create view vw_funcionarios_nao_chefes as
select Employees.FirstName, Employees.LastName, Employees.ReportsTo
from Employees
where Employees.ReportsTo is not null;
go

select * from vw_funcionarios_nao_chefes order by FirstName;
go

drop view vw_funcionarios_nao_chefes;
go

--Exerc�cio 2:

create view vw_qtd_vendas as 
select Products.ProductName as 'Nome do Produto', [Order Details].Quantity as 'Quantidade'
from [Order Details], Products
where [Order Details].Quantity > 0
	and Products.ProductID = [Order Details].ProductID;
go

select * from vw_qtd_vendas order by [Nome do Produto];
go

drop view vw_qtd_vendas;
go

--Exerc�cio 3:

create view vw_territorios_e_vendedores as 
select Territories.TerritoryDescription as 'Territ�rio', count (EmployeeTerritories.EmployeeID) as 'Quantidade'
from Territories, EmployeeTerritories
where Territories.TerritoryID = EmployeeTerritories.TerritoryID
group by Territories.TerritoryDescription;
go

select * from vw_territorios_e_vendedores;
go

drop view vw_territorios_e_vendedores;
go

--Exerc�cio 4:

create view vw_cliente_de_maior_valor as
select top 1 [Order Details].Quantity * [Order Details].UnitPrice as 'Valor', Customers.CompanyName as 'Cliente'
from [Order Details], Customers, Orders
where Customers.CustomerID = Orders.CustomerID
	and Orders.OrderID = [Order Details].OrderID
order by Valor desc;
go

--top 1 indica que o select retornar� apenas uma tupla, a que est� no topo
--top 2 retornaria as 2 primeiras tuplas

--order by � utilizado para ordenar 
--Valor � o nome da coluna que criamos na hora de mostrar
--desc indica que ser� ordenado de forma decrescente

select * from vw_cliente_de_maior_valor;
go

drop view vw_cliente_de_maior_valor;
go

--Exercicio 5:

create view vw_ordena_vendedores as
select sum([Order Details].Quantity * [Order Details].UnitPrice) as 'Valor', Employees.FirstName as 'Nome'
from [Order Details], Orders, Employees
where Orders.OrderID = [Order Details].OrderID
	and orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName;
go

--sum() retorna a soma de todos os valores, incluindo duplicados

select * from vw_ordena_vendedores;
go

drop view vw_ordena_vendedores;
go

--Exerc�cio 6:

create view vw_caracteristicas_produtos as
select Products.ProductName as 'Produto', Suppliers.CompanyName as 'Fornecedor', Categories.CategoryName as 'Categoria', Products.UnitPrice as 'Pre�o',
Products.Discontinued as  'Descontinuado'
from Products, Categories, Suppliers
where Products.UnitsInStock > 0
group by Products.ProductName, Suppliers.CompanyName, Categories.CategoryName, Products.UnitPrice, Products.Discontinued
go

--group by agrupa as linhas que t�m o mesmo valor

select * from vw_caracteristicas_produtos;
go

drop vw_caracteristicas_produtos;
go

-- o repert�rio https://github.com/Ernakh/BancoDeDadosII_CC_2022_2/blob/main/Atividade%20-%20Views/Leonardo/MicrosoftViews.sql do colega foi utilizado para tiramento de d�vidas
