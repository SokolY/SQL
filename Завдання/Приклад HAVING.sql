 --Нажаль, вигадав не дуже доречне завдання для демонстрації HAVING.
 --Продемонструвати роботу HAVING в контесті цього запиту не є можливим.  
 --Задача: вивести кількість товарів по кожній з категорій, залишок яких на складі меньше ніж 10.
  
 SELECT P.CategoryID
	,COUNT(P.CategoryID) AS 'PrCount'
 FROM Products P
 WHERE P.UnitsInStock<10
 GROUP BY P.CategoryID
 Order by CategoryID


 --Продемнострувати HAVING можливо на цій задачі.
 --Задача: вивести айді груп товарів, які містять меньше ніж 10 товарів
 --Якщо є бажання - можете погратись - додати імена груп.
  
 SELECT P.CategoryID
	,COUNT(*) AS 'PrCount'
 FROM Products P
 GROUP BY P.CategoryID
 HAVING COUNT(*)<10 
 Order by CategoryID

--Або (Варіант №2), через підзапит (завтра розглянемо що таке "підзапит")
 
SELECT * 
FROM ( --починаємо підзапит і отримуємо табличку, для якої і будемо робити фльтр по кількості
	SELECT P.CategoryID
		,COUNT(*) AS 'PrCount'
	FROM Products P
	GROUP BY P.CategoryID
	) AS Pidzapit --Кінець підзапиту: для вибірки, яку він повертає призначили аліас, щобзручніше було звертатись.
					-- Результат підзапиту - це вибірка, яка зберігається на час виконання материнського запиту.
WHERE Pidzapit.PrCount<10 -- і тут працюємо з колонками підзапиту, використовуючи звичний нам WHERE.






