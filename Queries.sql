---1
SELECT MemberName, COUNT(ISBN) AS NumOfBooks FROM Member
JOIN Loan ON Member.MemberID = Loan.MemberID
WHERE DaysDue IS NULL
GROUP BY MemberName
ORDER BY MemberName

---2
SELECT MemberName, BookTitle, Category FROM Loan
INNER JOIN Member ON Loan.MemberID = Member.MemberID
INNER JOIN Book ON Loan.ISBN = Book.ISBN
WHERE Status = 'Active' AND DateBorrowed BETWEEN '2022/01/01' AND '2022/12/31'
ORDER BY Category

---3
SELECT MemberName, State, ContactNumber, BookTitle, DateBorrowed, DueDate, DaysDue, DueAmount FROM Loan
INNER JOIN Member ON Loan.MemberID = Member.MemberID
INNER JOIN Book ON Loan.ISBN = Book.ISBN
WHERE DaysDue > 0
ORDER BY State, MONTH(DateBorrowed)

---4
WITH RankedBooks AS (
    SELECT b.BookTitle, b.Description, m.State, l.DateBorrowed, b.Category,
    ROW_NUMBER() OVER (PARTITION BY m.State ORDER BY COUNT(l.ISBN) DESC) AS RowNum
    FROM Loan l
    INNER JOIN Member m ON l.MemberID = m.MemberID
    INNER JOIN Book b ON l.ISBN = b.ISBN
    GROUP BY b.BookTitle, b.Description, m.State, l.DateBorrowed, b.Category
	)
SELECT BookTitle, Description, Category, State, DateBorrowed
FROM RankedBooks
WHERE RowNum = 3
ORDER BY Category

---5
WITH MonthlyLoanCounts AS (
SELECT b.BookTitle, DATEPART(MONTH, l.DateBorrowed) AS LoanMonth, COUNT(l.ISBN) AS LoanCount FROM Loan l
INNER JOIN Book b ON l.ISBN = b.ISBN
WHERE YEAR(l.DateBorrowed) = 2023
GROUP BY b.BookTitle,
DATEPART(MONTH, l.DateBorrowed)
),

TotalBooks AS (
SELECT BookTitle, SUM(LoanCount) AS TotalLoanCount FROM MonthlyLoanCounts
GROUP BY BookTitle
)

SELECT m.BookTitle, m.LoanMonth, CAST((CAST(m.LoanCount AS DECIMAL) / t.TotalLoanCount) * 100 AS DECIMAL(10, 2)) AS PercentageOnLoan
FROM MonthlyLoanCounts m
INNER JOIN TotalBooks t ON m.BookTitle = t.BookTitle
ORDER BY m.LoanMonth

---6
SELECT Gender, State, COUNT(*) AS Total FROM Member
JOIN Reserve ON Member.MemberID = Reserve.MemberID
WHERE DateReserved IS NOT NULL
GROUP BY Gender, State
ORDER BY Gender

---7
SELECT TOP 1 PublisherName, COUNT(Category) AS TotalYellowBooks FROM Publisher
JOIN Book ON Publisher.PublisherID = Book.PublisherID
WHERE Category ='Yellow'
GROUP BY PublisherName
ORDER BY TotalYellowBooks ASC

---8
SELECT Author,Category,COUNT(*) AS NumOfBooks FROM Book
GROUP BY Author,Category
ORDER BY Category

---9
SELECT MemberName, ContactNumber FROM Loan
INNER JOIN Member ON Loan.MemberID = Member.MemberID
INNER JOIN Book ON Loan.ISBN = Book.ISBN
WHERE Genre = 'Fantasy'
GROUP BY MemberName, ContactNumber

---10
SELECT PublisherName, PublisherAddress FROM Publisher
JOIN Book ON Publisher.PublisherID = Book.PublisherID
GROUP BY PublisherName, PublisherAddress
HAVING COUNT(ISBN) > 3
