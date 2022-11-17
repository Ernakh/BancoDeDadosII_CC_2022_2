--Ex1:

create view vw_funcionarios_empregados as select Employees.FirstName, Employees.LastName, Employees.ReportsTo
from Employees
where Employees.ReportsTo is not null;
go

select * 
from vw_funcionarios_empregados 
order by FirstName;
go

drop view vw_funcionarios_empregados;
go

--Ex2:

create view vw_qtd_vendas as  select Products.ProductName as 'Nome do Produto', 
[Order Details].Quantity as 'Quantidade'
from [Order Details], Products
where [Order Details].Quantity > 0
	and Products.ProductID = [Order Details].ProductID;
go

select *
from vw_qtd_vendas 
order by [Nome do Produto];
go

drop view vw_qtd_vendas;
go

--Ex3:

create view vw_vendedores_territorios as select Territories.TerritoryDescription as 'Território', 
count (EmployeeTerritories.EmployeeID) as 'Quantidade'
from Territories, EmployeeTerritories
where Territories.TerritoryID = EmployeeTerritories.TerritoryID
group by Territories.TerritoryDescription;
go

select * 
from vw_vendedores_territorios;
go

drop view vw_vendedores_territorios;
go

--Ex4:

create view vw_maior_venda as select top 1 [Order Details].Quantity * [Order Details].UnitPrice as 'Valor', 
Customers.CompanyName as 'Cliente'
from [Order Details], Customers, Orders
where Customers.CustomerID = Orders.CustomerID
	and Orders.OrderID = [Order Details].OrderID
order by Valor desc;
go

select * 
from vw_cliente_de_maior_valor;
go

drop view vw_cliente_de_maior_valor;
go

--Ex5:

create view vw_ordena_vendedores as
select sum([Order Details].Quantity * [Order Details].UnitPrice) as 'Valor', 
Employees.FirstName as 'Nome'
from [Order Details], Orders, Employees
where Orders.OrderID = [Order Details].OrderID
	and orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName;
go

select * 
from vw_ordena_vendedores;
go

drop view vw_ordena_vendedores;
go

--Ex6:

create view vw_produtos_caracteristicas as select Products.ProductName as 'Produto', 
Suppliers.CompanyName as 'Fornecedor', 
Categories.CategoryName as 'Categoria', 
Products.UnitPrice as 'Preço',
Products.Discontinued as 'Descontinuado'
from Products, Categories, Suppliers
where Products.UnitsInStock > 0
group by Products.ProductName, Suppliers.CompanyName, Categories.CategoryName, Products.UnitPrice, Products.Discontinued
go

--group by agrupa as linhas que têm o mesmo valor

select * 
from vw_produtos_caracteristicas;
go

drop vw_produtos_caracteristicas;
go
