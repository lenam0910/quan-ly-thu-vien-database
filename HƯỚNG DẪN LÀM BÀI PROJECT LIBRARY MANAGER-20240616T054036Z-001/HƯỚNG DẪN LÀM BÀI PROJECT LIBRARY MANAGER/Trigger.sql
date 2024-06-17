--Create the trigger to decrease book quantities when insert on  borrowrecord
CREATE TRIGGER trg_DecreaseBookQuantity
ON dbo.BorrowRecords
AFTER INSERT
AS 
BEGIN
UPDATE dbo.Books
SET quantity = quantity-1
WHERE bookID IN
(SELECT b.bookID FROM dbo.Books b JOIN inserted i
 ON b.bookID= i.bookID)
END

--TEST TRIGGER trg_DecreaseBookQuantity
INSERT INTO dbo.BorrowRecords
(
    bookID,
    memberID,
    staffID,
    borrowDate,
    allowedDays
)
VALUES
(   1,         -- bookID - int
    3,         -- memberID - int
    2,         -- staffID - int
    GETDATE(), -- borrowDate - date
    10          -- allowedDays - int
    )

--CREATE The trigger to increase book quantity on return

CREATE TRIGGER trg_IncreaseBookQuantity
ON dbo.Borrow_ReturnDetail
AFTER INSERT
AS
BEGIN
UPDATE dbo.Books
SET quantity = quantity+1
WHERE bookID in
(SELECT Books.bookID FROM dbo.Books JOIN dbo.BorrowRecords ON BorrowRecords.bookID = Books.bookID 
JOIN inserted i ON i.borrowID = BorrowRecords.borrowID)
END 


----TEST TRIGGER trg_IncreaseBookQuantity
INSERT INTO dbo.ReturnRecords
(
    staffID,
    returnDate
)
VALUES
(   4,        -- staffID - int
    '2024-6-13' -- returnDate - date
    )

INSERT INTO dbo.Borrow_ReturnDetail
(
    borrowID,
    returnID
)
VALUES
(   16,    -- borrowID - int
    16   -- returnID - int
    )

-- Create trigger trg_CalculateFine to caculate fineAmount in Borrow_ReturnDetail
CREATE TRIGGER trg_CalculateFine
ON Borrow_ReturnDetail
AFTER INSERT
AS
BEGIN
    DECLARE @borrowID INT, @returnID INT, @borrowDate DATE, @returnDate DATE, @allowedDays INT, @fineAmount DECIMAL(18,2), @lateDays INT, @note NVARCHAR(MAX)
    
    -- Get the inserted data
    SELECT @borrowID = i.borrowID, @returnID = i.returnID
    FROM inserted i

    -- Get the borrow date, return date, and allowed days from the respective tables
    SELECT @borrowDate = br.borrowDate, @allowedDays = br.allowedDays
    FROM BorrowRecords br
    WHERE br.borrowID = @borrowID

    SELECT @returnDate = rr.returnDate
    FROM ReturnRecords rr
    WHERE rr.returnID = @returnID

    -- Calculate the fine amount and late days
    IF DATEDIFF(DAY, @borrowDate, @returnDate) > @allowedDays
    BEGIN
        SET @lateDays = DATEDIFF(DAY, @borrowDate, @returnDate) - @allowedDays
        SET @fineAmount = @lateDays * 5000
        SET @note = CAST(@lateDays AS NVARCHAR) + ' day(s) late'
    END
    ELSE
    BEGIN
        SET @fineAmount = 0
        SET @note = 'Returned on time'
    END

    -- Update the Borrow_ReturnDetail table with the calculated fine amount and note
    UPDATE Borrow_ReturnDetail
    SET fineAmount = @fineAmount, note = @note
    WHERE borrowID = @borrowID AND returnID = @returnID
END


--Test Trigger trg_CalculateFine
INSERT INTO dbo.Borrow_ReturnDetail
(
    borrowID,
    returnID
)
VALUES
(   4,    -- borrowID - int
    4    -- returnID - int
    )

SELECT * FROM dbo.Borrow_ReturnDetail