--1. Вивести всі замовлення за довільною категорією, впорядкувавши їх за датою замовлення

SELECT O.OrderID, OrderDate
FROM Orders as O
JOIN [Order Details] as OD
ON O.OrderID = OD.OrderID
JOIN Products as P
ON OD.ProductID = P.ProductID
JOIN Categories as Cat
ON P.CategoryID = Cat.CategoryID
WHERE Cat.CategoryName = 'Produce'
Order By OrderDate 

--2. Вивести інформацію про перший замовлений товар.

--3. Вивести категорії товарів, виторг від продажу яких більше 1000.
SELECT *
FROM Categories

SELECT *
FROM Products

SELECT *
FROM [Order Details]

SELECT Cat.CategoryName
From Categories as Cat
JOIN Products as P
On Cat.CategoryID = P.CategoryID
JOIN [Order Details] as Od
ON Od.ProductID = P.ProductID
WHERE Od.UnitPrice*Od.Quantity >1000
GROUP BY Cat.CategoryName

--4. Вивести кількість співробітників у кожному регіоні.
SELECT *
FROM Employees

SELECT *
FROM EmployeeTerritories


SeLECT *
FROM Territories
ORDER BY RegionID

SeLECT COUNT(TerritoryID), RegionID
FROM Territories
GROUP BY RegionID

SELECT COUNT (E.EmployeeID) as EmpCount, R.RegionDescription
FROM Employees as E
JOIN EmployeeTerritories as ES
ON E.EmployeeID = ES.EmployeeID
JOIN Territories as T
ON T.TerritoryID = ES.TerritoryID
JOIN Region AS R
ON R.RegionID = T.RegionID 
GROUP BY R.RegionDescription

SELECT Region, COUNT (Region) AS [Employees in region] FROM Employees
GROUP BY Region