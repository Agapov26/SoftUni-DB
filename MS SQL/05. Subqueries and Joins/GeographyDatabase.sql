USE Geography
GO

--12.
SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode 
JOIN Mountains AS m ON mc.MountainId = m.Id 
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE c.CountryCode = 'BG' AND p.Elevation >= 2835
ORDER BY p.Elevation DESC 

--13.
SELECT c.CountryCode, COUNT(mc.MountainId) AS MountainRanges
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE c.CountryName IN ('United States', 'Russia', 'Bulgaria')
GROUP BY c.CountryCode

--14.
SELECT TOP (5) c.CountryName, r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName