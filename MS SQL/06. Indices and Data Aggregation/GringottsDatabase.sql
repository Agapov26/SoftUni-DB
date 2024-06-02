USE Gringotts
GO

--01.
SELECT COUNT(*) 
  FROM WizzardDeposits

--02.
SELECT MAX(MagicWandSize) 
   AS LongestMagicWand
 FROM WizzardDeposits

--03.
SELECT DepositGroup, MAX(MagicWandSize) 
   AS LongestMagicWand
 FROM WizzardDeposits
GROUP BY DepositGroup

--04.
SELECT TOP(2) DepositGroup
 FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--05.
SELECT DepositGroup, SUM(DepositAmount)
   AS DepositAmounts
 FROM WizzardDeposits
GROUP BY DepositGroup

--06.
SELECT DepositGroup, SUM(DepositAmount)
   AS DepositAmounts
 FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--07.
SELECT DepositGroup, SUM(DepositAmount)
   AS TotalSum
 FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family' 
GROUP BY DepositGroup 
HAVING SUM(DepositAmount) < 15000 
ORDER BY TotalSum DESC

--08.
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)
  FROM WizzardDeposits
GROUP BY MagicWandCreator, DepositGroup
ORDER BY MagicWandCreator, DepositGroup

--09.
SELECT AgeCategory, COUNT(*) AS WizzardCount
FROM 
(
	SELECT 
		CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN Age > 60 THEN '[61+]'  
		END AS AgeCategory
			FROM WizzardDeposits 
) AS NestedQuery
GROUP BY
	AgeCategory

--10.
SELECT FirstLetter FROM 
(
	SELECT 
		 SUBSTRING(FirstName, 1, 1) AS FirstLetter
	FROM WizzardDeposits
	WHERE 
		DepositGroup = 'Troll Chest'
) AS SubQuery

GROUP BY FirstLetter

--11.
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS DepositInterest
  FROM WizzardDeposits
WHERE DepositStartDate > '01-01-1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--12.
SELECT SUM([Difference]) AS SumDifference
FROM
(
SELECT 
	FirstName AS HostWizzard,
	DepositAmount AS HostWizzardDeposit,
	LEAD(FirstName) OVER (ORDER BY Id) AS GuestWizzard,
	LEAD([DepositAmount]) OVER (ORDER BY Id) AS GuestWizzardDeposit,
	(DepositAmount - LEAD([DepositAmount]) OVER (ORDER BY Id)) AS [Difference]
FROM WizzardDeposits
) AS SubQuery