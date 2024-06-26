CREATE DATABASE LibraryManagement;
GO
USE LibraryManagement
GO

--Tao bao Member
CREATE TABLE Members(
memberID INT IDENTITY(1,1) PRIMARY KEY,
fullName NVARCHAR(255) NOT NULL,
email VARCHAR(255) null,
phone VARCHAR(20) NOT NULL,
[address] NVARCHAR(255) NOT NULL,
CONSTRAINT chk_phone1 CHECK (phone LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT chk_email1 CHECK (email LIKE '%_@__%.__%')
);


--Tao bang Staff
CREATE TABLE Staffs(
staffID INT IDENTITY(1,1) PRIMARY KEY ,
fullName NVARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
phone VARCHAR(20) NOT NULL,
[address] NVARCHAR(255) NOT NULL,
salary DECIMAL(18,2) NOT NULL,
CONSTRAINT chk_phone2 CHECK (phone LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT chk_email2 CHECK (email LIKE '%_@__%.__%'),
CONSTRAINT chk_salary CHECK(salary>0)
);

--- Tao bang Categories
CREATE TABLE Categories(
categoryID INT PRIMARY KEY IDENTITY(1,1),
categoryName NVARCHAR(255) NOT NULL
)

--- Tao bang Author
CREATE TABLE Authors(
authorID INT PRIMARY KEY IDENTITY(1,1),
[name] NVARCHAR(255) NOT NULL,
biography NVARCHAR(MAX) NULL
);

--Tao bang Books
CREATE TABLE Books(
bookID INT PRIMARY KEY IDENTITY(1,1),
title NVARCHAR(255) NOT NULL,
publishedYear INT NOT NULL,
quantity INT NOT NULL,
CONSTRAINT chk_publishYear CHECK (publishedYear>=2000 AND publishedYear<=YEAR(GETDATE())),
CONSTRAINT chk_quantity CHECK(quantity>=0)
);

--Tao bang BorrowRecords
CREATE TABLE BorrowRecords(
borrowID INT PRIMARY KEY IDENTITY(1,1),
bookID INT NOT NULL,
memberID INT NOT NULL,
staffID INT NOT NULL,
borrowDate DATE NOT NULL,
allowedDays INT NOT NULL,
FOREIGN KEY (bookID) REFERENCES dbo.Books(bookID),
FOREIGN KEY(memberID) REFERENCES dbo.Members(memberID),
FOREIGN KEY (staffID) REFERENCES dbo.Staffs(staffID),
CONSTRAINT chk_borrowDate CHECK (borrowDate<=GETDATE()),
CONSTRAINT chk_allowedDays CHECK(allowedDays>=7)
)

--Tao bang Return Record
CREATE TABLE ReturnRecords(
returnID INT PRIMARY KEY IDENTITY(1,1),
staffID INT NOT NULL FOREIGN KEY REFERENCES dbo.Staffs(StaffID),
returnDate DATE NOT NULL
)

--Tao bang cho quan he Borrow_Return Detail
CREATE TABLE Borrow_ReturnDetail(
borrowID INT,
returnID INT,
fineAmount DECIMAL(18,2) DEFAULT 0 NULL,
note NVARCHAR(MAX) NULL,
PRIMARY KEY(borrowID,returnID),
FOREIGN KEY (borrowID) REFERENCES dbo.BorrowRecords(borrowID),
FOREIGN KEY (returnID) REFERENCES dbo.ReturnRecords(returnID),
CONSTRAINT chk_fineAmount CHECK (fineAmount>=0) 
);

-- Tao bang cho quan he Book_Categories Detail

CREATE TABLE Book_CategoriesDetail(
bookID INT,
categoryID INT,
history NVARCHAR(MAX) NULL,
PRIMARY KEY (bookID,categoryID),
FOREIGN KEY (bookID) REFERENCES dbo.Books(bookID),
FOREIGN KEY (categoryID) REFERENCES dbo.Categories(categoryID)
)

-- Tao bang cho quan he Book_Author Detail

CREATE TABLE Book_AuthorDetail(
bookID INT,
authorID INT,
note NVARCHAR(MAX) NULL,
PRIMARY KEY (bookID,authorID),
FOREIGN KEY (bookID) REFERENCES dbo.Books(bookID),
FOREIGN KEY (authorID) REFERENCES dbo.Authors(AuthorID)
)


INSERT INTO Members (fullName, email, phone, [address])
VALUES 
('Alice Johnson', 'alice@example.com', '0123456789', '123 Broadway, City'),
('Bob Smith', 'bob@example.com', '0987654321', '456 Oak St, Town'),
('Charlie Brown', 'charlie@example.com', '0123456789', '789 Elm St, Village'),
('Diana Miller', 'diana@example.com', '0987654321', '1010 Pine St, Hamlet'),
('Ella Davis', 'ella@example.com', '0123456789', '555 Maple St, Countryside'),
('Frank Wilson', 'frank@example.com', '0987654321', '777 Cedar St, Suburb'),
('Grace Martinez', 'grace@example.com', '0123456789', '888 Pine St, Coastal'),
('Henry Thompson', 'henry@example.com', '0987654321', '999 Elm St, Mountains'),
('Ivy Lee', 'ivy@example.com', '0123456789', '333 Birch St, Valley'),
('Jack Harris', 'jack@example.com', '0987654321', '444 Oak St, Desert'),
('Kevin Clark', 'kevin@example.com', '0123456789', '222 Maple St, Plain'),
('Lisa Taylor', 'lisa@example.com', '0987654321', '111 Cedar St, Plateau'),
('Mike Anderson', 'mike@example.com', '0123456789', '666 Elm St, Lakeside'),
('Nancy White', 'nancy@example.com', '0987654321', '777 Pine St, Island'),
('Olivia Moore', 'olivia@example.com', '0123456789', '555 Maple St, Peninsula');

INSERT INTO Staffs (fullName, email, phone, [address], salary)
VALUES 
('Emily Johnson', 'emily@example.com', '0123456789', '123 Broadway, City', 35000.00),
('Michael Brown', 'michael@example.com', '0987654321', '456 Oak St, Town', 40000.00),
('Alex Garcia', 'alex@example.com', '0123456789', '789 Elm St, Village', 38000.00),
('Emma Martinez', 'emma@example.com', '0987654321', '1010 Pine St, Hamlet', 36000.00),
('Daniel Miller', 'daniel@example.com', '0123456789', '555 Maple St, Countryside', 39000.00),
('Sophia Lee', 'sophia@example.com', '0987654321', '777 Cedar St, Suburb', 37000.00),
('William Wilson', 'william@example.com', '0123456789', '888 Pine St, Coastal', 41000.00),
('Olivia Thompson', 'olivia@example.com', '0987654321', '999 Elm St, Mountains', 38000.00),
('James Clark', 'james@example.com', '0123456789', '333 Birch St, Valley', 42000.00),
('Emma Harris', 'emma@example.com', '0987654321', '444 Oak St, Desert', 40000.00),
('Ethan Davis', 'ethan@example.com', '0123456789', '222 Maple St, Plain', 43000.00),
('Mia Taylor', 'mia@example.com', '0987654321', '111 Cedar St, Plateau', 39000.00),
('Isabella Anderson', 'isabella@example.com', '0123456789', '666 Elm St, Lakeside', 44000.00),
('Jacob White', 'jacob@example.com', '0987654321', '777 Pine St, Island', 40000.00),
('Charlotte Moore', 'charlotte@example.com', '0123456789', '555 Maple St, Peninsula', 45000.00);

INSERT INTO Categories (categoryName)
VALUES 
('Science Fiction'),
('Mystery'),
('Romance'),
('Biography'),
('History'),
('Self-Help'),
('Fantasy'),
('Thriller'),
('Cooking'),
('Poetry'),
('Travel'),
('Art'),
('Health'),
('Business'),
('Religion');

INSERT INTO Authors ([name], biography)
VALUES 
('Agatha Christie', 'Agatha Christie was an English writer known for her detective novels.'),
('J.R.R. Tolkien', 'J.R.R. Tolkien was an English writer, poet, philologist, and academic, best known for his high fantasy works.'),
('Maya Angelou', 'Maya Angelou was an American poet, memoirist, and civil rights activist.'),
('Stephen Hawking', 'Stephen Hawking was an English theoretical physicist, cosmologist, and author who was director of research at the Centre for Theoretical Cosmology at the University of Cambridge.'),
('Michelle Obama', 'Michelle Obama is an American attorney, author, and former First Lady of the United States.'),
('Malcolm Gladwell', 'Malcolm Gladwell is a Canadian journalist, author, and public speaker.'),
('J.K. Rowling', 'J.K. Rowling is a British author, philanthropist, film producer, television producer, and screenwriter.'),
('Haruki Murakami', 'Haruki Murakami is a Japanese writer.'),
('Paulo Coelho', 'Paulo Coelho is a Brazilian lyricist and novelist.'),
('Terry Pratchett', 'Terry Pratchett was an English author of fantasy novels.'),
('Dan Brown', 'Dan Brown is an American author best known for his thriller novels.'),
('John Grisham', 'John Grisham is an American novelist, attorney, politician, and activist.'),
('Suzanne Collins', 'Suzanne Collins is an American television writer and author.'),
('George R.R. Martin', 'George R.R. Martin is an American novelist and short story writer in the fantasy, horror, and science fiction genres.'),
('Jojo Moyes', 'Jojo Moyes is an English journalist and, since 2002, a romance novelist and screenwriter.');


INSERT INTO Books (title, publishedYear, quantity)
VALUES 
('The Hobbit', 2000, 10),
('The Da Vinci Code', 2003, 15),
('To Kill a Mockingbird', 2000, 12),
('Becoming', 2018, 20),
('A Brief History of Time', 2000, 8),
('The Catcher in the Rye', 2000, 14),
('The Alchemist', 2000, 18),
('Harry Potter and the Prisoner of Azkaban', 2000, 16),
('The Girl on the Train', 2015, 22),
('The Great Gatsby', 2000, 10),
('1984', 2000, 10),
('Pride and Prejudice', 2000, 10),
('Eat, Pray, Love', 2006, 15),
('The Power of Now', 2001, 12),
('The Art of War', 2002, 20);

INSERT INTO BorrowRecords (bookID, memberID, staffID, borrowDate, allowedDays)
VALUES 
(1, 1, 2, '2024-06-01', 14),
(2, 3, 4, '2024-06-02', 7),
(3, 5, 6, '2024-06-03', 10),
(4, 7, 8, '2024-06-04', 21),
(5, 9, 10, '2024-06-05', 14),
(6, 11, 12, '2024-06-06', 7),
(7, 13, 14, '2024-06-07', 14),
(8, 15, 1, '2024-06-08', 7),
(9, 2, 3, '2024-06-09', 10),
(10, 4, 5, '2024-06-10', 14),
(11, 6, 7, '2024-06-1', 7),
(12, 8, 9, '2024-05-12', 14),
(13, 10, 11, '2024-04-13', 21),
(14, 12, 13, '2024-05-14', 14),
(15, 14, 15, '2024-03-15', 7);

INSERT INTO ReturnRecords (staffID, returnDate)
VALUES 
(2, '2024-06-15'),
(4, '2024-06-16'),
(6, '2024-06-17'),
(8, '2024-06-18'),
(10, '2024-06-19'),
(12, '2024-06-20'),
(14, '2024-06-21'),
(1, '2024-06-22'),
(3, '2024-06-23'),
(5, '2024-06-24'),
(7, '2024-06-25'),
(9, '2024-06-26'),
(11, '2024-06-27'),
(13, '2024-06-28'),
(15, '2024-06-29');

-- Phân loại các cuốn sách một cách ngẫu nhiên cho đến 3 loại khác nhau.
INSERT INTO Book_CategoriesDetail (bookID, categoryID, history)
VALUES 
(1, 1, 'Book is a classic fantasy novel'),
(2, 2, 'Book is a popular mystery thriller'),
(3, 3, 'Book is a timeless romance novel'),
(4, 4, 'Book is a bestselling memoir'),
(5, 5, 'Book is a renowned science book'),
(6, 6, 'Book is a well-known coming-of-age novel'),
(7, 7, 'Book is a beloved philosophical novel'),
(8, 8, 'Book is a thrilling adventure story'),
(9, 9, 'Book is a famous cookbook'),
(10, 10, 'Book is a collection of poetry'),
(11, 11, 'Book is a travelogue'),
(12, 12, 'Book is an art history book'),
(13, 13, 'Book is a health and wellness guide'),
(14, 14, 'Book is a business bestseller'),
(15, 15, 'Book is a spiritual guide');

-- Gán tác giả cho mỗi cuốn sách một cách ngẫu nhiên.
INSERT INTO Book_AuthorDetail (bookID, authorID, note)
VALUES 
(1, 2, 'Author of the famous Lord of the Rings series'),
(2, 11, 'Bestselling author of suspense novels'),
(3, 12, 'Renowned for her timeless romance novels'),
(4, 5, 'Former First Lady of the United States'),
(5, 4, 'Renowned theoretical physicist and cosmologist'),
(6, 6, 'Classic novel by J.D. Salinger'),
(7, 9, 'Bestselling philosophical novel by Paulo Coelho'),
(8, 7, 'Renowned author of fantasy novels'),
(9, 1, 'Bestselling author of thriller novels'),
(10, 10, 'Famous poet'),
(11, 14, 'Travel writer and journalist'),
(12, 13, 'Art historian and critic'),
(13, 8, 'Wellness expert and author'),
(14, 15, 'Renowned business author and speaker'),
(15, 3, 'Spiritual teacher and author');
