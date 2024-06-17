--Create procedue count number borrow book by bookID
CREATE PROCEDURE dbo.DisplayBookBorrowCount
    @bookID INT
AS
BEGIN
    DECLARE @borrowCount INT

    -- Calculate the borrow count for the given book ID
    SELECT @borrowCount = COUNT(bookID)
    FROM BorrowRecords
    WHERE bookID = @bookID

    -- Display the borrow count
    PRINT 'Book with ID ' + CAST(@bookID AS VARCHAR(10)) + ' has been borrowed ' + CAST(@borrowCount AS VARCHAR(10)) + ' time(s).'
END

---Test
EXEC dbo.DisplayBookBorrowCount 2

--Display number book by author 
CREATE PROCEDURE dbo.GetBookCountByAuthor
    @AuthorName NVARCHAR(255)
AS
BEGIN
    DECLARE @bookCount INT

    -- Calculate the book count for the given publisher
    SELECT @bookCount = COUNT(*)
    FROM dbo.Book_AuthorDetail b
    WHERE b.authorID = (SELECT authorID FROM dbo.Authors WHERE name = @AuthorName)

    -- Display the book count
    PRINT 'Author ' + @AuthorName + ' has produced ' + CAST(@bookCount AS VARCHAR(10)) + ' book(s).'
END

-- Test'

SELECT * FROM dbo.Authors
EXEC dbo.GetBookCountByAuthor 'Agatha Christie'