USE Bank
Go

--09.
CREATE PROC usp_GetHoldersFullName
AS
BEGIN
	SELECT CONCAT_WS(' ', FirstName, LastName) AS [Full Name]
	  FROM AccountHolders
END

--10.
CREATE PROC usp_GetHoldersWithBalanceHigherThan (@amount money)
AS
BEGIN
	SELECT FirstName, LastName
	FROM  AccountHolders AS ah
	JOIN Accounts AS a ON ah.Id = a.AccountHolderId
	GROUP BY FirstName,LastName
	HAVING SUM(a.Balance) > @amount
	ORDER BY FirstName, LastName
END

--11.
CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(10,4), @yearlyInterestRate FLOAT, @years INT)
RETURNS DECIMAL(10,4)
AS
BEGIN
	RETURN @sum * (POWER((1+ @yearlyInterestRate),@years))
END

--12.
CREATE PROCEDURE usp_CalculateFutureValueForAccount(@accountID INT, @interestRate FLOAT)
AS
BEGIN
	DECLARE @term INT = 5

	SELECT 
	a.Id AS [Account Id],
	FirstName,
	LastName,
	Balance AS [Current Balacne],
	dbo.ufn_CalculateFutureValue(Balance,@interestRate,@term) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON ah.Id = a.AccountHolderId
	WHERE a.Id = @accountID
END