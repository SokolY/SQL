CREATE DATABASE School;

--Створюю таблицю з інформацією  про учнів
Create Table Pupils(
	PupilID int PRIMARY KEY NOT NULL IDENTITY(1,1),

	[First Name] nvarchar(20) NOT NULL,
	CHECK ([First Name] >''),

	[Last Name] nvarchar(20) NOT NULL,
	CHECK ([Last Name] >''),
	
	[Date of Birth] Date,

	[Date of Join] Date
	)



	--Створюю таблицю з інформацією  про працівників школи
	Create Table SchoolEmployee(
		EmployeeID int PRIMARY KEY NOT NULL IDENTITY(1,1),

		[First Name] nvarchar(30) NOT NULL,
		CHECK ([First Name] >''),

		[Last Name] nvarchar(30) NOT NULL,
		CHECK ([Last Name] >''),

		[Date of Birth] Date,

		[Hire Date] Date,
		
		RoleId int FOREIGN KEY REFERENCES SchoolRoles(ID)
	)

	--Створюю таблицю з інформацією  про посади в школі
	Create Table SchoolRoles(
		ID int PRIMARY KEY NOT NULL IDENTITY(1,1),
		Position nvarchar(30)
		)

		--Створюю таблицю з інформацією  про категорію вчителів
		Create Table TeacherCategory(
			TeacherCategoryId int PRIMARY KEY NOT NULL IDENTITY(1,1),
			Category nvarchar(30) not Null,
			[CategoryDescription] nvarchar(90)
		)

		--Створюю допоміжну таблицю з щоб з інфою який вчитель має яку кетегорію
		Create Table EmployeeTeacherCategory(
			EmployeeID int not Null FOREIGN KEY REFERENCES SchoolEmployee(EmployeeID),
			TeacherCategoryId int not Null FOREIGN KEY REFERENCES TeacherCategory (TeacherCategoryId),
			CONSTRAINT MyFirstConstraint Primary key (EmployeeID, TeacherCategoryId)
		)

		Drop table SchoolRoles
	
	--Створюю таблицю з інформацією  про клас
	Create Table Class(
	ClassID int PRIMARY KEY NOT NULL IDENTITY(1,1),
	LeadTeacherID int FOREIGN KEY REFERENCES SchoolEmployee(EmployeeID), -- ід класного керівника
	[Class Spesialization] nvarchar(20),
	[Spesialization Description] nvarchar(180),
	[Class Name] nvarchar(20)
	)


	--Створюю таблицю з інформацією  про те які учні навчаються в якому класі
	Create table ClassPupil(
	ClassID int FOREIGN KEY REFERENCES Class(ClassID),
	PupilID int FOREIGN KEY REFERENCES Pupils(PupilID)
	)

	--створюю таблицю про предмети які вивчають в школі
	Create Table Subjects(
		SubjectID int PRIMARY KEY NOT NULL IDENTITY(1,1),
		[Subject Name] nvarchar(20)
		)

		--Створюю таблицю із прив*язкою вчителя до предмету
		Create Table SubjectTeacher(
		SubjectID int FOREIGN KEY REFERENCES Subjects(SubjectID),
		TeacherID int FOREIGN KEY REFERENCES SchoolEmployee(EmployeeID)
		)

		--Створюю таблицю з оцінками учнів по предметах
		Create Table PupilMarks(
		PupilID int FOREIGN KEY REFERENCES Pupils(PupilID),
		SubjectID int FOREIGN KEY REFERENCES Subjects(SubjectID),
		SubjectMark int)

		--Створюю таблицю з зарплатою працівників
		Create Table EmployeeSalary(
		EmployeeID int FOREIGN KEY REFERENCES SchoolEmployee(EmployeeID),
		EmployeeSalary int)

		--Наповнюю таблицю учнів
		INSERT INTO Pupils ([First Name], [Last Name], [Date of Birth], [Date of Join])
		VALUES ('Yurii', 'Romanenko', '2012-12-4', '2019-01-09'),
		('Halyna', 'Ivanenko', '2012-10-14', '2019-01-09'),
		('Stepan', 'Pivtorak', '2012-5-12', '2019-01-09'),
		('Olga', 'Pastushok', '2012-9-01', '2019-01-09'),
		('Olga', 'Oliynuk', '2012-3-08', '2019-01-09'),
		('Iryna', 'Bundas', '2010-3-12', '2017-01-09'),
		('Vasyl', 'Bundas', '2010-3-12', '2017-01-09'),
		('Roman', 'Yaremchuk', '2010-4-15', '2017-01-09'),
		('Natalya', 'Holovata', '2010-11-22', '2017-01-09'),
		('Natalya', 'Mudra', '2010-10-10', '2017-01-09')
		
	


		--Наповнюю таблицю працівників школи
		INSERT INTO SchoolEmployee ([First Name], [Last Name], [Date of Birth], [Hire Date], RoleId)
		VALUES ('Yurii', 'Sokolyuk', '1985-2-4', '2010-01-09', 1),
		('Mykola', 'Gavrulyk', '1981-7-22', '2008-03-12', 3),
		('Vasulkiv', 'Nadia', '1977-11-29', '2001-01-12', 2),
		('Turanova', 'Nadia', '1975-3-8', '1999-02-05',3 ),
		('Repeta', 'Anna', '1993-6-2', '2017-08-05', 3),
		('Vityuk', 'Lesya', '1993-6-2', '2020-05-05', 4)
		
		--наповнюю таблицю з ролями з школі
		INSERT INTO SchoolRoles (Position)
		VALUES ('Director'),
		('Director deputy'),
		('Teacher'),
		('Technical staff')

		--наповнюю таблицю з категоріями вчителів
		INSERT INTO TeacherCategory(Category, [CategoryDescription])
		Values ('1 кагорія', 'Вчитель вищої категорії'),
		('2 кагорія', 'Вчитель середньої категорії'),
		('3 кагорія', 'Вчитель початкової категорії')

		--присвоюю кетегорію вчителям
		INSERT INTO EmployeeTeacherCategory(EmployeeID, TeacherCategoryId)
		Values (1, 1),
		(2, 2),
		(3, 1),
		(4, 2),
		(5, 3)
		
	
	
		--наповнюю таблицю з інформацією про клас
		INSERT INTO Class (LeadTeacherID, [Class Spesialization], [Spesialization Description], [Class Name])
		VALUES (2, 'Science', 'Природничі науки', '6-A'),
		 (3, 'Techical', 'Точні науки', '8-A')

		--наповнюю таблицю з інформацією про учнів в класі
		INSERT INTO ClassPupil(ClassID, PupilID)
		VALUES (1, 1),
		(1, 2),
		(1, 3),
		(1, 4),
		(1, 5),
		(2, 6),
		(2, 7),
		(2, 8),
		(2, 9),
		(2, 10)

		--наповнюю таблицю предметів
		INSERT INTO Subjects([Subject Name])
		Values ('Фізика'),
		('Хімія'),
		('Біологія'),
		('Інформатика'),
		('Матаматика'),
		('Трудове навчання')

		--наповнюю таблицю з інформацію про предмет і викладача який цей предмет веде
		INSERT INTO SubjectTeacher(SubjectID,TeacherID)
		Values (1, 4),
		(2, 5),
		(3, 5),
		(4, 1),
		(5, 3),
		(6, 2)

		--Наповнюю таблицю з оцінками учнів за предмети
		Insert Into PupilMarks (PupilID, SubjectID, SubjectMark)
		Values
		(1, 3, 9),
		(1, 5, 10),
		(1, 6, 7),
		(2, 4, 7),
		(2, 3, 12),
		(2, 5, 10),
		(3, 6, 10),
		(3, 3, 5),
		(3, 5, 8),
		(3, 6, 11),
		(4, 3, 9),
		(4, 5, null),
		(4, 6, 9),
		(5, 3, 8),
		(5, 5, 6),
		(5, 6, 9),
		(6, 1, 9),
		(6, 2, 8),
		(6, 3, 11),
		(6, 4, 9),
		(7, 1, 4),
		(7, 2, 7),
		(7, 3, 6),
		(7, 4, 5),
		(8, 1, 8),
		(8, 2, 8),
		(8, 3, 9),
		(8, 4, 9),
		(9, 1, 12),
		(9, 2, 11),
		(9, 3, 12),
		(9, 4, 10),
		(10, 1, 11),
		(10, 2, 9),
		(10, 3, 10),
		(10, 4, 9)


		--наповнюю таблицю із зарплатами вчителів
		Insert Into EmployeeSalary (EmployeeID, EmployeeSalary)
		Values (1, 42000),
		(2, 29000),
		(3, 37000),
		(4, 30000),
		(5, 22500)


