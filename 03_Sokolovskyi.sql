

--1. Вивести всі можливі пари рядків регіонів та територій.
SELECT *
FROM Territories, Region

--2. Вивести назви продуктів, залишок яких на складі менший за кількість на замовлення (UnitsOnOrder).
SELECT Products.ProductName
FROM Products
WHERE UnitsInStock<UnitsOnOrder

--3. Вивести назви продуктів, їх вартість у таблиці продуктів, їх вартість в ордерах. Для продуктів, ціна яких відрізняється у цих таблицях.
--Select ProductName, UnitPrice

SELECT ProductName, Prod.UnitPrice, Ord.UnitPrice
FROM Products AS Prod, [Order Details] AS Ord
WHERE Prod.ProductID = Ord.ProductID AND 
Prod.UnitPrice <> Ord.UnitPrice

--4. Вивести назви продуктів та назви їх категорій для категорії Confections та Produce.
Select ProductName, CategoryName
FROM Products as Prod, Categories as Cat
WHERE (Cat.CategoryName = 'Confections' OR Cat.CategoryName = 'Produce') And
Prod.CategoryID = Cat.CategoryID

--5. Вивести прізвища співробітників та назви територій, по яких вони працюють. Сортувати за прізвищами, потім територіями.
Select Em.LastName, Ter.TerritoryDescription
From Employees AS Em, Territories AS Ter, EmployeeTerritories as EmpTer
WHERE Em.EmployeeID = EmpTer.EmployeeID AND Ter.TerritoryID = EmpTer.TerritoryID
ORDER BY LastName, TerritoryDescription

--6. Вивести назви перевізників, що виконували доставку для покупця Martin Sommer. Без повторень.
SELECT Ship.CompanyName
FROM Shippers as Ship, Customers as Cust, Orders AS Ord
WHERE Cust.ContactName = 'Martin Sommer' AND 
Cust.CustomerID = Ord.CustomerID
AND Ord.ShipVia = Ship.ShipperID
GROUP BY Ship.CompanyName

--7. Вивести повні імена співробітників, які працюють по New York.
SELECT FirstName + ' ' + LastName AS [User Name]
FROM Employees AS Emp, EmployeeTerritories AS EmpTer, Territories AS Ter
WHERE Emp.EmployeeID = EmpTer.EmployeeID AND 
EmpTer.TerritoryID = Ter.TerritoryID AND
Ter.TerritoryDescription = 'New York'


-- 8. Вивести назви фірм-постачальників для категорії Seafood.
SELECT Sup.CompanyName
FROM Suppliers AS Sup, Products, Categories AS Cat
WHERE Cat.CategoryName = 'Seafood' AND
Cat.CategoryID = Products.CategoryID AND
Products.SupplierID = Sup.SupplierID


--9. Вивести назви та описи категорій товарів для постачальника Bigfoot Breweries.

SELECT Prod.ProductName, Cat.Description
FROM Categories AS Cat, Products AS Prod, Suppliers AS Sup
WHERE Sup.CompanyName = 'Bigfoot Breweries' AND
Sup.SupplierID = Prod.SupplierID AND
Prod.CategoryID = Cat.CategoryID


--10. Вивести для кожного замовлення дату замовлення, ім'я продукту, ім'я категорії та місто, куди він був відправлений.
SELECT Orders.OrderDate, Products.ProductName, Cat.CategoryName, Orders.ShipCity
FROM Orders, [Order Details] AS OrdDet, Products, Categories AS Cat
WHERE Orders.OrderID = OrdDet.OrderID AND 
OrdDet.ProductID = Products.ProductID AND
Products.CategoryID = Cat.CategoryID 

--11 Змінити прізвище представника покупця з Ashworth на Simenkovich
UPDATE Customers
SET ContactName = 'Victoria Simenkovich'
Where ContactName like '%Ashworth%'

