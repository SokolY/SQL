/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProductID]
      ,[ProductName]
      ,[SupplierID]
      ,[CategoryID]
      ,[QuantityPerUnit]
      ,[UnitPrice]
      ,[UnitsInStock]
      ,[UnitsOnOrder]
      ,[ReorderLevel]
      ,[Discontinued]
  FROM [Northwind].[dbo].[Products]
  order by CategoryID

-- 1. Вивести кількість товарів за категорією Dairy Products
 SELECT count(ProductName) as CountOFProducts
 FROM Products as Prod, Categories as Ct
 WHERE Prod.CategoryID = Ct.CategoryID AND Ct.CategoryName = 'Dairy Products'

 --2. Вивести кількість територій за якими працює Andrew Fuller
 Select count (TerritoryID) as TerritoryCount
 FROM EmployeeTerritories as ET, Employees as Em
 WHERE ET.EmployeeID = Em.EmployeeID AND Em.FirstName = 'Andrew' AND Em.LastName = 'Fuller'

 --3. Вивести ім'я регіону та кількість територій по кожному (регіону).
 Select Re.RegionDescription, count(Ter.RegionID) as TeretoriesCount
 From Region as Re, Territories as Ter
 WHERE Re.RegionID = Ter.RegionID
 GROUP BY Re.RegionDescription

 --4. Вивести середній вік працівників.
    SELECT AVG(DATEDIFF(year, em.BirthDate, GetDate())) as 'Average Age'
	FROM Employees as Em
	
-- 5. Вивести кількість одиниць товару перевезених перевізником United Package.

SELECT SUM (OrdDet.Quantity) as ItemQuantity
FROM Orders as Ord, Shippers as Ship, [Order Details] as OrdDet
WHERE Ord.ShipVia = Ship.ShipperID AND Ord.OrderID = OrdDet.OrderID AND CompanyName = 'United Package'

-- 6. Вивести мінімальну та максимальну кількість найменувань товарів для всіх категорій.

SELECT MAX(Prod.UnitsInStock) as MaxQuantityInCategory, Min(Prod.UnitsInStock) as MinQuantityInCategory
FROM Products AS Prod
Group By Prod.CategoryID

-- 7. Вивести середню кількість територій на співробітника.
Select (COUNT(TerritoryID) / COUNT  ( DISTINCT EmployeeID))
FROM EmployeeTerritories

-- 8. Вивести повні імена співробітників та кількість регіонів, по яких вони працюють.

SELECT (E.FirstName+ ' ' + E.LastName) as FullName, TerCount.Tesr
FROM Employees as E, 
(Select EmployeeID, COUNT (TerritoryID) as Tesr
From EmployeeTerritories
GROUP BY EmployeeID) as TerCount
WHERE E.EmployeeID = TerCount.EmployeeID

--9. Вивести вартість залишків на складі для категорії Condiments.
SELECT (P.UnitsInStock * P.UnitPrice) as TotalCost
FROM Products as P, Categories as Cat
WHERE P.CategoryID = Cat.CategoryID AND Cat.CategoryName = 'Condiments'

--10. Для кожного клієнта вивести ім'я компанії, прізвище контакту, номер телефону та сукупну вартість товарів, які були їм придбані.

SELECT Cus.CompanyName, Cus.ContactName, Cus.Phone, OrderCost.SuperTotalCost
FROM Customers as Cus,
(Select O.CustomerID, Sum(TotalCost.Cost) as SuperTotalCost
FROM Orders as O,
(SELECT OrderID, (Sum(UnitPrice * Quantity)) as Cost
FROM [Order Details]
GROUP BY OrderID) as TotalCost
WHERE O.OrderID = TotalCost.OrderID
GROUP BY O.CustomerID) as OrderCost
WHERE Cus.CustomerID = OrderCost.CustomerID

