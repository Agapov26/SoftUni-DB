USE SoftUni
GO

--13.
SELECT DepartmentID, SUM(Salary) AS TotalSalary
  FROM Employees
GROUP BY DepartmentID

--14.
SELECT DepartmentID, MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN (2, 5, 7) AND
HireDate > '01-01-2000'
GROUP BY DepartmentID

--15.
SELECT * INTO AvgEmployees
FROM Employees
WHERE Salary > 30000

DELETE 
FROM AvgEmployees
WHERE ManagerID = 42

UPDATE AvgEmployees
SET Salary = Salary + 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary)
FROM AvgEmployees
GROUP BY DepartmentID

--16.
SELECT DepartmentID, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING Max(Salary) NOT BETWEEN 30000 AND 70000

--17.
SELECT COUNT(Salary) AS [Count]
  FROM Employees
WHERE ManagerID IS NULL

--18.
SELECT DepartmentID, ThirdHighestRanking
  FROM
	  (SELECT 
		DepartmentID, 
		MAX(Salary) AS ThirdHighestRanking,
		DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRanking
	FROM Employees
	GROUP BY DepartmentID, Salary) AS SubQuery
WHERE SubQuery.SalaryRanking = 3