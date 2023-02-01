/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
From [DenormalizedTable]

--Додаєм primery key до ненормалізованої таблиці
ALTER TABLE DenormalizedTable
ADD Id int identity(1, 1) primary key

--створюємо таблицю з власниками магазинів і їхніми податковими номерами
SELECT DISTINCT OwnerIndividualTaxId,[OwnerName]
  INTO ShopOwners
  FROM [Shops].[dbo].[DenormalizedTable]

--відокремлюємо магазини
SELECT DISTINCT ShopName
INTO [Shops]
FROM DenormalizedTable

--відокремлюємо продукти які продаються в магазинах/ 
SELECT DISTINCT ProductCode, ProductName, ProductDescription, WholeSalePrice
INTO Products
FROM DenormalizedTable

-- відокремлюмо працівників
SELECT DISTINCT EmployeeName, EmployeeSalary, EmployeeIndividualTaxId
INTO Employee
FROM DenormalizedTable

--створюєм окрему таблицю де вносимо назву магазину, код продукту, та роздрібну ціну на нього в магазині 
SELECT DISTINCT ShopName, ProductCode, SellingPrice
INTO SellingPrice
FROM DenormalizedTable

-- Розділяємо ім*я і прізвище власника на окремі колонки
ALTER TABLE ShopOwners
ADD OwnerLastName nvarchar(50)

UPDATE ShopOwners
SET OwnerLastName = RIGHT (OwnerName, Len(OwnerName)- CHARINDEX(' ', Ownername))

UPDATE ShopOwners
SET OwnerName = LEFT (OwnerName,  CHARINDEX(' ', Ownername));

SELECT *
FROM ShopOwners