use microsoft;

/*1. Crie uma vis�o que liste todos os funcion�rios que n�o s�o chefes. */
drop view viewChefe;
go

create view viewChefe as
select *
from employees
where reportsto is not null
go

select * from viewChefe;
go

/*2. Fa�a uma vis�o que liste a quantidade de vendas que cada produto (o
quanto cada produto foi vendido).*/
drop view viewVendas;
go

create view viewVendas as
select 
Products.ProductName as 'Descricao',
sum([Order Details].Quantity) as 'QTD Itens Vendidos' 
from Products, [Order Details]
where [Order Details].ProductID = Products.ProductID
group by Products.ProductName
go

select * from viewVendas;
go

/*3. Fa�a uma vis�o que liste os territ�rios e quantos vendedores est�o
vinculados a ele.*/
drop view viewTerritorios;
go

create view viewTerritorios as
select 
Territories.TerritoryDescription as 'Territorios',
count(Employees.EmployeeID) as 'Vendedores' 
from Territories, Employees, EmployeeTerritories
where Employees.EmployeeID = EmployeeTerritories.EmployeeID
and EmployeeTerritories.TerritoryID = Territories.TerritoryID
group by Territories.TerritoryDescription
go

select * from viewTerritorios;
go

/*4.Fa�a uma vis�o que retorne o nome do cliente da venda de maior valor.*/
drop view viewMaiorVenda;
go

create view viewMaiorVenda as
select top 10 [Order Details].UnitPrice * [Order Details].Quantity as 'Total',
Customers.CompanyName as 'Cliente'
from Customers, Orders, [Order Details]
where Customers.CustomerID = Orders.CustomerID
and Orders.OrderID = [Order Details].OrderID
order by Total desc

select * from viewMaiorVenda;
go

/*5. Fa�a uma vis�o que liste os vendedores ordenados pela lucratividade.*/

create view viewLucratividade as
select [Order Details].UnitPrice * [Order Details].Quantity as 'Total', Employees.LastName as 'Sobrenome'
from [Order Details], Orders, 



