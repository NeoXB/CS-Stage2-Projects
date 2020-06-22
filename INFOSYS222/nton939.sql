--Full name: Nicholas Tony
--AUID: 124598632
--upi: nton939

--Q1 - find the customers
SELECT CustomerId AS [Customer ID], C.FirstName ||' '|| C.LastName AS [Full Name], C.Email AS [Email Address]
FROM Customer C, Employee E
WHERE C.City = E.City
AND E.ReportsTo IS NULL;

--Q2 - track names and composers
SELECT name, ifnull(composer, 'Unknown') AS [Composer]
FROM Track
WHERE name like 'you %'
AND NOT (name like 'you know i''m %' OR name like '%got%');

--Q3 - albums no one likes
SELECT AlbumId AS [Album ID], Title AS [Album Title], AR.name AS [Artist Name]
FROM Album AL, Artist AR
WHERE AL.ArtistId = AR.ArtistId
AND AlbumId IN (SELECT AlbumId AS [Album ID]
				FROM Track T LEFT OUTER JOIN InvoiceLine I
				ON T.TrackId = I.TrackId
				GROUP BY AlbumId
				HAVING group_concat(InvoiceId) IS NULL);

--Q4 - tv show videos
SELECT TrackId AS [Track Id], T.name AS [Track Name], G.name AS [Genre Name]
FROM Track T, Genre G
WHERE T.GenreId = G.GenreId
AND G.GenreId = (SELECT GenreId
				FROM Genre
				WHERE name like 'tv shows')
AND Milliseconds <= (SELECT avg(Milliseconds)
					FROM Track T, MediaType M
					WHERE T.MediaTypeId = (SELECT MediaTypeId
											FROM MediaType
											WHERE name like '%video file'));
						
--Q5 - cities where reggae is not popular
SELECT BillingCity AS [City], count(A.[TrackInvoice]) AS [Sales]
FROM Invoice I, (SELECT T.TrackId, InvoiceId AS [TrackInvoice]
				FROM Track T, InvoiceLine IL
				WHERE T.TrackId = IL.TrackId
				AND T.GenreId = (SELECT GenreId
								FROM Genre
								WHERE name like 'reggae')) A
WHERE A.[TrackInvoice] = I.InvoiceId
GROUP BY BillingCity
ORDER BY [Sales]
LIMIT 2;

--Q6 - lucky draw for a customer
SELECT FirstName ||' '|| LastName AS [Full Name], CustomerId AS [Customer Id], Email
FROM Customer
WHERE lower(Country) IN ('france', 'germany', 'united kingdom') 
ORDER BY random()
LIMIT 1;

--Q7.1 - creating the saleshistory table
CREATE TABLE [SalesHistory]
(
	[EmployeeID] INTEGER NOT NULL,
	[EmployeeName] TEXT NOT NULL,
	[InvoiceYear] DATE NOT NULL,
	[NoOfAccounts] INTEGER,
	[TotalRevenue] NUMERIC,
		CONSTRAINT SalesHistory_pk PRIMARY KEY([EmployeeID], [InvoiceYear]),
		CONSTRAINT SalesHistory_fk FOREIGN KEY([EmployeeID]) REFERENCES Employee([EmployeeID])
);

--Q7.2 - populating the saleshistory table
INSERT INTO [SalesHistory]
SELECT EmployeeId, E.FirstName ||' '|| E.LastName AS [EmployeeName], strftime('%Y', InvoiceDate) AS [Year], 
count(DISTINCT I.CustomerId), sum(Total)
FROM Employee E, Invoice I, Customer C
WHERE EmployeeId IN (SELECT DISTINCT SupportRepId 
					FROM Customer)
AND C.CustomerId = I.CustomerId
AND C.SupportRepId = EmployeeId
GROUP BY EmployeeId, [Year];

--Q8 - employee status and employment duration
SELECT EmployeeId AS [EmployeeID], FirstName AS [Employee Name], CASE
WHEN date('now', 'localtime') - date(HireDate) >= 18 
THEN 'Senior Employee'
WHEN date('now', 'localtime') - date(HireDate) < 18 AND date('now', 'localtime') - date(HireDate) >= 17 
THEN 'Long Term Employee'
ELSE 'Recent Employee' END AS [Status], 
CAST(((julianday('now', 'localtime') - julianday(HireDate)) / 365.25) AS INT) ||' Year(s) '|| 
CAST(((julianday('now', 'localtime') - julianday(HireDate)) % 365.25 / 30.44) AS INT) ||' Month(s)' 
AS [Duration]
FROM Employee
ORDER BY ((julianday('now', 'localtime') - julianday(HireDate)) / 365.25) DESC;

--Q9 - track description
SELECT upper(T.name) ||' is a '|| (Milliseconds / 1000) ||' seconds long track in the album '|| upper(Title) 
||' of '|| AR.name ||' composed by '|| ifnull(Composer, 'an unknown composer') ||'. It is available as a '|| 
M.name ||' for $'|| UnitPrice ||', and it can be found in the following playlists: '|| group_concat(P.name)
AS [Track Description]
FROM Album AL, Artist AR, MediaType M, Playlist P, PlaylistTrack PT, Track T
WHERE T.AlbumId = AL.AlbumId
AND AL.ArtistId = AR.ArtistId
AND T.MediaTypeId = M.MediaTypeId
AND T.TrackId = PT.TrackId
AND PT.PlaylistId = P.PlaylistId
GROUP BY T.TrackId
ORDER BY random()
LIMIT 1;

--Q10 - manager and subordinates
SELECT A.FirstName ||' '|| A.LastName AS [Reports To], B.FirstName ||' '|| B.LastName AS [Employee]
FROM Employee A, Employee B
WHERE A.EmployeeId = B.ReportsTo
AND (julianday(A.HireDate) - julianday(A.BirthDate)) / 365.25 = 
	(SELECT (julianday(HireDate) - julianday(BirthDate)) / 365.25 AS [Age]
	FROM Employee
	WHERE EmployeeId IN (SELECT DISTINCT ReportsTo 
						FROM Employee)
	ORDER BY [Age]
	LIMIT 1);
