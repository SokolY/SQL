--1. Вывести все возможные пары строк регионов и територий.
use Northwind
select *
from 
	Region as Reg, 
	Territories as Ter
where 
	Reg.RegionID = Ter.RegionID
order by 
	Reg.RegionID asc

--2. Вывести названия продуктов, остаток которых на складе меньше чем количество на заказ (UnitsOnOrder)
select
	ProductName,
	UnitsInStock,		--Удалить UnitsInStock. Добавлено в запрос для отображения корректности работы
	UnitsOnOrder		--Удалить UnitsOnOrder. Добавлено в запрос для отображения корректности работы
from
	Products
where 
	UnitsInStock < UnitsOnOrder

--3. Вывести названия продуктов, их стоимость в таблице продуктов, их стоимость в ордерах. 
--Для тех продуктов, цена которых отличается в этих таблицах.
select distinct
	Prod.ProductName,
	Prod.UnitPrice as ProductsUnitPrice,
	Orders.UnitPrice as OrdersUnitPrice
from
	Products as Prod,
	[Order Details] as Orders
where
		Prod.ProductID = Orders.ProductID and 
		Prod.UnitPrice != Orders.UnitPrice
order by
	Prod.ProductName asc

--4. Вывести названия продуктов и названия их категорий для категории Confections и Produce
select
	Categ.CategoryName,
	Prod.ProductName
from
	Products as Prod,
	Categories as Categ
where
		Prod.CategoryID = Categ.CategoryID and 
		CategoryName in ('Confections', 'Produce')
order by
	Categ.CategoryName asc,
	Prod.ProductName asc

--5. Вывести фамилии сотрудников и названия территорий, по которым они работают. Сортировать по фамилиям, затем по территориям.
select Emp.LastName, EmpIDTer.TerritoryDescription
from
	Employees as Emp,
	(select Empter.EmployeeID, Ter.TerritoryDescription
	from
		EmployeeTerritories as EmpTer,
		Territories as Ter
	where
		EmpTer.TerritoryID = Ter.TerritoryID) as EmpIDTer
where 
	Emp.EmployeeID = EmpIDTer.EmployeeID
order by 
	Emp.LastName asc,
	EmpIDTer.TerritoryDescription asc

--6. Вывести названия перевозчиков, которые выполняли доставку для покупателя Martin Sommer. Без повторений.
select
	Ship.CompanyName
from 
	Shippers as Ship,
	(select distinct
		Ord.ShipVia
	from 
		Orders as Ord,
		Customers as Cust
	where
		Cust.ContactName = 'Martin Sommer' and
		Ord.CustomerID = Cust.CustomerID) as ShipID
where
	Ship.ShipperID=ShipID.ShipVia

--7. Вывести полные имена сотрудников, которые работают по New York
select 
	Emp.FirstName + ' ' + Emp.LastName as [Full Name]
from 
	Employees as Emp,
	(select distinct
		EmpTer.EmployeeID
		--Ter.TerritoryDescription
	from
		EmployeeTerritories as EmpTer,
		Territories as Ter
	where
		Ter.TerritoryDescription = 'New York' and
		EmpTer.TerritoryID = Ter.TerritoryID) as EmpIDNeyYork
where
	Emp.EmployeeID = EmpIDNeyYork.EmployeeID

--8. Вывести названия фирм-поставщиков для категории Seafood
select 
	Sup.CompanyName
from 
	Suppliers as Sup,
	(Select distinct
		Prod.SupplierID
	from
		Products as Prod,
		Categories as Cat
	where
		Cat.CategoryName = 'Seafood' and
		Cat.CategoryID = Prod.CategoryID) as SupIDByProd
where
	Sup.SupplierID = SupIDByProd.SupplierID
order by
	Sup.CompanyName

--9. Вывести названия и описания категорий товаров для поставщика Bigfoot Breweries
select
	Cat.CategoryName,
	Cat.[Description]
from
	Categories as Cat,
	(select distinct
		Prod.CategoryID
	from
		Products as Prod,
		Suppliers as Sup
	where
		Sup.CompanyName = 'Bigfoot Breweries' and
		Prod.SupplierID = Sup.SupplierID) as CatIDBySuppl
where
	Cat.CategoryID = CatIDBySuppl.CategoryID

--10. Вывести для каждого заказа дату заказа, имя продукта, имя категории и город куда он был отправлен.
select
	OrdCustProdIDCatID.OrderDate,
	OrdCustProdIDCatID.ProductName,
	Cat.CategoryName,
	OrdCustProdIDCatID.City
from
	Categories as Cat,
	(select
		Prod.CategoryID,
		OrdCustProdID.OrderDate,
		Prod.ProductName,
		OrdCustProdID.City
	from
		Products as Prod,
		(select
			OrdDet.ProductID,
			OrdCust.OrderDate,
			OrdCust.City
		from
			[Order Details] as OrdDet,
			(select
				Ord.OrderID,
				Ord.OrderDate,
				Cust.City
			from
				Orders as Ord,
				Customers as Cust
			where
				Ord.CustomerID = Cust.CustomerID) as OrdCust
		where 
			OrdDet.OrderID = OrdCust.OrderID) as OrdCustProdID
	where
		Prod.ProductID = OrdCustProdID.ProductID) as OrdCustProdIDCatID
where
	Cat.CategoryID = OrdCustProdIDCatID.CategoryID
order by
	OrdCustProdIDCatID.OrderDate

--11. *Изменить фамилию представителя покупателя с Ashworth на Simenkovich
--!!! финальный запрос на Этап 4.
--Этап 1. Копируем таблицу Customers на всякий случай и чтобы потом проверить, как изменилось значение.
select *
into CustomersCopy
from Customers

--Этап 2. Находим представителя с полным именем Victoria Ashworth
select
	Cust.ContactName
from
	Customers as Cust
where
	ContactName like ('%Ashworth%')

--Этап 3. Заменив фамилию, получаем измененное значение полного имени, измененное с Victoria Ashworth на Victoria Simenkovich
select
	left(
	(select
		Cust.ContactName
	from
		Customers as Cust
	where
		ContactName like ('%Ashworth%')),
	charindex(
		'Ashworth', 
		(select
			Cust.ContactName
		from
			Customers as Cust
		where
			ContactName like ('%Ashworth%'))) - 1)
	+ 'Simenkovich'

--проще воспользоваться функцией replace
select
	replace(
		(select
			Cust.ContactName
		from
			Customers as Cust
		where
			ContactName like ('%Ashworth%')),
		'Ashworth',
		'Simenkovich')

--Этап 4. Обновляем таблицу Customers, заменив значения поля ContactName с Victoria Ashworth на Victoria Simenkovich
update Customers
set Customers.ContactName = (select
								replace(
									(select
										Cust.ContactName
									from
										Customers as Cust
									where
										ContactName like ('%Ashworth%')),
									'Ashworth',
									'Simenkovich'))
where Customers.ContactName like ('%Ashworth%')

--после обновления проверяем корректность изменения полного имени с Victoria Ashworth на Victoria Simenkovich
select
	Cust.ContactName
from
	Customers as Cust
where
	ContactName like ('%Simenkovich%')
--В таблице [Customers] в поле [ContactName] в полном имени фамилия была изменена с Victoria Ashworth на Victoria Simenkovich