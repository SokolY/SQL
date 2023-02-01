


	CREATE DATABASE Academy
		

	CREATE TABLE Academy(
	StudentName nvarchar(50),
	CityOfBirth nvarchar(50),
	[Grant] money,
	[Group] nvarchar(50),
	EntryDate date,
	SubjectName nvarchar(50),
	TeacherName nvarchar (50),
	RoomNumber int,
	PCAvailable bit	
	)

	INSERT INTO [dbo].[Academy]
           (StudentName,CityOfBirth,[Grant],[Group],EntryDate,SubjectName,TeacherName,RoomNumber,PCAvailable)
     VALUES
           ('Seckond Secondko','Kyiv',1000,'34ER18','2000-08-20','Mathematics','Ivan Sirko',101,1),
		   ('Taras Stepanenko','Kharkiv',3000,'34GH07','2000-07-20','Chemistry','Bill White',202,0),
		   ('First Firstov','Kharkiv',1000,'34ER18','2000-07-15','Biology','Bill White',101,1),
		   ('Seckond Secondko','Kyiv',1000,'34ER18','2000-08-20','Biology','Bill White',101,1),
		   ('Petro Petrnko','Lviv',2000,'34ER18','2000-08-10','Biology','Bill White',101,1),
		   ('Taras Stepanenko','Kharkiv',3000,'34GH07','2000-07-20','Mathematics','Ivan Sirko',202,0),
		   ('Dmytro Dmytrenko','Dnipro',2000,'34GH07','2000-06-10','Chemistry','Bill White',202,0),
		   ('Mark Novich','Kyiv',3000,'34GH07','2000-06-09','Chemistry','Bill White',202,0),
		   ('First Firstov','Kharkiv',1000,'34ER18','2000-07-15','Mathematics','Ivan Sirko',101,1),
		   ('Dmytro Dmytrenko','Dnipro',2000,'34GH07','2000-06-10','Mathematics','Ivan Sirko',202,0),
		   ('Mark Novich','Kyiv',3000,'34GH07','2000-06-09','Mathematics','Ivan Sirko',202,0),
		   ('Petro Petrnko','Lviv',2000,'34ER18','2000-08-10','Mathematics','Ivan Sirko',101,1)

Select * from Academy
