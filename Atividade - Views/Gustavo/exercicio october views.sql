select * from Employees

--exercicio 1 completado
create view funcionariosemchefes as
select f.*from Employees f
where f.ReportsTo is NULL;

select * from funcionariosemchefes


--exercicio 2 iniciado
create view Vendaporproduto as
select left(Products.ProductName,40) as Nomeproduto,
sum(Products.UnitsOnOrder)
from Products
group by left(Products.UnitsOnOrder,40);


select * from Products order by UnitsOnOrder

--exercicio 3





--exercicio 4




--exercicio 5 iniciado
create view topsellers as

select top 10 * from Employees as empregado,Orders as ordem,[Order Details] as detalhes,Products as produto
inner join Employees on Employees.EmployeeID=Orders.EmployeeID
inner join Orders on Orders.EmployeeID=Employees.EmployeeID
inner join [Order Details] on [Order Details].OrderID=Orders.OrderID
inner join Products on Products.ProductID=[Order Details].ProductID
order by Products.UnitsOnOrder;