--В'юшка, яка виводить ім'я та оклад співробітника.
CREATE VIEW EmployeeSalaryInfo AS
SELECT Se.[Last Name],
       SE.[First Name],
       EmSL.EmployeeSalary
FROM SchoolEmployee SE
JOIN EmployeeSalary EmSL ON SE.EmployeeID = EmSL.EmployeeID

--В'юшка, яка показує кількість учнів зі спеціалізацій.
Create view SpesializationCount
as
Select Count(P.PupilID) as PupelCount
From Pupils P
Join ClassPupil PC on P.PupilID = PC.PupilID
Join Class C on C.ClassID = PC.ClassID
Where C.[Class Spesialization] = 'Science'

-- В'юшка, Що показує новеньких учнів (вчаться у школі до трьох місяців).
Create view NewPupel
as
Select *
From Pupils P
Where P.[Date of Join] > DATEADD(mm, -3, GETDATE());

Select *
From NewPupel

--Процедура для додавання учня.
Create proc AddNewPupel
	@FName nvarchar(20),
	@LName nvarchar(20),
	@DateOfBirth Date,
	@DateOfJoin Date
As
Begin
	Insert into Pupils([First Name], [Last Name], [Date of Birth], [Date of Join])
	VALUES( @FName, @LName, @DateOfBirth, @DateOfJoin)
