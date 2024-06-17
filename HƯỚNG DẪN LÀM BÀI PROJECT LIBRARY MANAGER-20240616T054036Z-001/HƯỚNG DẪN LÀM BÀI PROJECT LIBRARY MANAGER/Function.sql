--Function to calculate the total fines for a member:
CREATE FUNCTION dbo.CalculateTotalFinesForMember (@memberID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @totalFines DECIMAL(18, 2)
    
    SELECT @totalFines = ISNULL(SUM(brd.fineAmount), 0)
    FROM BorrowRecords br
    JOIN Borrow_ReturnDetail brd ON br.borrowID = brd.borrowID
    WHERE br.memberID = @memberID
    
    RETURN @totalFines
END

-- Test FUNCTION CalculateTotalFinesForMember
PRINT dbo.CalculateTotalFinesForMember(5)


--Function to get the number of books borrowed by a member:
CREATE FUNCTION dbo.GetBorrowedBooksCount (@memberID INT)
RETURNS INT
AS
BEGIN
    DECLARE @borrowedBooksCount INT
    
    SELECT @borrowedBooksCount = COUNT(*)
    FROM BorrowRecords
    WHERE memberID = @memberID
    
    RETURN @borrowedBooksCount
END
--Test GetBorrowedBooksCount
PRINT dbo.GetBorrowedBooksCount(2)