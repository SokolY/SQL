--1. функція  повертає кількість унікальних покупців.

create Function UniqBuyers ()
returns int
as
begin
	return(
		select Count (Distinct O.CustomerID)	
		From Orders O
		)
end
go

Declare @t1 int
exec @t1 = UniqBuyers;
Print @t1
go

--2. функція  повертає середню ціну товару конкретної категорії.
--Категорія товару передається як параметр.

--SELECT P.CATEGORYID, C.CATEGORYNAME, AVG(P.UNITPRICE)
--		FROM PRODUCTS P
--		JOIN CATEGORIES C ON C.CATEGORYID = P.CATEGORYID
--		GROUP BY P.CATEGORYID, C.CATEGORYNAME
--		HAVING C.CATEGORYNAME LIKE '%BEV%'

--GO

Create Function AVGUnitPrice (@pCategoryName nvarchar(50))
returns float
as	
	begin
		return(
			Select  AVG(P.UnitPrice)
			From Products P
			Join Categories C On C.CategoryID = P.CategoryID
			Group by P.CategoryID, C.CategoryName
			Having C.CategoryName like '%' + @pCategoryName + '%'
		)
	end
go

Declare @t2 float
exec @t2 = AVGUnitPrice @pCategoryName = 'bev';
Print @t2
go

--функція повертає суму продажу за датою (параметр), коли здійснювалися продажі.

--Select Sum(Od.UnitPrice * Od.Quantity), O.OrderDate
--From [Order Details] Od
--Join Orders O On Od.OrderID = O.OrderID
--Group By O.OrderDate 
--Having O.OrderDate = '1998-05-06'

Create Function TotalSellsInDate(@someDate Date)
returns int
as
	begin
	return(
		Select Sum(Od.UnitPrice * Od.Quantity)
		From [Order Details] Od
		Join Orders O On Od.OrderID = O.OrderID
		Group By O.OrderDate 
		Having O.OrderDate = @someDate
		)
	end
	
go

Declare @t3 float
exec @t3 = TotalSellsInDate @someDate = '1998-05-06';
Print @t3
go

--4. функція  повертає інформацію про останній проданий товар.
--Select *
--from Orders O
--Join [Order Details] od on Od.OrderID = O.OrderID
--Join Products P on P.ProductID = Od.ProductID
--Where O.OrderID = (Select top 1 o.OrderID
--from Orders O
--Order by o.OrderDate)
--go



Create Function LastSell()
returns Table
as
	return(
		Select O.OrderID, O.OrderDate, P.ProductName, Od.Quantity
		from Orders O
		Join [Order Details] od on Od.OrderID = O.OrderID
		Join Products P on P.ProductID = Od.ProductID
		Where O.OrderID = (Select top 1 o.OrderID
							from Orders O
							Order by o.OrderDate desc)
	)
go

Select *
From LastSell()
go

--5. Функція  повертає інформацію про перший проданий товар.
Create Function FirstSell()
returns Table
as
	return(
		Select O.OrderID, O.OrderDate, P.ProductName, Od.Quantity
		from Orders O
		Join [Order Details] od on Od.OrderID = O.OrderID
		Join Products P on P.ProductID = Od.ProductID
		Where O.OrderID = (Select top 1 o.OrderID
							from Orders O
							Order by o.OrderDate)
	)
go

Select *
From FirstSell()
go
----6. функція  повертає інформацію про товари за заданою категорією
----товарів заданого виробника. Категорія товару та назва виробника передаються як параметр.

Select *
from Products P
Join Suppliers S on S.SupplierID = P.SupplierID
Join Categories C on C.CategoryID = P.CategoryID
Where C.CategoryID = 1 and S.SupplierID = 1
go

Create Function ProductInfo (@CatName nvarchar(50), @CompName nvarchar(50))
returns table
	as
	return(
		Select P.ProductName, P.UnitPrice, C.CategoryName, S.CompanyName
		from Products P
		Join Suppliers S on S.SupplierID = P.SupplierID
		Join Categories C on C.CategoryID = P.CategoryID
		Where C.CategoryName like '%' + @CatName + '%'
		and S.CompanyName like '%' + @CompName + '%'
	)
	go

Select *
from ProductInfo ('bev', 'exo')

--7. функція  повертає інформацію про співробітників, яким у цьому
--році виповниться 50 років.

--Select *
--From Employees E
--Where 2022 - YEAR (E.BirthDate) = 50
--go

Create Function EmployeesInfo (@age int) --вік задав як параметр до фунції щоб зробити її більш універсальною
returns table 
	as
	return (
	Select *
	From Employees E
	Where 2022 - YEAR (E.BirthDate) = @age
	)

	Select *
	From EmployeesInfo (50)

	Select *
	From EmployeesInfo (62)

	--1. При додаванні нового товару тригер перевіряє його наявність (за назвою), якщо такий товар є і нові дані про
--товар збігаються з вже існуючими даними (постачальник, ім'я, категорія, ціна), замість додавання відбувається оновлення інформації про кількість товару.

	Select *
	from products

	Select count(*)
	From Products P
	Where P.ProductName like '%pavl%'
	Go

	Create trigger ProductCheck
	on Products
	Instead of Insert
	as
	Begin
		Declare
		@vProdExist int = (Select count(*)
			From Products P
			Where P.ProductName like '%pavl%'),
		@vProductAmount int = (select inserted.UnitsInstock From inserted)
		if (@vProdexist > 0)
			Begin
			Insert into Products(UnitsInStock)
			Values (@vProdExist)

			End

	End
	Go

	--2. При звільненні співробітника тригер переносить інформацію про звільненого співробітника таблицю «EmployeeBCK»
	
	Select *
	into EmployeesTemp
	From Employees

	Select *
	From EmployeesTemp

	Create Table EmployeeBCK(
	ID int PRIMARY KEY NOT NULL IDENTITY(1,1),
	LastName nvarchar(30),
	FirtsName nvarchar(30),
	Title nvarchar(50),
	Phone nvarchar(24)
	)
	go

	Create trigger PastEmploeeInfo
	on EmployeesTemp
	After Delete
	as
	Begin
		Declare 
		@vEmpLastName nvarchar(50) = (Select deleted.LastName from deleted),
		@vEmpFirstName nvarchar(50) = (Select deleted.FirstName from deleted),
		@vTitle nvarchar(50) = (Select deleted.Title from deleted),
		@vPhone nvarchar(50) = (Select deleted.HomePhone from deleted)

		Insert into 
		EmployeeBCK (LastName, FirtsName, Title, Phone)
		Values (@vEmpLastName, @vEmpFirstName, @vTitle, @vPhone)
	End
	Go

	delete
	From EmployeesTemp 
	Where EmployeesTemp.FirstName like 'Anne'

	Select *
	from EmployeeBCK
	--3. Тригер забороняє додавати нового постачальника, якщо кількість існуючих постачальників більше 50.

	Select Count(*)
	From SuppliersTemp

	Select *
	From SuppliersTemp


	Alter trigger SuppliersCountCheck
	On SuppliersTemp
	Instead of Insert	
	As
	Begin
	if ((Select Count(*) 
	From SuppliersTemp)<20)
	Print 'To many Suppliers. It is forbiden add new'
	End
	Go

	Drop trigger SuppliersCountCheck

	Insert Into SuppliersTemp (CompanyName, ContactName)
	Values ('Yurii LTD', 'Yurii Sokol')

	Delete
	From SuppliersTemp 
	Where SuppliersTemp.CompanyName like 'Yurii LTD'

	