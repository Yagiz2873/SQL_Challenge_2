--1.Soru
SELECT * FROM Employees
SELECT * FROM Suppliers
SELECT * FROM EmployeeTerritories
SELECT * FROM Orders
SELECT * FROM Products
SELECT * FROM Shippers

SELECT s.ShipperID, s.CompanyName ,(e.FirstName + ' ' + e.LastName) CALISAN FROM 
Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID 
INNER JOIN Shippers s ON o.ShipVia  = s.ShipperID

--2.soru

--In the playground database (we have no authority in the nortwinddb) 

    CREATE VIEW TopCustomers AS

    SELECT C.CustomerID, CONVERT(INT,SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))) Price 
    FROM Customers C 
    INNER JOIN Orders O ON C.CustomerID = O.CustomerID 
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID 
    GROUP BY C.CustomerID



    SELECT * FROM TopCustomers
    ORDER BY TopCustomers.Price DESC  

    DROP VIEW TopCustomers


--3.soru
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT C.CustomerID, COUNT(DISTINCT O.OrderID) Siparis_Adedi FROM Customers C INNER JOIN Orders O ON C.CustomerID = O.CustomerID 
GROUP BY C.CustomerID

--4.soru
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT OrderID, RequiredDate, ShippedDate, 
CASE 
    WHEN ShippedDate > RequiredDate THEN 'GEC_TESLIM'
    WHEN ShippedDate < RequiredDate THEN 'ERKEN_TESLIM'
END AS Cargo_Status FROM Orders

--5.soru
SELECT ContactName Tedarikci_Musteri_Adi, City FROM Suppliers
UNION
SELECT ContactName Tedarikci_Musteri_Adi, City FROM Customers
ORDER BY City

--6.soru
WITH CustomerPrice AS
(SELECT CustomerID, CONVERT(INT,SUM(UnitPrice*Quantity*(1-Discount))) Toplam_Harcama 
FROM Orders o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY CustomerID)

SELECT * , ROW_NUMBER() OVER(ORDER BY Toplam_Harcama DESC) Sira_No 
FROM CustomerPrice
