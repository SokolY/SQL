
--8. Вивести назви категорій та повні імена співробітників, які зробили за категоріями максимальну виручку 
--(найуспішнішій продажник по кожній з категорій).

select C.CategoryName
	,E.FirstName
	,E.LastName
	,CatMaxVal.CatMaxVal
from 
	(select 
		CatEmpVal.CategoryID
		,max (valordered) as CatMaxVal--category id, max order
	from (
		select 
			P.CategoryID
			,O.EmployeeID
			, sum (OD.UnitPrice * OD.Quantity) as ValOrdered
		from Products P
			join  [Order Details] OD on P.ProductID = OD.ProductID
			join  Orders O on O.OrderID = OD.OrderID
		group by 
			P.CategoryID
			, O.EmployeeID
		) as CatEmpVal
	group by CatEmpVal.CategoryID) as 	CatMaxVal
	join (select 
			P.CategoryID
			,O.EmployeeID
			, sum (OD.UnitPrice * OD.Quantity) as ValOrdered
		from Products P
			join  [Order Details] OD on P.ProductID = OD.ProductID
			join  Orders O on O.OrderID = OD.OrderID 
		group by 
			P.CategoryID
			, O.EmployeeID) as CatEmpVal
			on CatEmpVal.CategoryID = CatMaxVal.CategoryID 
				and CatEmpVal.ValOrdered = CatMaxVal.CatMaxVal
	join Categories C on C.CategoryID = CatMaxVal.CategoryID
	join Employees E on E.EmployeeID = CatEmpVal.EmployeeID 

	-- Варіант 2
--8. Вивести назви категорій та повні імена співробітників, які зробили за категоріями максимальну виручку 
--(найуспішнішій продажник по кожній з категорій).
select   E.FirstName, E.LastName,
 C.CategoryID, C.CategoryName
	, Sum(OD.Quantity*OD.UnitPrice) maxVal
from Employees E
	join Orders O on E.EmployeeID = O.EmployeeID
	join [Order Details] OD on OD.OrderID = O.OrderID
	join Products P on P.ProductID = OD.ProductID
	Join Categories C on C. CategoryID = P.CategoryID
group by E.EmployeeID, E.FirstName, E.LastName
	,C.CategoryID ,C.CategoryName

HAVING  EXISTS (
	select MAX (ValOrdered) MaxCatSell
		,CatEmpVal.CategoryID
	from (select 
			P.CategoryID
			,O.EmployeeID
			, sum (OD.UnitPrice * OD.Quantity) as ValOrdered
		from Products P
			join  [Order Details] OD on P.ProductID = OD.ProductID
			join  Orders O on O.OrderID = OD.OrderID 
		group by 
			P.CategoryID
			, O.EmployeeID) CatEmpVal
	group by CatEmpVal.CategoryID
	Having CatEmpVal.CategoryID = C.CategoryID
		and MAX (CatEmpVal.ValOrdered) 
			= Sum(OD.Quantity*OD.UnitPrice))


--Варіант 3 за допомогою  таблиць

select 
	P.CategoryID
	,O.EmployeeID
	, sum (OD.UnitPrice * OD.Quantity) as ValOrdered
into CatEmpVal
from Products P
	join  [Order Details] OD on P.ProductID = OD.ProductID
	join  Orders O on O.OrderID = OD.OrderID 
group by 
	P.CategoryID
	, O.EmployeeID



select C.CategoryName
	,E.FirstName
	,E.LastName
	,CatMaxVal.CatMaxVal
from 
	(select 
		CatEmpVal.CategoryID
		,max (valordered) as CatMaxVal--category id, max order
	from CatEmpVal
	group by CatEmpVal.CategoryID) as 	CatMaxVal
	join CatEmpVal
			on CatEmpVal.CategoryID = CatMaxVal.CategoryID 
				and CatEmpVal.ValOrdered = CatMaxVal.CatMaxVal
	join Categories C on C.CategoryID = CatMaxVal.CategoryID
	join Employees E on E.EmployeeID = CatEmpVal.EmployeeID 

drop table CatEmpVal
	

	--Варіант 4 за допомогою тичасових таблиць

	
select 
	P.CategoryID
	,O.EmployeeID
	, sum (OD.UnitPrice * OD.Quantity) as ValOrdered
into #CatEmpVal
from Products P
	join  [Order Details] OD on P.ProductID = OD.ProductID
	join  Orders O on O.OrderID = OD.OrderID 
group by 
	P.CategoryID
	, O.EmployeeID

	
select C.CategoryName
	,E.FirstName
	,E.LastName
	,CatMaxVal.CatMaxVal
from 
	(select 
		#CatEmpVal.CategoryID
		,max (valordered) as CatMaxVal--category id, max order
	from #CatEmpVal
	group by #CatEmpVal.CategoryID) as 	CatMaxVal
	join #CatEmpVal
			on #CatEmpVal.CategoryID = CatMaxVal.CategoryID 
				and #CatEmpVal.ValOrdered = CatMaxVal.CatMaxVal
	join Categories C on C.CategoryID = CatMaxVal.CategoryID
	join Employees E on E.EmployeeID = #CatEmpVal.EmployeeID 



--Простий приклад EXIST
--завдання: вивсести категорій з товарами з цінником більше 100

select C.CategoryName 
from Categories C
	join Products P on P.CategoryID=C.CategoryID
where p.UnitPrice > 100

select *
from Categories C
where EXISTS (
	select *
	from Products P
	where  C.CategoryID = P.CategoryID
		and C.CategoryID = P.UnitsInStock)





