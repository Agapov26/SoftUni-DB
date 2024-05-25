USE SoftUni
GO

--01.
SELECT FirstName, LastName
  FROM Employees
 WHERE FirstName LIKE 'Sa%'


--02.
SELECT FirstName, LastName
 FROM Employees
 WHERE LastName LIKE '%ei%'

--03.
SELECT FirstName
 FROM Employees
 WHERE DepartmentID IN (3, 10) AND
	   DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

--04.
SELECT FirstName, LastName
  FROM Employees
 WHERE JobTitle NOT LIKE '%engineer%'

--05.
SELECT [Name]
  FROM Towns
WHERE LEN([NAME]) BETWEEN 5 AND 6
ORDER BY [NAME]

--06.
SELECT TownID, [Name]
  FROM Towns
WHERE ([NAME]) LIKE '[mkbe]%'
ORDER BY [NAME]

--07.
SELECT TownID, [Name]
  FROM Towns
WHERE ([NAME]) NOT LIKE '[rbd]%'
ORDER BY [NAME]

--08.
CREATE VIEW V_EmployeesHiredAfter2000 AS
     SELECT FirstName, LastName
       FROM Employees
      WHERE DATEPART(YEAR, HireDate) > 2000

--09.
SELECT FirstName, LastName
  FROM Employees
 WHERE LEN(LastName) = 5

--10.
SELECT EmployeeID, FirstName, LastName, Salary,
	DENSE_RANK() OVER
	(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
 FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--11.
WITH CTE_RankedEmployees AS
(
	SELECT EmployeeID, FirstName, LastName, Salary,
		DENSE_RANK() OVER
		(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000 
)

SELECT * 
FROM CTE_RankedEmployees 
WHERE [Rank] = 2
ORDER BY Salary DESC
