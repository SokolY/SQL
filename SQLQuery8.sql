--1. Вивести категорії продуктів у яких кількість товарів від 8 до 12

SELECT C.CategoryName, COUNT(P.ProductName) as 'CountProductInCategories'
FROM Categories C
JOIN Products P On C.CategoryID = P.CategoryID
GROUP BY C.CategoryName
HAVING COUNT(P.ProductName) Between 8 and 12

--2. Вивести назви товарів, які були замовлені більше 5 разів.
SELECT P.ProductName, COUNT(OrDt.OrderID) As 'OrderCounts'
FROM Products P
Join [Order Details] as OrDt ON OrDt.ProductID = P.ProductID
GROUP BY P.ProductName
HAVING COUNT(OrDt.OrderID) > 5

--3. Вивести назви категорій, у яких товарів більше середнього значення (взяти сердню кількість товарів по категорії та порівняти).
Select AVG (C.U)
From Categories C

SELECT CT.CategoryName, AmountOfProdInCategories.Products_IN_Category
From Categories Ct,
(SELECT C.CategoryName, C.CategoryID
, COUNT (*) as Products_IN_Category
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName, C.CategoryID) AS AmountOfProdInCategories 
WHERE  AmountOfProdInCategories.CategoryID = Ct.CategoryID
AND AmountOfProdInCategories.Products_IN_Category>AVG(AmountOfProdInCategories.Products_IN_Category)


--4. Вивести назви продуктів, обсяг продажів яких більший за середнє значення (взяти середню кількість замовлених одиниць товару та порвіняти).

--Підзапит точно правильний, але що з ним робити далі я не знаю
SELECT P.ProductID, P.ProductName, SUM(OrDe.Quantity) as Totals
From Products P 
JOIN [Order Details] OrDe On P.ProductID = OrDe.ProductID
GROUP BY P.ProductName, P.ProductID

SELECT P.ProductName 
From Products P,
(SELECT P.ProductID, P.ProductName, SUM(OrDe.Quantity) as Totals
From Products P 
JOIN [Order Details] OrDe On P.ProductID = OrDe.ProductID
GROUP BY P.ProductName, P.ProductID) as TotaProdlSels
WHERE TotaProdlSels.ProductID = P.ProductID 
GROUP BY P.ProductName
HAVING TotaProdlSels.Totals>AVG(TotaProdlSels.Totals)




--5. Вивести імена співробітників, які мають менше 5 територій.
Select E.FirstName
From Employees E
Join EmployeeTerritories ET On ET.EmployeeID = E.EmployeeID
Join Territories Ter On Ter.TerritoryID = ET.TerritoryID
Group By E.FirstName
Having Count(Ter.TerritoryID)>5

--6. Вивести імена категорій, середня вартість товарів за якими вище за аналогічний показник за категорією Seafood
SELECT P.CategoryID, AVG(P.UnitPrice)
FROM Products P
GROUP BY P.CategoryID


SELECT AVG(P.UnitPrice) as AvgPrice
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName like 'Seafood'

SELECT C.CategoryName
FROM Categories C,
(SELECT P.CategoryID, AVG(P.UnitPrice) as AvgPrice
FROM Products P
GROUP BY P.CategoryID) as CategoriesAVG,
(SELECT P.CategoryID, (P.UnitPrice) as AvgPrice
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName like 'Seafood') as AVGForSea
WHERE C.CategoryID = CategoriesAVG.CategoryID
AND C.CategoryID = AVGForSea.CategoryID
AND CategoriesAVG.AvgPrice > AVGForSea.AvgPrice





--1. Вивести кількість товарів, ціна яких більша за 50
SELECT COUNT(*)
FROM Products
WHERE UnitPrice >50

--5. Вивести імена співробітників, які обробили понад 50 замовлень.

Select E.LastName, COUNT(O.OrderID)
From Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.LastName
HAVING COUNT(O.OrderID) >50

Select E.FirstName
From Employees E
Join EmployeeTerritories ET On ET.EmployeeID = E.EmployeeID
Group By E.FirstName
Having Count(ET.TerritoryID)>4



SELECT *
FROM EmployeeTerritories