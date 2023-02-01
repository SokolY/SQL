CREATE DATABASE Hospital

CREATE TABLE Buildings(
	Id int not null Primary key IDENTITY(1,1)
	,Adress nvarchar(200) not null 
	,BedCount int not null
	)

CREATE TABLE Patients(
	Id int not null Primary key identity(1,1)
	,FirstName nvarchar(50) not null
	,LastName nvarchar(50) not null
	,Desease nvarchar(50) 
	,BuildingId int not null  references Buildings(Id)
	)

CREATE TABLE Doctors(
	Id int not null Primary key identity(1,1)
	,FirstName nvarchar(50) not null
	,LastName nvarchar(50) not null
	,Grade nchar(1) CHECK (Grade BETWEEN 'A' and 'D')
	)

CREATE TABLE Doctors_Patients(
	DoctorId int  references Doctors(Id)
	,PatientID int references Patients(Id)
	,Primary key (DoctorId,PatientId)
	)

CREATE TABLE DoctorFinances(
	Id int not null primary key references Doctors (ID)
	,Salary money not null default 0)

INSERT INTO Buildings (Adress, BedCount)
VALUES ('Stusa, 45', 13)

INsert into Patients (FirstName, LastName, Desease, buildingId)
values ('first', 'firstov','caugh',1 )

insert into Doctors(FirstName, LastName, Grade)
values ('Docfirst', 'Docfirstov','C')

Insert into DoctorFinances (Id)
values(1)

Insert into Doctors_Patients (DoctorId, PatientID)
values (1,1)

