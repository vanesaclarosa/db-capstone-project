#################TASK 1

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
  
    DECLARE max_quantity INT;

    SELECT MAX(Quantity) INTO max_quantity
    FROM orders;

    SELECT max_quantity AS MaxQuantity;
END //

DELIMITER ;

CALL GetMaxQuantity();

#################TASK 2

PREPARE GetOrderDetail FROM
'SELECT OrderId, quantity, TotalCost
 FROM Orders
 WHERE CustomerID = ?';
 
SET @id = 1;
EXECUTE GetOrderDetail USING @id;


###############TASK 3


DELIMITER //

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM orders
    WHERE OrderId = order_id;
END //

DELIMITER ;

call CancelOrder(4);