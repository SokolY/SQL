--1. Вивести назви товарів, що знаходяться в тій же категорії, що і Tofu
SELECT P.ProductName,
       C.CategoryName
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName =
    (SELECT C.CategoryName
     FROM Categories C
     JOIN Products P ON P.CategoryID = C.CategoryID
     WHERE P.ProductName like 'Tofu')

--2. Вивести імена територій що знаходяться в тому ж регіоні що Dallas
SELECT T.TerritoryDescription,
       T.RegionID
FROM Territories T
JOIN Region R ON R.RegionID = T.RegionID
WHERE T.RegionID =
    (SELECT R.RegionID
     FROM Region R
     JOIN Territories T ON T.RegionID = R.RegionID
     WHERE T.TerritoryDescription = 'Dallas')

--3. Вивести ім'я категорії, яка продала найменше товарів (за кількістю).
SELECT C.CategoryID,
       C.CategoryName,
       SUM(OD.Quantity) AS TotalSells
FROM Categories C
JOIN Products P ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY C.CategoryID,
         C.CategoryName
HAVING SUM(OD.Quantity) =
  (SELECT min(Temp1.TotalSellInCat)
   FROM
     (SELECT SUM(OD.Quantity) AS TotalSellInCat
      FROM Categories C
      JOIN Products P ON P.CategoryID = C.CategoryID
      JOIN [Order Details] OD ON OD.ProductID = P.ProductID
      GROUP BY C.CategoryID) AS Temp1)

--4. Вивести ім'я товарів, у яких ціна менша ніж у товару Tofu та CHAI
SELECT P.ProductName,
       P.UnitPrice
FROM Products P
WHERE P.UnitPrice <
    (SELECT min(P.UnitPrice)
     FROM Products P
     WHERE P.ProductName in ('Tofu',
                             'CHAI'))

--5. Вивести назви товарів, чия ціна більш ніж середня ціна за товарами категорії Seafood
SELECT P.ProductName,
       P.UnitPrice
FROM Products P
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE P.UnitPrice >
    (SELECT avg(p.UnitPrice)
     FROM Products P
     JOIN Categories C ON C.CategoryID = P.CategoryID
     WHERE C.CategoryName like 'Seafood')

--6. Вивести імена товарів, ціна яких більш ніж на 20 дорожча за Tofu
SELECT P.ProductName,
       P.UnitPrice
FROM Products P
WHERE P.UnitPrice >
    (SELECT P.UnitPrice
     FROM Products P
     WHERE P.ProductName like 'Tofu') + 20

--7. Вивести постачальників, які не поставляють товари категорії Confections
SELECT S.CompanyName
FROM Suppliers S
WHERE S.CompanyName not in
    (SELECT DISTINCT S.CompanyName
     FROM Suppliers S
     JOIN Products P ON P.SupplierID = S.SupplierID
     JOIN Categories C ON C.CategoryID = P.CategoryID
     WHERE CategoryName like 'Confections')
