

--1. Вивести вміст таблиці замовлень.
SELECT * from Orders

--2. Вивести імена та міста замовників.
SELECT CompanyName, City 
FROM Customers

--3. Вивести всіх покупців без повторень, які щось замовляли.
Select DISTINCT CompanyName
From Customers C
	JOIN Orders O on O.CustomerID=C.CustomerID

--4. Вивести назви товарів під ім'ям “Ім'я товару” та його ціну під ім'ям “ціна товару”.
Select ProductName as 'Product name', UnitPrice as 'Price'
FROM Products

--5. Вивести назви товарів, що мають категорію "Seafood", що мають ціну понад 20.
Select ProductName as 'Product name'
FROM Products P
	join Categories C on C.CategoryID=p.CategoryID
where C.CategoryName like 'Seafood'

--6. Вивести назви товарів, що мають категорію "Seafood", що мають залишок на складі від 20 до 50.
Select ProductName as 'Product name'
FROM Products P
	join Categories C on C.CategoryID=p.CategoryID
where C.CategoryName like 'Seafood'
	and P.UnitsInStock between 20 and 50

--7. Вивести назви товарів, що мають категорію "Confections" та які купують компанії Лондона.
Select ProductName as 'Product name'
FROM Products P
	join Categories C on C.CategoryID=P.CategoryID
	join [Order Details] OD on OD.ProductID=P.ProductID
	join Orders O on O.OrderID=OD.OrderID
	join Customers CU on CU.CustomerID=O.CustomerID
where C.CategoryName like 'Confections'
	and CU.City like 'London'


--8. Вивести назви категорій, імена постачальників, які продають товари категорій Beverages Condiments за ціною, меншою за 10 або більше за 100
SELECT distinct C.CategoryName, S.CompanyName
FROM Products P
	join Suppliers S on P.SupplierID=S.SupplierID
	join Categories C on C.CategoryID=P.CategoryID
WHERE C.CategoryName in ('Beverages', 'Condiments')
	and P.UnitPrice not between 10 and 100

--9. Вивести імена товарів, чия залишкова вартість на складі більше 1000
Select P.ProductName
from Products P
WHERE (P.UnitsInStock*P.UnitPrice)>1000

--10. Вивести імена товарів, чия десятикратна вартість менша за половину вартості залишків на складі
Select P.ProductName
from Products P
WHERE (10*P.UnitPrice)<(P.UnitsInStock*P.UnitPrice*0.5)

--11. Вивести імена постачальників без повторень, які користувалися послугами першозвісників Speedy Express та Federal Shipping
Select distinct S.CompanyName
from Suppliers S
	join Products P on P.SupplierID=S.SupplierID
	join [Order Details] OD on OD.ProductID=P.ProductID
	join Orders O on O.OrderID=OD.OrderID
	join Shippers SH on SH.ShipperID=O.ShipVia
where SH.CompanyName like 'Speedy Express'

--12. Вивести імена всіх товарів, крім категорій Meat/Poultry та Dairy Products
select P.ProductName
from Products P
	join Categories C on C.CategoryID=P.CategoryID
--where C.CategoryName not in ('Meat/Poultry' , 'Dairy Products')
where C.CategoryName <> all (SELECT 'Meat/Poultry' UNION SELECT 'Dairy Products')

--13. Вивести імена всіх товарів, які містять Lager
select P.ProductName
from Products P
where P.ProductName like '%Lager%'
