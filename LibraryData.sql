CREATE DATABASE ELibrary1

CREATE TABLE Member (
MemberID nvarchar(50) PRIMARY KEY,
MemberName nvarchar(50),
Gender nvarchar(50),
State nvarchar(50),
ContactNumber nvarchar(50),
Status nvarchar(50)
)


CREATE TABLE Publisher (
PublisherID nvarchar(50) PRIMARY KEY,
PublisherName nvarchar(50),
PublisherAddress nvarchar(50),
)


CREATE TABLE Book (
ISBN nvarchar(50) PRIMARY KEY,
BookTitle nvarchar(50),
Author nvarchar(50),
Genre nvarchar(50),
Category nvarchar(50),
Description nvarchar(200),
PublisherID nvarchar(50) FOREIGN KEY REFERENCES Publisher(PublisherID)
)


CREATE TABLE Copies(
CopyID float(2) PRIMARY KEY,
Description nvarchar(50)
)


CREATE TABLE CopyInfo(
ISBN nvarchar(50) FOREIGN KEY REFERENCES Book(ISBN),
CopyID float(2) FOREIGN KEY REFERENCES Copies(CopyID),
BookCopy nvarchar(50)
)


CREATE TABLE Loan (
MemberID nvarchar(50) FOREIGN KEY REFERENCES Member(MemberID),
ISBN nvarchar(50) FOREIGN KEY REFERENCES Book(ISBN),
DateBorrowed date,
DueDate date,
ReturnDate date,
DaysDue float(50),
DailyFine decimal(10,2),
DueAmount decimal(10,2)
)


CREATE TABLE Reserve (
MemberID nvarchar(50) FOREIGN KEY REFERENCES Member(MemberID),
ISBN nvarchar(50) FOREIGN KEY REFERENCES Book(ISBN),
DateReserved date,
)


INSERT INTO Member (MemberID,MemberName,Gender,State,ContactNumber,Status)
VALUES ('M001','Kylian Mbappe','Male','Selangor','0126120912','Active'),
('M002','Pearly Tan','Female','Penang','0164536273','Active'),
('M003','Mo Salah','Male','Johor','0198269362','Inactive'),
('M004','Aishwarya Rai','Female','Selangor','0127168271','Active'),
('M005','Erling Haaland','Male','Johor','0192957334','Active'),
('M006','Kamala Harris','Female','Penang','0163121671','Inactive')

SELECT * FROM Member

INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress)
VALUES ('P501','Champions','Madeira'),
('P502','RedBlue','New York'),
('P503','Wonders','Brighton')

SELECT * FROM Publisher

INSERT INTO Book (ISBN,BookTitle,Author,Genre,Category,Description,PublisherID)
VALUES ('B101','The GOAT','Cristiano','Biography','Yellow','Life story of a Portugese football legend who is widely known as the best.','P501'),
('B102','Breaking Bad','Walter','Mystery','Yellow','A school chemistry teacher skips the matrix to sell drugs.','P502'),
('B103','Harry Potter','Walter','Fantasy','Yellow','Three students band together to go through the hurdles of Hogwarts.','P503'),
('B104','Black Panther','Chaeryoung','Fantasy','Yellow','The greatest warrior of Wakanda defends the throne from his enemies.','P502'),
('B105','Conquering Europe','Cristiano','Action','Green','Five-time European champion Ronaldo shares how he achieved this number.','P502'),
('B106','Python','Chaeryoung','Education','Green','Simple guide on how to use Python for newcomers.','P502'),
('B107','World Cup','Messi','Biography','Yellow','The blue and white army finally win again at last in Qatar.','P501'),
('B108','My Journal','Walter','Journal','Red','A glimpse through of the everyday life of a man.','P503'),
('B109','Business Management: FYP','Chaeryoung','Student Project','Red','Final year project for business degree.','P501')

SELECT * FROM Book

INSERT INTO Copies (CopyID, Description)
VALUES (1,'First copy'),
(2,'Second copy'),
(3,'Third copy')

SELECT * FROM Copies

INSERT INTO CopyInfo(ISBN,CopyID,BookCopy)
VALUES ('B101',1,'The GOAT - Copy 1'),
('B101',2,'The GOAT - Copy 2'),
('B101',3,'The GOAT - Copy 3'),
('B102',1,'Breaking Bad - Copy 1'),
('B102',2,'Breaking Bad - Copy 2'),
('B103',1,'Harry Potter - Copy 1'),
('B103',2,'Harry Potter - Copy 2'),
('B103',3,'Harry Potter - Copy 3'),
('B104',1,'Black Panther - Copy 1'),
('B104',2,'Black Panther - Copy 2'),
('B105',1,'Conquering Europe - Copy 1'),
('B105',2,'Conquering Europe - Copy 2'),
('B106',1,'Python - Copy 1'),
('B106',2,'Python - Copy 2'),
('B107',1,'World Cup - Copy 1'),
('B107',2,'World Cup - Copy 2'),
('B107',3,'World Cup - Copy 3')

SELECT * FROM CopyInfo

INSERT INTO Loan (MemberID,ISBN,DateBorrowed,DueDate,ReturnDate,DaysDue,DailyFine,DueAmount)
VALUES ('M001','B101','20 October 2022','27 October 2022','27 October 2022',0,0.50,0.00),
('M001','B105','8 June 2023','22 June 2023','26 June 2023',4,1.00,4.00),
('M001','B106','16 July 2023','30 July 2023','30 July 2023',0,1.00,0.00),
('M002','B105','15 November 2022','29 November 2022','29 November 2022',0,1.00,0.00),
('M002','B106','20 July 2023','3 August 2023','3 August 2023',0,1.00,0.00),
('M002','B107','25 August 2023','1 September 2023',NULL,NULL,0.50,NULL),
('M003','B103','2 June 2023','9 June 2023','9 June 2023',0,0.50,0.00),
('M004','B101','19 September 2022','26 September 2022','27 September 2022',1,0.50,0.50),
('M004','B102','7 December 2022','14 December 2022','14 December 2022',0,0.50,0.00),
('M004','B104','14 June 2023','21 June 2023','21 June 2023',0,0.50,0.00),
('M005','B103','30 July 2023','6 August 2023','9 August 2023',3,0.50,1.50),
('M005','B102','26 August 2023','2 September 2023',NULL,NULL,0.50,NULL),
('M005','B104','28 August 2023','4 September 2023',NULL,NULL,0.50,NULL),
('M006','B107','7 August 2023','14 August 2023','16 August 2023',2,0.50,1.00)

SELECT * FROM Loan

INSERT INTO Reserve (MemberID,ISBN,DateReserved)
VALUES ('M001','B107','22 August 2023'), 
('M002','B101','23 August 2023'),
('M002','B103','23 August 2023'),
('M004','B102','25 August 2023'),
('M005','B105','27 August 2023')

SELECT * FROM Reserve
