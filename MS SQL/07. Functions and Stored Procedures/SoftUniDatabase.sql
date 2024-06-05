USE SoftUni
GO

--01.
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS	
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
END

--02.
CREATE PROC usp_GetEmployeesSalaryAboveNumber @salary DECIMAL(18, 4)
AS	
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @salary
END

--03.
CREATE PROC usp_GetTownsStartingWith @string VARCHAR(MAX)
AS	
BEGIN
	SELECT [Name] AS TOWN
	FROM Towns
	WHERE [Name] LIKE CONCAT(@string, '%')
END

--04.
CREATE PROCEDURE usp_GetEmployeesFromTow @townName VARCHAR(MAX)
AS	
BEGIN
	SELECT FirstName, LastName
	FROM Employees AS e
	JOIN Addresses AS a ON a.AddressID = e.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[Name] = @townName
END

--05.
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)
	IF (@Salary < 30000)
	SET @salaryLevel =	'Low'
	ELSE IF(@Salary <= 50000)
	SET @salaryLevel = 'Average'
	ELSE
	SET @salaryLevel = 'High'
	RETURN @salaryLevel
END

--06.
CREATE PROCEDURE usp_EmployeesBySalaryLevel @salaryLevel VARCHAR(10)
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel
END

--07.
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @wordLength INT = LEN(@word)
	DECLARE @Iterator INT = 1

	WHILE(@Iterator <= @WordLength)
		BEGIN
			IF(CHARINDEX(SUBSTRING(@word,@Iterator,1), @setOFLetters) = 0)
				RETURN 0
			SET @Iterator +=1
		END
	RETURN 1
END
