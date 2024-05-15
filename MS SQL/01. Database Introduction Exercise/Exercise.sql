-- CTRL + SHIFT + R => Refresh Editor
-- CTRL + K, CTRL + C => Comment selection

--01. Create Database
CREATE DATABASE Minions
USE Minions
GO

--02. Create Tables
CREATE TABLE Minions
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Age INT
)
CREATE TABLE Towns
(
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50)
)

--03. Alter Minions Table
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

--04. Insert Records in Both Table
INSERT INTO Towns
VALUES(1, 'Sofia'),
	  (2, 'Plovdiv'),
	  (3, 'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES (1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)

--05. Truncate Table Minions
TRUNCATE TABLE Minions

--06. Drop All Tables
DROP TABLE Towns
DROP TABLE Minions

--07.Create Table People
CREATE TABLE People 
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200),
	Picture VARBINARY(MAX),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
		CHECK(Gender in('m', 'f')),
	Birthdate DATETIME2 NOT NULL,
	Biography VARCHAR(MAX)
)

INSERT INTO People ([Name], Gender, Birthdate)
Values ('Petar', 'm', '2006-01-23'),
	   ('Patrona', 'm', '2006-05-26'),
	   ('Ceco', 'f', '2006-10-22'),
	   ('Stoikov', 'f', '2006-08-31'),
	   ('Ceko', 'm', '2006-08-01')

--08. Create Table Users
CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,	
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATETIME2,
	IsDeleted BIT
)

INSERT INTO Users (Username, [Password])
Values ('Partona', 'Patrona33'),
	   ('Petar', 'Legendata'),
	   ('Ceco', 'Slabsumnafifa'),
	   ('Mitko', 'Shampiona100'),
	   ('Ceko', 'MiroVersace')

--09. Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK_USERS_2626

ALTER TABLE Users
ADD CONSTANT PK_UsersTable PRIMARY KEY (Id, Username)

--10. Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CHK_Password
	CHECK(LEN(Password) >= 5)

INSERT INTO Users (Username, [Password])
		Values ('Partona', '33')