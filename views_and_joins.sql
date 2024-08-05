CREATE VIEW OrdersView as 
Select OrderId, Quantity, TotalCost
From orders 
where Quantity >2;


Select
c.CustomerId, c.CustomeName, o.OrderId, o.TotalCost, mi.CourseName, m.Cousine
from customer c
left join orders o 
on c.CustomerId = o.CustomerID
Left join menu m
on o.MenuId = m.MenuID
Left join menuitems mi
on m.MenuItemID = mi.MenuItemID
Order by o.TotalCost ;


SELECT Cousine
FROM menu
WHERE MenuID = ANY (
    SELECT MenuId
    FROM orders
    WHERE Quantity > 2
);
