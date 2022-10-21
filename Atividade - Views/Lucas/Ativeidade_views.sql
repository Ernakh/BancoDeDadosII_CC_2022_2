--Questão 1
CREATE VIEW vw_funcionarios AS
SELECT * 
FROM Employees
WHERE ReportsTo IS NOT NULL

SELECT *
FROM vw_funcionarios

--Questão 2
CREATE VIEW vw_produtos_vendidos AS
SELECT products.productName AS 'Nome do Produto', SUM([Order Details].QUANTITY) AS 'Quantidade'
FROM products, [Order Details]
WHERE [Order Details].ProductID = products.ProductID
GROUP BY products.productName

SELECT *
FROM vw_produtos_vendidos

--Questão 3
CREATE VIEW vw_vendedores_territorio AS
SELECT Territories.TerritoryDescription AS 'Território', 
EmployeeTerritories.EmployeeID AS 'Quantidade'
FROM Territories, EmployeeTerritories
WHERE Territories.TerritoryID = EmployeeTerritories.TerritoryID
GROUP BY Territories.TerritoryDescription, EmployeeTerritories.EmployeeID

SELECT *
FROM vw_vendedores_territorio

--Questão 4
CREATE VIEW vw_maior_venda AS
SELECT [Order Details].Quantity * [Order Details].UnitPrice AS "Valor Total",
Customers.CompanyName as "Cliente"
FROM [Order Details], Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
	AND Orders.OrderID = [Order Details].OrderID

SELECT *
FROM vw_maior_venda
ORDER BY [Valor Total] DESC