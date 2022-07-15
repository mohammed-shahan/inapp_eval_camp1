USE machineTest


--OrderDetails {OrderId, OrderDate, OrderPrice, OrderQuantity, CustId}
--CustDetails {CustId, Custname}
--ProductDetails {Product_id, OrderId, Manufacture_Date, Product_Name, Manufacturer_id}
--ManufacturerDetails {Manufacturer_id, Manufacturer_Name}

--Creating Table Customer Details
CREATE TABLE CustDetails(
	CustId INT IDENTITY PRIMARY KEY,
	Custname VARCHAR(25)
);

--Creating table Manufacturer Details
CREATE TABLE ManufacturerDetails(
	Manufacturer_id INT IDENTITY PRIMARY KEY,
	Manufacturer_Name VARCHAR(25)
);

--Creating table order details
CREATE TABLE OrderDetails(
	OrderId INT IDENTITY PRIMARY KEY,
	OrderDate DATE,
	OrderPrice INT,
	OrderQuantity INT,
	CustId INT NOT NULL
	CONSTRAINT fk_order
	FOREIGN KEY (CustId)
	REFERENCES CustDetails(CustId)  
);

--Creating table order details
CREATE TABLE ProductDetails(
	Product_id INT PRIMARY KEY, 
	OrderId INT FOREIGN KEY REFERENCES OrderDetails(OrderId),
	Manufacture_Date DATE,
	Product_Name VARCHAR(25),
	Manufacturer_id INT FOREIGN KEY REFERENCES ManufacturerDetails(Manufacturer_id) 
);

--Inserting values into customer details
INSERT INTO CustDetails VALUES
('Jayesh'),
('Abhilash'),
('Lily'),
('Aswathy')

--Inserting values into manufacturer details
INSERT INTO ManufacturerDetails VALUES
('Samsung'),
('Sony'),
('Mi'),
('Boat')

--Inserting values into order details
INSERT INTO OrderDetails VALUES
('2020/12/22', 270, 2, 1),
('2019/08/10', 280, 4, 2),
('2019/07/13', 600, 5, 3),
('2020/07/15', 520, 1, 1),
('2020/12/22', 1200, 4, 4),
('2019/10/02', 420, 3, 1),
('2020/11/03', 3000, 2, 3),
('2020/12/22', 1100, 4, 4),
('2019/12/29', 5500, 2, 1)

--Inserting values into Product details
INSERT INTO ProductDetails VALUES
(145, 2, '2019/12/23', 'MobilePhone', 1),
(147, 6, '2019/08/15', 'MobilePhone', 3),
(435, 5, '2018/11/04', 'MobilePhone', 1),
(783, 1, '2017/11/03', 'LED TV', 2),
(784, 4, '2019/11/28', 'LED TV', 2),
(123, 2, '2019/10/03', 'Laptop', 2),
(267, 5, '2019/11/03', 'Headphone', 4),
(333, 9, '2017/12/12', 'Laptop', 1),
(344, 3, '2018/11/03', 'Laptop', 1),
(233, 3, '2019/11/30', 'PowerBank', 2),
(567, 6, '2019/09/03', 'PowerBank', 2)



--1. Total number of orders placed in each year
SELECT YEAR(OrderDate) 'Year', COUNT(OrderId) 'No. of orders placed'
FROM OrderDetails
GROUP BY YEAR(OrderDate)

--2. Total number of orders placed in each year by Jayesh
SELECT YEAR(OrderDate) 'Year', COUNT(OrderId) 'No. of orders placed'
FROM OrderDetails
GROUP BY CustId, YEAR(OrderDate)
HAVING  CustId IN (
	SELECT CustId
	FROM CustDetails 
	WHERE Custname = 'Jayesh'
)

--3. Products which are ordered in the same year of its manufacturing year
SELECT * 
FROM OrderDetails
INNER JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderId
WHERE YEAR(OrderDetails.OrderDate) = YEAR(ProductDetails.Manufacture_Date)

--4. Products which is ordered in the same year of its manufacturing year where the Manufacturer is ‘Samsung’
SELECT * 
FROM OrderDetails
INNER JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderId
WHERE YEAR(OrderDetails.OrderDate) = YEAR(ProductDetails.Manufacture_Date) 
AND ProductDetails.Manufacturer_id = (SELECT Manufacturer_id FROM ManufacturerDetails 
WHERE Manufacturer_Name = 'Samsung')

--5. Total number of products ordered every year
SELECT YEAR(OrderDate) 'Year', SUM(OrderQuantity) 'No. of products ordered'
FROM OrderDetails
GROUP BY YEAR(OrderDate)

--6. Display the total number of products ordered every year made by sony
SELECT YEAR(OrderDetails.OrderDate), SUM(OrderQuantity)
FROM OrderDetails
JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderId
JOIN ManufacturerDetails ON ProductDetails.Manufacturer_id = ManufacturerDetails.Manufacturer_id
GROUP BY ManufacturerDetails.Manufacturer_Name, YEAR(OrderDetails.OrderDate)
HAVING ManufacturerDetails.Manufacturer_Name = 'Sony'

--7. All customers who are ordering mobile phone by samsung
SELECT * 
FROM CustDetails
JOIN OrderDetails ON OrderDetails.CustId = CustDetails.CustId
JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderId
JOIN ManufacturerDetails ON ProductDetails.Manufacturer_id = ManufacturerDetails.Manufacturer_id
WHERE ManufacturerDetails.Manufacturer_Name = 'Samsung'

--8. Total number of orders got by each Manufacturer every year
SELECT ManufacturerDetails.Manufacturer_Name, YEAR(OrderDetails.OrderDate) 'Year',
COUNT(OrderDetails.OrderId) 'No. of Orders'
FROM ManufacturerDetails
JOIN ProductDetails ON ProductDetails.Manufacturer_id = ManufacturerDetails.Manufacturer_id
JOIN OrderDetails ON OrderDetails.OrderId = ProductDetails.OrderId
GROUP BY ManufacturerDetails.Manufacturer_Name, YEAR(OrderDetails.OrderDate)

--9. All Manufacturers whose products were sold more than 1500 Rs every year
SELECT ManufacturerDetails.Manufacturer_Name, YEAR(OrderDetails.OrderDate) 'Year',
COUNT(OrderDetails.OrderId) 'No. of Orders', SUM(OrderDetails.OrderPrice) 'Price' 
FROM ManufacturerDetails
JOIN ProductDetails ON ProductDetails.Manufacturer_id = ManufacturerDetails.Manufacturer_id
JOIN OrderDetails ON OrderDetails.OrderId = ProductDetails.OrderId
GROUP BY ManufacturerDetails.Manufacturer_Name, YEAR(OrderDetails.OrderDate)
HAVING SUM(OrderDetails.OrderPrice) > 1500
