-- Завдання 4 - функції агрегування

--1. Вивести кількість товарів, ціна яких більша за 50
Select COUNT(*) 
From Products P
WHere P.UnitPrice>50

--2. Вивести імена категорій та кількість товарів за кожною.
select C.CategoryName
	,(Select count (*) from Products P where p.CategoryID=C.CategoryID)
from Categories C
 
--3. Вивести імена перевізників та кількість замовлень, оброблених ними.
Select S.CompanyName
	,(Select count(*) from Orders O where S.ShipperID = O.ShipVia)
from Shippers S

--4. Вивести імена постачальників та дохід за товарами для кожного з них.
select S.CompanyName, SUM(OD.UnitPrice*OD.Quantity)
from Suppliers S
	join Products P on P.SupplierID = S.SupplierID
	join [Order Details] OD on OD.ProductID = P.ProductID
Group by S.CompanyName, S.SupplierID

--5. Вивести імена співробітників, які обробили понад 50 замовлень.
select E.FirstName + ' ' + E.LastName as [NAME]
	, count (*) as [Order count]
from Employees E
	join Orders O on O.EmployeeID = E.EmployeeID
	Group by E.EmployeeID, E.FirstName, E.LastName
having count (*) > 50

--6. Вивести середній прибуток по всім замовленням
select avg(SubQ.orderSum)
from (
	Select sum(od.Quantity*od.UnitPrice) as 'orderSum'
	from [Order Details]  OD
	group by OD.OrderID) as SubQ

--7. Вивести назву найдешевшого товару(ів).
select P.ProductName
from Products P
where P.UnitPrice = (
	select MIN (pr.UnitPrice) 
	from Products pr)

--8. Вивести імена категорій, сумарна вартість закупу товарів за якими більше 200, 
--враховувати тільки товари, які в закупі коштують дорожче 20

Select CategoryName
from Categories C
where C.CategoryID = any
	(select P.CategoryID
	from Products P
	where p.UnitPrice > 20
	group by p.CategoryID
	Having SUM (P.UnitPrice)>200)



