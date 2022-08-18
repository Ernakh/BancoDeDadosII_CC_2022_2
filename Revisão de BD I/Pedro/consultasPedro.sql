--1
select * from Products

--2
select Products.ProductName, Suppliers.CompanyName, Categories.CategoryName
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID

--3
select Products.ProductName, Suppliers.CompanyName, Categories.CategoryName, Products.UnitPrice, Products.UnitsInStock
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID

--4
select Products.ProductName, Suppliers.CompanyName, Categories.CategoryName, Products.UnitPrice, Products.UnitsInStock
from Products
inner join Suppliers on Suppliers.SupplierID = Products.SupplierID
inner join Categories on Categories.CategoryID = Products.CategoryID
where Products.Discontinued = 0 and Products.UnitsInStock > 0

--5 vendedor e qtd vendas
select Employees.FirstName, count(Orders.OrderID) as Vendas
from Employees
inner join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName

--6 nome do vendedor e nome dos territórios que está vinculado
select Employees.FirstName, Territories.TerritoryDescription
from EmployeeTerritories
inner join Employees on EmployeeTerritories.EmployeeID = Employees.EmployeeID
inner join Territories on  EmployeeTerritories.TerritoryID= Territories.TerritoryID

--7 listar as vendas ordenadas do maior para o menor valor total

--8 listar as vendas onde o produto foi vendido mais barato que o preço de compra