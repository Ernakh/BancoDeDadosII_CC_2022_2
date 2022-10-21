create view view1 as
select * from Employees
where ReportsTo is not null

select * from view1


alter view view2 as
select products.productName as 'Produto', sum([Order Details].Quantity) as 'Quantidade'
from products, [Order Details]
where [Order Details].ProductID = products.ProductID
group by products.productName

select * from view2


alter view view3 as
select Territories.TerritoryDescription as 'Território', EmployeeTerritories.EmployeeID as 'Quantidade'
from Territories, EmployeeTerritories
where Territories.TerritoryID = EmployeeTerritories.TerritoryID
group by Territories.TerritoryDescription, EmployeeTerritories.EmployeeID

select * from view3


alter view view4 as
select  top 1 [Order Details].Quantity * [Order Details].UnitPrice as 'Valor', Customers.CompanyName as 'Cliente'
from [Order Details], Customers, Orders
where Customers.CustomerID = Orders.CustomerID
	and Orders.OrderID = [Order Details].OrderID
order by Valor desc

select * from view4


create view view5 as
select sum([Order Details].Quantity * [Order Details].UnitPrice) as 'Valor', Employees.FirstName as 'Nome'
from [Order Details], Orders, Employees
where Orders.OrderID = [Order Details].OrderID
	and orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName

select * from view5


alter view view6 as
select Products.ProductName as 'Nome', Suppliers.CompanyName as 'Fornecedor',
		Categories.CategoryName as 'Categoria', Products.UnitPrice as 'Preço', Products.Discontinued as 'Discontinuado'
from Products, Suppliers, Categories
where Products.UnitsInStock > 0
group by Products.ProductName, Suppliers.CompanyName, Categories.CategoryName, Products.UnitPrice, Products.Discontinued

select * from view6