End
Go

Exec AddNewPupel @FName = "Pulupec", @LName = "Andriy", @DateOfBirth = '2012-10-29', @DateOfJoin = '2022-10-20'



--Процедура для додавання персоналу школи.

Create proc AddNewEmployee
@FName nvarchar(30),
@LName nvarchar(30),
@DateOfBirth Date,
@HireDate Date,
@RoleId int
As
Begin
INSERT INTO SchoolEmployee ([First Name], [Last Name], [Date of Birth], [Hire Date], RoleId)
		VALUES (@FName, @LName, @DateOfBirth, @HireDate, @RoleId)
End
Go

-- Процедура для розрахунку кількості учнів на викладача.

Create proc PupelPerTeacherCount
@TLastName nvarchar(20)
As
Begin
	Select  Count(P.PupilID) as 'PupelPerTeacher'
	From Pupils P
	Join ClassPupil CP on CP.PupilID = P.PupilID
	Join Class C on C.ClassID = CP.ClassID
	Join SchoolEmployee SE on C.LeadTeacherID = SE.EmployeeID
	Where SE.[Last Name] like @TLastName
End
Go

-- Функція що повертає кількість учнів у класі.

Create Function PupelInClass (@ClassName nvarchar(50))
returns int
as	
	begin
		return(
		Select Count(P.PupilID)
		From Pupils P
		Join ClassPupil CP on CP.PupilID = P.PupilID
		Join Class C on C.ClassID = CP.ClassID
		Where C.[Class Name] like @ClassName
		)
	end
go

Declare @pupelInClass int
exec @pupelInClass = PupelInClass @ClassName = '8-A';
Print @pupelInClass
go

--Функція що повертає віднощення зарплатні до кількості учнів, яких навчає цей вчитель.
Create Function SalaryToTeachedPupels (@TeacherLastName nvarchar(50))
returns int
as	
begin
	return(
	Select  ESalary.EmployeeSalary/Count(P.PupilID) As SalaryToTeachedPupel
	From EmployeeSalary ESalary
	Join SchoolEmployee SEmp on SEmp.EmployeeID = ESalary.EmployeeID
	Join Class C on C.LeadTeacherID = SEmp.EmployeeID
	Join ClassPupil CP on CP.ClassID = C.ClassID
	Join Pupils P on P.PupilID = CP.PupilID
	Where SEmp.[Last Name] like @TeacherLastName
	Group By ESalary.EmployeeSalary	
	)
	end
go

Declare @SalaryPerPupel int
exec @SalaryPerPupel = SalaryToTeachedPupels @TeacherLastName = 'Gavrulyk';
Print @SalaryPerPupel
go
