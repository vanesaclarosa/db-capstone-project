DELIMITER //

CREATE PROCEDURE CheckBooking(
    IN Booking_date DATE,
    IN table_number INT
)
BEGIN
    -- Declare a variable to hold the booking status
    DECLARE booking_status INT;

    -- Check if the table is booked for the given date
    SELECT COUNT(*)
    INTO booking_status
    FROM bookings
    WHERE Date = Date AND tableNo = table_number;

    -- Display the result
    IF booking_status > 0 THEN
        SELECT 'Table is booked.' AS StatusMessage;
    ELSE
        SELECT 'Table is available.' AS StatusMessage;
    END IF;
END //

DELIMITER ;

call checkbooking ('2022-11-12',3);

DELIMITER //


#############


DELIMITER //

CREATE PROCEDURE AddValidBooking(
  #####IN Booking_ID INT,
    IN booking_date DATE,
    IN table_number INT
    ####IN customer_ID INT
)
BEGIN
    -- Declare a variable to check if the table is already booked
    DECLARE booking_exists INT;

    -- Start the transaction
    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*)
    INTO booking_exists
    FROM bookings
    WHERE `Date` = booking_date AND tableNo = table_number;

    -- If the table is already booked, rollback the transaction
    IF booking_exists > 0 THEN
        ROLLBACK;
        SELECT 'Table is already booked. Booking has been canceled.' AS StatusMessage;
    ELSE
        -- If the table is available, proceed with the booking
        INSERT INTO bookings ( `Date`, tableNo)
        VALUES ( booking_date, table_number);
        
        -- Commit the transaction
        COMMIT;
        SELECT 'Booking has been successfully made.' AS StatusMessage;
    END IF;
END //

CAll AddValidBooking('2022-12-17',6)


################# NEW SECTION


DELIMITER //

CREATE PROCEDURE AddBooking(
    IN booking_id INT,
    IN booking_date DATE,
    IN table_number INT,
    IN customer_id INT
)
BEGIN
    -- Insert a new booking record into the Bookings table
    INSERT INTO Bookings (BookingID, Date, tableNo, CustomerId)
    VALUES (booking_id, booking_date, table_number, customer_id);

   
    SELECT 'Booking has been added.' AS StatusMessage;
END //

DELIMITER ;

call AddBooking(14,'2022-10-10',8,3)



DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN booking_id INT,
    IN new_booking_date DATE
)
BEGIN
    -- Update the booking record with the new booking date
    UPDATE bookings
    SET Date = new_booking_date
    WHERE BookingID = booking_id;

    
    SELECT 'Booking has been updated.' AS StatusMessage;
END //

DELIMITER ;

call UpdateBooking(9, '2022-12-17');




DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN booking_id INT
)
BEGIN
    -- Delete the booking record with the specified booking_id
    DELETE FROM bookings
    WHERE BookingID = booking_id;


    SELECT 'Booking has been successfully canceled.' AS StatusMessage;
END //

DELIMITER ;

call CancelBooking(9)

