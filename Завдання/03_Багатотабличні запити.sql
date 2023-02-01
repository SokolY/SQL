--1. Для всіх товарів вивести в одному записі назву товару, його категорію та залишок на складі. Рядок має бути іформативним і читаним.
Select 'ProductName: ' + ProductName + '   /Category: ' + C.CategoryName + '   /In stock: ' + CAST(P.UnitsInStock as nvarchar(50))
from Products P
	join CAtegories C on P.CategoryID = C.CategoryID

--2. Вивести товари компаній без сайту.
select P.ProductName
from Products P
	join Suppliers S on S.SupplierID=P.SupplierID
Where S.HomePage is null

--3. Вивести імена територій південного регіону за абеткою.
select T.TerritoryDescription
from Territories T
	Join Region R on R.RegionID = T.RegionID
where R.RegionDescription like '%outh%'
order by T.TerritoryDescription

--4. Вивести імена співробітників, які найняті після 92-го року.
select E.FirstName + ' ' + E.LastName as [Employee name]
	,E.HireDate
from Employees E
Where YEAR(E.HireDate) > 1992

--5. Усі імена товарів, категорій, загальну суму угод за 97 рік.
Select P.ProductName, C.CategoryName
	, SUM (OD.Quantity*OD.UnitPrice) as TOTAL
from Orders O
	join [Order Details] OD on OD.OrderID = O.OrderID 
	join Products P on P.ProductID = OD.ProductID
	join Categories C on C.CategoryID = P.CategoryID
WHERE YEAR (O.OrderDate) = 1997
group by P.ProductName, C.CategoryName

--6. Вивести імена товарів та їх категорії для товарів, які замовили в кількостях, кратних 4
SELECT  P.ProductName, C.CategoryName, sum(OD.Quantity)
from  Products P
	join Categories C ON c.CategoryID = P.CategoryID
	Join [Order Details] OD on Od.ProductID=P.CategoryID
group by P.ProductName, C.CategoryName
Having (sum(OD.Quantity) % 4) = 0

--7. Вивести імена співробітників, які відповідали за замовлення для південних регіонів у 97-му році.
Select DISTINCT E.FirstName + ' ' + E.LastName
from Employees E
	join EmployeeTerritories ET on E.EmployeeID = ET.EmployeeID
	JOIN Territories T on ET.TerritoryID = T.TerritoryID
	join Region R on R.RegionID = R.RegionID
	join Orders O on E.EmployeeID = O.EmployeeID
Where R.RegionDescription LIKE '%outh%'
	and YEAR(O.OrderDate) = 1997

--8. Вивести імена співробітників, які обробляли замовлення по товарах, що виробляються компаніями, для яких не вказано (кодгорода) телефону
Select DISTINCT E.FirstName + ' ' + E.LastName
from Employees E
	join Orders O on E.EmployeeID = O.EmployeeID
	join [Order Details] OD on OD.OrderID = O.OrderID
	Join Products P on OD.ProductID = P.ProductID
	join Suppliers S on S.SupplierID = P.SupplierID
Where S.Phone is null

--9. Вивести співробітників, які працюють із замовниками без факсу.
Select DISTINCT E.FirstName + ' ' + E.LastName
from Employees E
	join Orders O on E.EmployeeID = O.EmployeeID
	join Customers C on C.CustomerID = O.CustomerID
Where C.Fax is null

--10. Вивести категорії товарів, що продавалися співробітниками південниx регіонів.
Select distinct C.CategoryName
FRom Categories C
	join Products P on C.CategoryID = P. CategoryID
	Join [Order Details] OD on OD. ProductID = P.ProductID
	join Orders O on O.OrderID = OD.OrderID
	join Employees E on E.EmployeeID = O.EmployeeID
	join EmployeeTerritories ET  on ET.EmployeeID = E.EmployeeID
	join Territories T on T.TerritoryID=ET.TerritoryID
	join Region R on R.RegionID=T.RegionID
Where R.RegionDescription LIKE '%outh%'






