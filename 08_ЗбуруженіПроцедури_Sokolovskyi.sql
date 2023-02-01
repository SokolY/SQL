--1. Збережена процедура що відображає повну інформацію про всі товари.

CREATE proc ProdInfo 
AS 
	BEGIN
		SELECT *
		FROM Products 
	END 
GO

Exec ProdInfo
Go

--2. Збережена процедура що показує повну інформацію про покупців категорії. Категорія
--передається як параметр (назва категорії).

Create proc CustomerInfo
	@pCatName nvarchar(50)
As
Begin
	Select * 
	From Customers C
	Join Orders O On O.CustomerID = C.CustomerID
	Join [Order Details] OD on OD.OrderID = O.OrderID
	Join Products P on OD.ProductID = P.ProductID
	Join Categories Cat on Cat.CategoryID = P.CategoryID
	Where Cat.CategoryName like ('%' + @pCatName + '%')
End
Go


Exec CustomerInfo @pCatName='sea'
Go

--3. Збережена процедура що показує топ-3 найстаріших співробітників (за датою найму).
Create proc LongestWorkEmp
As
	Begin
		Select top (3) *
		from Employees
		order by HireDate
	End
Go
	
Exec LongestWorkEmp

--4. Збережена процедура що показує інформацію про саму прибуткову категорію.
Create Proc TopSellCategory
As
	Begin
		Select top 1C.CategoryName, Sum(OD.UnitPrice * OD.Quantity) as TotalSels
		From Categories C
		Join Products P On P.CategoryID = C.CategoryID
		Join [Order Details] OD ON P.ProductID = OD.ProductID
		Group by C.CategoryName
		Order By TotalSels Desc
	End
Go

Exec TopSellCategory
Go

--5. Збережена процедура що показує товари для необхідної категорії за умови:
--	- тільки ті товари, товара на складі яких меньше середньостатистичної кількості у замовленях, помноженої на якесь число.
--	Назва категорії та число-множитель будемо передавати паремтрами процедури.
Create proc ProductsOnDemand
	@multiplicator int,
	@category nvarchar(50)
As
		Begin
				SELECT P.ProductName,
			   P.UnitsInStock,
			   temp1.AVGItemSells
		FROM Products P
		JOIN
		  (SELECT Od.ProductID,
				  AVG(od.Quantity) AS AVGItemSells
		   FROM [Order Details] Od
		   GROUP BY Od.ProductID) AS temp1 ON temp1.ProductID = P.ProductID
		JOIN Categories C ON C.CategoryID = P.CategoryID
		WHERE P.UnitsInStock > temp1.AVGItemSells * @multiplicator
		  AND C.CategoryName like ('%' + @category + '%')
End
Go

Exec ProductsOnDemand @multiplicator = 2, @category= 'prod'