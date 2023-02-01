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

SELECT C.CategoryID, COUNT(P.ProductName)
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID
HAVING COUNT(P.ProductName)>(
	Select AVG(q1.column2)
	FROM (SELECT C.CategoryID, COUNT(P.ProductName) as column2
	FROM Categories C
	JOIN Products P ON C.CategoryID = P.CategoryID
	GROUP BY C.CategoryID) as q1)


--4. Вивести назви продуктів, обсяг продажів яких більший за середнє значення (взяти середню кількість замовлених одиниць товару та порвіняти).

SELECT P.ProductID,
       P.ProductName,
       SUM(OrDe.Quantity) AS TotalSels
FROM Products P
JOIN [Order Details] OrDe ON P.ProductID = OrDe.ProductID
GROUP BY P.ProductName,
         P.ProductID
HAVING SUM(OrDe.Quantity) >
  (SELECT AVG(temp1.TotalSels)
   FROM
     (SELECT P.ProductName,
             SUM(OrDe.Quantity) AS TotalSels
      FROM Products P
      JOIN [Order Details] OrDe ON P.ProductID = OrDe.ProductID
      GROUP BY P.ProductName) AS temp1)

--5. Вивести імена співробітників, які мають менше 5 територій.
Select E.FirstName
From Employees E
Join EmployeeTerritories ET On ET.EmployeeID = E.EmployeeID
Group By E.FirstName
Having Count(ET.TerritoryID)>5


--6. Вивести імена категорій, середня вартість товарів за якими вище за аналогічний показник за категорією Seafood
SELECT P.CategoryID,
       AVG(P.UnitPrice)
FROM Products P
GROUP BY P.CategoryID
HAVING AVG(P.UnitPrice)>
  (SELECT AVG(P.UnitPrice) AS AvgPrice
   FROM Products P
   JOIN Categories C ON P.CategoryID = C.CategoryID
   WHERE C.CategoryName like 'Seafood')

--7. Вивести назви категорій, виручка з продажу товарів якої вища ніж у Dairy Products
SELECT C.CategoryName,
       Sum(OrdD.UnitPrice * Quantity) AS TotalSelsForCategory
FROM Categories C
JOIN Products P ON P.CategoryID = C.CategoryID
JOIN [Order Details] AS OrdD ON OrdD.ProductID = P.ProductID
GROUP BY C.CategoryName
HAVING Sum(OrdD.UnitPrice * Quantity) >
  (SELECT temp1.TotalSels
   FROM
     (SELECT C.CategoryName,
             Sum(OrdD.UnitPrice * Quantity) AS TotalSels
      FROM Categories C
      JOIN Products P ON P.CategoryID = C.CategoryID
      JOIN [Order Details] AS OrdD ON OrdD.ProductID = P.ProductID
      WHERE C.CategoryName like 'Dairy Products'
      GROUP BY C.CategoryName) AS temp1)

--8. Вивести назви категорій та повні імена співробітників, які зробили за ними максимальну виручку (найуспішнішій продажник по кожній з категорій).
	
	--з цим на разі не розібрасвя


--9. Вивести назву та прізвище контактної особи компанії, яка замовила товарів на найбільшу суму.
SELECT top(1) temp1.CompanyName,
       temp1.ContactName,
       temp1.TotalCostOrder
FROM
  (SELECT C.CompanyName,
          C.ContactName,
          SUM(OrdD.Quantity * OrdD.UnitPrice) AS TotalCostOrder
   FROM Customers C
   JOIN Orders O ON O.CustomerID = C.CustomerID
   JOIN [Order Details] OrdD ON OrdD.OrderID = O.OrderID
   GROUP BY C.CompanyName,
            C.ContactName) AS temp1
ORDER BY temp1.TotalCostOrder DESC

--10. Вивести кількість товарів, проданих у південному регіоні.
SELECT Sum(OrdD.Quantity),
       R.RegionDescription AS TotalSelsinRegion
FROM [Order Details] OrdD
JOIN Orders O ON OrdD.OrderID = O.OrderID
JOIN Employees Em ON O.EmployeeID = Em.EmployeeID
JOIN EmployeeTerritories EmTe ON EmTe.EmployeeID = Em.EmployeeID
JOIN Territories Ter ON EmTe.TerritoryID = Ter.TerritoryID
JOIN Region R ON R.RegionID = Ter.RegionID
GROUP BY R.RegionDescription
HAVING R.RegionDescription = 'Southern'

