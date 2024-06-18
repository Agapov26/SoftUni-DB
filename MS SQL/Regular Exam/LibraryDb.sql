CREATE DATABASE LibraryDb
GO

USE LibraryDb
GO

--01.
CREATE TABLE Genres
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Contacts
(
	Id INT PRIMARY KEY IDENTITY,
	Email NVARCHAR(100),
	PhoneNumber NVARCHAR(20),
	PostAddress NVARCHAR(200),
	Website NVARCHAR(50)
)

CREATE TABLE Authors
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	ContactId INT FOREIGN KEY REFERENCES Contacts(Id) NOT NULL
)

CREATE TABLE Libraries
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	ContactId INT FOREIGN KEY REFERENCES Contacts(Id) NOT NULL
)

CREATE TABLE Books
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	YearPublished INT NOT NULL,
	ISBN NVARCHAR(13) NOT NULL,
	AuthorId INT FOREIGN KEY REFERENCES Authors(Id) NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL
)

CREATE TABLE LibrariesBooks
(
	LibraryId INT FOREIGN KEY REFERENCES Libraries(Id) NOT NULL,
	BookId INT FOREIGN KEY REFERENCES Books(Id) NOT NULL,
	CONSTRAINT PK_LibraryBooks PRIMARY KEY(LibraryId, BookId)
)

--02.
INSERT INTO Contacts
VALUES(NULL, NULL, NULL, NULL),
	(NULL, NULL, NULL, NULL),
	('stephen.king@example.com', '+4445556666',	'15 Fiction Ave, Bangor, ME','www.stephenking.com'),
	('suzanne.collins@example.com',	'+7778889999', '10 Mockingbird Ln, NY, NY', 'www.suzannecollins.com')

INSERT INTO Authors
VALUES('George Orwell', 21),
	('Aldous Huxley', 22),
	('Stephen King', 23),
	('Suzanne Collins',	24)	

INSERT INTO Books
VALUES('1984', 1949, '9780451524935', 16, 2),
	('Animal Farm',	1945, '9780451526342', 16, 2),
	('Brave New World',	1932, '9780060850524', 17, 2),
	('The Doors of Perception',	1954, '9780060850531', 17, 2),
	('The Shining',	1977, '9780307743657', 18, 9),
	('It', 1986, '9781501142970', 18, 9),
	('The Hunger Games', 2008, '9780439023481',	19,	7),
	('Catching Fire', 2009,	'9780439023498', 19, 7),
	('Mockingjay', 2010, '9780439023511', 19, 7)

INSERT INTO LibrariesBooks
VALUES(1, 36),
	(1,	37),
	(2,	38),
	(2,	39),
	(3,	40),
	(3,	41),
	(4,	42),
	(4,	43),
	(5,	44)

--03.
UPDATE Contacts
   SET Website = CONCAT('www.', LOWER(REPLACE([Name], ' ', '')), '.com')
 FROM Contacts
 JOIN Authors ON Contacts.Id =  Authors.ContactId
WHERE Website IS NULL

--04.
SELECT Id FROM Books
WHERE AuthorID = (SELECT AuthorID FROM Authors 
WHERE [Name] = 'Alex Michaelides');

DELETE FROM LibrariesBooks
WHERE BookID IN 
(SELECT BookID FROM Books 
WHERE AuthorID = (SELECT AuthorID FROM Authors 
WHERE [Name] = 'Alex Michaelides'));

DELETE FROM Books
WHERE AuthorID = (SELECT AuthorID FROM Authors 
WHERE [Name] = 'Alex Michaelides');

DELETE FROM Authors
WHERE [Name] = 'Alex Michaelides';

--05.
SELECT Title AS [Book Title], ISBN, YearPublished AS YearReleased
  FROM Books
ORDER BY YearReleased DESC, Title 

--06.
SELECT b.Id, b.Title, b.ISBN, g.[Name]
  FROM Books AS b
  JOIN Genres AS g On b.GenreId = g.Id
WHERE g.[Name] IN ('Biography', 'Historical Fiction')
ORDER BY g.[Name], b.Title 

--07.
SELECT l.[Name], c.Email
  FROM Libraries AS l
  JOIN LibrariesBooks AS lb ON l.Id = lb.LibraryId
  JOIN Books AS b ON lb.BookId =b.Id
  JOIN Genres AS g ON b.GenreId = g.Id
  JOIN Contacts AS c ON c.Id = l.ContactId
WHERE l.Id NOT IN(1)
GROUP BY l.[Name], c.Email

--08.
SELECT TOP (3) b.Title, b.YearPublished AS [Year], g.[Name] AS Genre
  FROM Books AS b
  JOIN Genres AS g ON b.GenreId = g.Id
  WHERE
  YearPublished >2000 AND b.Title LIKE '%a%'
  OR
  YearPublished <1950 AND g.[Name] LIKE '%Fantasy%'
 ORDER BY b.Title, YearPublished DESC

--09.
SELECT a.Name AS Author, c.Email, c.PostAddress AS [Address]
  FROM Authors AS a
  JOIN Contacts AS c ON a.ContactId = c.Id
  WHERE c.PostAddress LIKE '%UK%'
  ORDER BY a.[Name]

--10.
SELECT a.[Name] AS Author, b.Title, l.[Name] AS [Library], cl.PostAddress
  FROM Books AS b
  JOIN Authors AS a ON b.AuthorId = a.Id
  JOIN Contacts AS ca ON a.ContactId = ca.Id
  JOIN LibrariesBooks AS lb ON b.Id = lb.BookId
  JOIN Libraries AS l ON l.Id = lb.LibraryId
  JOIN Contacts AS cl ON cl.Id = l.ContactId
  JOIN Genres AS g ON g.Id = b.GenreId
 WHERE g.[Name] = 'Fiction' AND cl.PostAddress LIKE '%Denver%'
 ORDER BY b.Title

--11.
CREATE FUNCTION udf_AuthorsWithBooks(@name VARCHAR(MAX)) 
RETURNS INT
AS
BEGIN
	DECLARE @result INT
	SELECT @result = COUNT(b.Id)
	  FROM Books AS b
	  JOIN Authors AS a ON b.AuthorId = a.Id
	  WHERE a.[Name] = @name

	  RETURN @result
END

--12.
CREATE PROCEDURE usp_SearchByGenre(@genreName VARCHAR(MAX)) 
AS
	SELECT b.Title, b.YearPublished AS [Year], b.ISBN, a.[Name] AS [Author], g.[Name] AS Genre
	FROM Books as b
	JOIN Genres AS g ON b.GenreId = g.Id
	JOIN Authors AS a ON b.AuthorId = a.Id
	WHERE g.[Name] = @genreName
	ORDER BY b.Title

EXEC usp_SearchByGenre 'Fantasy'