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

