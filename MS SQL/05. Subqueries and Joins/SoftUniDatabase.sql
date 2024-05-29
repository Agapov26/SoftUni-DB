USE SoftUni
GO

--01.
SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, AddressText
FROM Employees AS e
JOIN Addresses AS a ON a.AddressID =  e.AddressID
ORDER BY  AddressID

--02.
SELECT TOP(50) e.FirstName, e.LastName, t.[Name] , a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY FirstName, LastName

--03.
SELECT EmployeeID, FirstName, LastName, [Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE [Name] = 'Sales'
ORDER BY EmployeeID

--04.
SELECT TOP(5) EmployeeID, FirstName, Salary, [Name]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE Salary > 15000
ORDER BY e.DepartmentID

--05.
SELECT TOP(3) EmployeeID, FirstName
FROM Employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM EmployeesProjects)
ORDER BY EmployeeID

--06. 
SELECT FirstName, LastName, HireDate, [Name]
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE [Name] IN ('Sales', 'Finance')
AND HireDate > '1.1.1999'
ORDER BY HireDate

--07.
SELECT TOP(5) e.EmployeeID, FirstName, [Name]
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE StartDate  > '2002-8-13' AND
EndDate IS NULL
ORDER BY e.EmployeeID

--08.
SELECT e.EmployeeID, FirstName, [Project Name] =
CASE 
	WHEN DATEPART(YEAR, StartDate) > 2004 THEN NULL
	ELSE [Name]
END
FROM EmployeesProjects AS ep
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
JOIN Employees AS e ON e.EmployeeID = ep.EmployeeID
WHERE e.EmployeeID = 24

--09.
SELECT e.EmployeeID, e.FirstName, mgr.EmployeeID, mgr.FirstName
FROM Employees AS e
LEFT JOIN Employees AS mgr ON e.ManagerID = mgr.EmployeeID
WHERE e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID

--10.
SELECT TOP(50) 
e.EmployeeID, 
CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName, 
CONCAT_WS(' ', mgr.FirstName, mgr.LastName) AS ManagerName,
[Name]
FROM Employees AS e
LEFT JOIN Employees AS mgr ON e.ManagerID = mgr.EmployeeID
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID

--11.
SELECT TOP(1) AVG(Salary) MinAvarageSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY MinAvarageSalary