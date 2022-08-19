select * from products

-- pesquica nome do produto, nome do fornecedor , nome da categoria
select products.productname, suppliers.companyname, categories.categoryname
FROM Products
INNER JOIN suppliers on suppliers.supplierid = products.supplierid
INNER JOIN categories on categories.categoryid = products.categoryid

-- preço e estoque/ unitprice e quantityperunit
select products.productname, products.QuantityPerUnit, products.UnitPrice, suppliers.companyname, categories.categoryname
FROM Products
INNER JOIN suppliers on suppliers.supplierid = products.supplierid
INNER JOIN categories on categories.categoryid = products.categoryid

-- ocultar os itens descotinuados e os sem estoque / discontinued - unitsinstock
select products.productname, products.QuantityPerUnit, products.UnitPrice, suppliers.companyname, categories.categoryname
FROM  Products
INNER JOIN suppliers on suppliers.supplierid = products.supplierid
INNER JOIN categories on categories.categoryid = products.categoryid
--where = onde, utilizamos para exeções
WHERE products.UnitsInStock = 0 or products.discontinued = 1

-- nome do vendedor e quantidade de vendas do vendedor
select Employees.FirstName, COUNT(orders.OrderID) as vendas
FROM Employees
INNER JOIN Orders on orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName

-- nome do vendedor e territorio que ele atua
select Employees.FirstName, COUNT(EmployeeTerritories.TerritoryID) as territorios
FROM Employees
INNER JOIN EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
GROUP BY Employees.FirstName

-- LISTAR AS VENDAS ORDENANDO PELO VALOR MAIOR PARA MENOR
SELECT ORDERS.ORDERID,
      ([ORDER DETAILS].QUANTITY * [ORDER DETAILS].UNITPRICE) AS TOTAL
FROM ORDERS
JOIN [ORDER DETAILS] ON [ORDER DETAILS].ORDERID = ORDERS.ORDERID
ORDER BY ([ORDER DETAILS].QUANTITY * [ORDER DETAILS].UNITPRICE) DESC

-- LISTAR AS VENDAS ONDE O PRODUTO FOI VENDIDO MAIS BARATO QUE PELO PREÇO DE CUSTO
SELECT DISTINCT [ORDER DETAILS].ORDERID, PRODUCTS.UNITPRICE, [ORDER DETAILS].UNITPRICE
FROM [ORDER DETAILS]
JOIN PRODUCTS ON [ORDER DETAILS].PRODUCTID = PRODUCTS.PRODUCTID
AND [ORDER DETAILS].UNITPRICE < PRODUCTS.UNITPRICE