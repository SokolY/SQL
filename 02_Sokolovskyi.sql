	--	--Завдання 1 - стоворити БД Академія (Academy).
CREATE DATABASE Academy; 

	
	--Завдання 2 - Створити таблицю Групи (Groups)
	CREATE TABLE Groups(
	ID int PRIMARY KEY NOT NULL IDENTITY(1,1),

	[Name] nvarchar(10) NOT NULL UNIQUE (Name),
	CHECK ([Name] >''),

	Rating int Not NULL
	CHECK ((Rating >=  0)  AND (Rating <= 5)),

	[Year] int not Null,	
	CHECK (([Year]>=0 AND ([Year]<=5)))
	)

	--Завдання 2.1 - Наповнити таблицю Групи (Groups) (5-6 записів).
	INSERT INTO Groups (Name, Rating, Year)
	VALUES ('KSM-11', 4, 1),
	('KSM-22', 3, 2),
	('KSM-32', 5, 3),
	('SKS-32', 2, 3),
	('SKS-41', 4, 4),
	('KSM-52', 5, 5);

	--Завдання 2.2 - Вибірка по таблиці Групи (Groups): містить тільки групи, які вчаться 3 роки та більше, відсортувати за рейтингом.
	SELECT * FROM Groups
	WHERE [Year]>=3 ORDER BY Rating


	--Завдання 3 - Створити таблицю Кафедри (Departments).
	CREATE TABLE Departments(
	ID int PRIMARY KEY Not NULL IDENTITY(1,1),

	Financing money Not NULL DEFAULT 0,
	CHECK (Financing >= 0),

	[Name] nvarchar(100) Not NULL
	UNIQUE (Name)
	CHECK ([Name] >'')
	)


	--Завдання 3.1 - Наповнити таблицю Кафедри (Departments) (3-4 записи).
	INSERT INTO Departments([Name], Financing)
	VALUES('OISU', 2000000),
		  ('PTCA', 1800000),
		  ('PI', 2300000),
		  ('IOSYS', 2100000)

	--Завдання 3.2 - Вибірка по таблиці Кафедри (Departments): показати кафедри, в яких фінансування меньше якогось значення.
	Select * FROM Departments
	WHERE Financing <2000500

	 --Завдання 4 - Створити таблицю Факультети (Faculties)
CREATE TABLE Faculties(
	ID int PRIMARY KEY Not NULL IDENTITY(1,1),
	[Name] nvarchar(100) Not NULL
	UNIQUE(Name),
	CHECK([Name]>''),
)

--Завдання 4.1 - Наповнити таблицю Факультети (Faculties) (2-3 записи).
INSERT INTO Faculties([Name])
	VALUES('Faculty of Law'),
		  ('Faculty of Computer science'),
		  ('Faculty of Agriculture ')


--Завдання 5 - Створити таблицю Викладачі (Teachers)
CREATE TABLE Teachers(
	ID int PRIMARY KEY Not NULL IDENTITY(1,1),

	EmploymentDate date Not NULL
	CHECK (EmploymentDate>'1990-01-01'),

	[Name] nvarchar(max) Not NULL
	CHECK ([Name]>''),

	Premium money Not NULL DEFAULT 0
	CHECK (Premium>=0),

	Salary money Not NULL
	CHECK (Salary>0),

	Surname nvarchar(max) Not NULL
	CHECK(Surname>'')
)	

--Завдання 5.1 - Наповнити таблицю Викладачі (Teachers) (6-7 записів)
INSERT INTO  Teachers(Surname, [Name], Salary, Premium, EmploymentDate)
VALUES('Sokolovskyi', 'Yurii', 32000, 7000, '2015-11-1'),
('Vasylkiv', 'Vitaliy', 29000, 3500, '2013-4-13'),
('Khlushko', 'Orest', 33000, 4000, '2005-11-11'),
('Yakovchuk', 'Artem', 18000, 2500, '2021-10-20'),
('Abrtov', 'Semen', 25000, 3300, '2014-12-02'),
('Trubin', 'Dmytro', 37000, 8000, '2010-5-4'),
('Bondar', 'Taras', 26000, 0, '2017-5-10')

--Завдання 5.2 - Вибірка по таблиці Викладачі (Teachers): показати записи, в яких викладач був прийнятий у першій половині якогось руку (на ваш вибір). Відсортувати по ставці та по надбавці.
SELECT * FROM Teachers
	WHERE MONTH(EmploymentDate) < 7
	ORDER BY Premium

--Завдання 5.3 - Вибірка по таблиці Викладачі (Teachers): виконати пошук викаладачів в яких перша буква прізвища - "а", а друга буква є голосною.
SELECT * FROM Teachers
	WHERE Surname LIKE 'a[a, e, i, o, u, y]%'