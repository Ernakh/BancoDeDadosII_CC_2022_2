--Exercício 1:

create view vw_funcionarios_nao_chefes as
select Employees.FirstName, Employees.LastName, Employees.ReportsTo
from Employees
where Employees.ReportsTo is not null;
go

select * from vw_funcionarios_nao_chefes order by FirstName;
go

--drop view vw_funcionarios_nao_chefes;
go

--Exercício 2:

create view vw_qtd_vendas as 
select Products.ProductName as 'Nome do Produto', [Order Details].Quantity as 'Quantidade'
from [Order Details], Products
where [Order Details].Quantity > 0
and Products.ProductID = [Order Details].ProductID  
go

select * from vw_qtd_vendas order by [Nome do Produto];
go

drop view vw_qtd_vendas
go

--Exercício 3:

create view vw_territorios_e_vendedores as 
select Territories.TerritoryDescription as 'Território', count (EmployeeTerritories.EmployeeID) as 'Quantidade'
from Territories, EmployeeTerritories
where Territories.TerritoryID = EmployeeTerritories.TerritoryID
group by Territories.TerritoryDescription
go

select * from vw_territorios_e_vendedores;
go

drop view vw_territorios_e_vendedores;
go