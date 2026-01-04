CREATE DATABASE ecommerce_db;
USE ecommerce_db;

----------------------Create TABLES------------------------
-----------------------------------------------------------

CREATE TABLE customer (
    C_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    PinCode VARCHAR(10),
    RegistrationDate DATE
);

CREATE TABLE seller (
    S_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    ContactNo VARCHAR(20),
    BusinessName VARCHAR(100),
    Status VARCHAR(50),
    GI_ID INT,
    FOREIGN KEY (GI_ID) REFERENCES government_institution(GI_ID)
);

CREATE TABLE government_institution (
    GI_ID INT PRIMARY KEY ,
    InstitutionName VARCHAR(100),
    Department VARCHAR(100),
    ContactInfo VARCHAR(100),
    LicenseVerificationPortal VARCHAR(255),
    TaxRate DECIMAL(5,2)
);

CREATE TABLE category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100),
    Description VARCHAR(255)
);

CREATE TABLE product (
    P_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL(10,2),
    StockQuantity INT,
    CategoryID INT,
    S_ID INT,
    FOREIGN KEY (CategoryID) REFERENCES category(CategoryID),
    FOREIGN KEY (S_ID) REFERENCES seller(S_ID)
);

CREATE TABLE cart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    C_ID INT,
    CreatedAt DATETIME,
    FOREIGN KEY (C_ID) REFERENCES customer(C_ID)
);

CREATE TABLE cart_item (
    CartID INT,
    P_ID INT,
    Quantity INT,
    PRIMARY KEY (CartID, P_ID),
    FOREIGN KEY (CartID) REFERENCES cart(CartID),
    FOREIGN KEY (P_ID) REFERENCES product(P_ID)
);

CREATE TABLE orders (
    O_ID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    Status VARCHAR(50),
    TotalAmount DECIMAL(10,2),
    C_ID INT,
    FOREIGN KEY (C_ID) REFERENCES customer(C_ID)
);

CREATE TABLE order_detail (
    OD_ID INT PRIMARY KEY AUTO_INCREMENT,
    O_ID INT,
    P_ID INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    Subtotal DECIMAL(10,2),
    FOREIGN KEY (O_ID) REFERENCES orders(O_ID),
    FOREIGN KEY (P_ID) REFERENCES product(P_ID)
);

CREATE TABLE payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    O_ID INT,
    PaymentMethod VARCHAR(50),
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (O_ID) REFERENCES orders(O_ID)
);

CREATE TABLE delivery (
    D_ID INT PRIMARY KEY AUTO_INCREMENT,
    O_ID INT,
    DeliveryDate DATE,
    DeliveryStatus VARCHAR(50),
    TrackingNumber VARCHAR(100),
    FOREIGN KEY (O_ID) REFERENCES orders(O_ID)
);

CREATE TABLE review (
    R_ID INT PRIMARY KEY AUTO_INCREMENT,
    ReviewDate DATE,
    Rating INT,
    Comment VARCHAR(255),
    C_ID INT,
    P_ID INT,
    FOREIGN KEY (C_ID) REFERENCES customer(C_ID),
    FOREIGN KEY (P_ID) REFERENCES product(P_ID)
);

CREATE TABLE tax_record (
    T_ID INT PRIMARY KEY AUTO_INCREMENT,
    RecordDate DATE,
    TaxAmount DECIMAL(10,2),
    S_ID INT,
    GI_ID INT,
    FOREIGN KEY (S_ID) REFERENCES seller(S_ID),
    FOREIGN KEY (GI_ID) REFERENCES government_institution(GI_ID)
);


----------------------------INSERT SAMPLE DATA---------------------------------
-------------------------------------------------------------------------------

INSERT INTO customer
(Name, Email, Phone, Address, City, State, PinCode, RegistrationDate) VALUES
('Ahmed', 'ahmed@gmail.com', '03110001111', 'Street 1', 'Islamabad', 'ICT', '44000', '2024-01-10'),
('Sara', 'sara@gmail.com', '03112223333', 'Street 2', 'Lahore', 'Punjab', '54000', '2024-01-12'),
('Bilal', 'bilal@gmail.com', '03113334444', 'Street 3', 'Karachi', 'Sindh', '74000', '2024-01-15');




INSERT INTO seller
(Name, Email, ContactNo, BusinessName, Status, GI_ID) VALUES
('Ali Khan', 'ali@seller.com', '03001112222', 'Ali Store', 'Active', 1),
('Usman Ahmed', 'usman@seller.com', '03002223333', 'Usman Traders', 'Active', 2),
('Hassan Raza', 'hassan@seller.com', '03003334444', 'Hassan Mart', 'Inactive', 3);



INSERT INTO government_institution
(InstitutionName, Department, ContactInfo, LicenseVerificationPortal, TaxRate) VALUES
('FBR', 'Taxation', '051-111111', 'www.fbr.gov.pk', 15.00),
('SECP', 'Corporate', '051-222222', 'www.secp.gov.pk', 12.50),
('PRA', 'Revenue', '042-333333', 'www.pra.punjab.gov.pk', 10.00);



INSERT INTO category (CategoryName, Description) VALUES
('Electronics', 'Electronic items'),
('Clothing', 'Fashion products'),
('Groceries', 'Daily items');


INSERT INTO product
(Name, Description, Price, StockQuantity, CategoryID, S_ID) VALUES
('Laptop', 'HP Laptop', 120000, 10, 1, 1),
('Mobile', 'Samsung Phone', 80000, 15, 1, 2),
('T-Shirt', 'Cotton Shirt', 2500, 50, 2, 3),
('Rice Bag', '5kg Rice', 1200, 100, 3, 1);


INSERT INTO cart (C_ID, CreatedAt) VALUES
(1, '2024-02-01 10:30:00'),
(2, '2024-02-02 11:00:00');


INSERT INTO cart_item (CartID, P_ID, Quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);



INSERT INTO orders
(OrderDate, Status, TotalAmount, C_ID) VALUES
('2024-02-05', 'Confirmed', 120000, 1),
('2024-02-06', 'Pending', 80000, 2);



INSERT INTO order_detail
(O_ID, P_ID, UnitPrice, Quantity, Subtotal) VALUES
(1, 1, 120000, 1, 120000),
(2, 2, 80000, 1, 80000);



INSERT INTO payment
(O_ID, PaymentMethod, PaymentDate, Amount, PaymentStatus) VALUES
(1, 'Credit Card', '2024-02-05', 120000, 'Paid'),
(2, 'Cash', '2024-02-06', 80000, 'Pending');


INSERT INTO delivery
(O_ID, DeliveryDate, DeliveryStatus, TrackingNumber) VALUES
(1, '2024-02-07', 'Shipped', 'TRK001'),
(2, '2024-02-08', 'Pending', 'TRK002');


INSERT INTO review
(ReviewDate, Rating, Comment, C_ID, P_ID) VALUES
('2024-02-10', 5, 'Excellent Product', 1, 1),
('2024-02-11', 4, 'Good Quality', 2, 2);



INSERT INTO tax_record
(RecordDate, TaxAmount, S_ID, GI_ID) VALUES
('2024-02-12', 18000, 1, 1),
('2024-02-13', 10000, 2, 2);





------------------------SELECT QUERIES---------------------------
-----------------------------------------------------------------

SELECT * FROM customer;
SELECT Name, Email FROM seller;
SELECT Name, Price FROM product;
SELECT * FROM orders;


------------------------WHERE CLAUSE-----------------------------
-----------------------------------------------------------------

SELECT * FROM product WHERE Price > 5000;
SELECT * FROM seller WHERE Status = 'Active';
SELECT * FROM customer WHERE City = 'Lahore';
SELECT * FROM product WHERE StockQuantity < 20;


----------------------AGGREGATION FUNCTIONS----------------------
-----------------------------------------------------------------

----Total Customers
SELECT COUNT(*) AS Total_Customers
FROM customer;

----Total Products
SELECT COUNT(*) AS Total_Products
FROM product;

----Total Stock Value 
SELECT SUM(Price * StockQuantity) AS Total_Stock_Value
FROM product;


-------------------GROUP BY-------------------

----Products Count Per Category
SELECT c.CategoryName, COUNT(p.P_ID) AS Total_Products
FROM category c
JOIN product p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;



----------------------SORTING AND LIMITING-------------------
-------------------------------------------------------------

----Products Sorted by Price (DESC)
SELECT Name, Price
FROM product
ORDER BY Price DESC;

----Products Sorted by Stock(ASC)
SELECT Name, StockQuantity
FROM product
ORDER BY StockQuantity ASC;


----Top 3 Expensive Products
SELECT Name, Price
FROM product
ORDER BY Price DESC
LIMIT 3;

----Cheapest 2 Products
SELECT Name, Price
FROM product
ORDER BY Price ASC
LIMIT 2;


---------------------------JOINS--------------------------------
----------------------------------------------------------------

-- Customer Orders
SELECT c.Name, o.O_ID, o.TotalAmount
FROM customer c
JOIN orders o ON c.C_ID = o.C_ID;

-- Product Seller
SELECT p.Name, s.BusinessName
FROM product p
JOIN seller s ON p.S_ID = s.S_ID;

-- Product Category
SELECT p.Name, c.CategoryName
FROM product p
JOIN category c ON p.CategoryID = c.CategoryID;

-- Seller Institution
SELECT s.Name, g.InstitutionName
FROM seller s
JOIN government_institution g ON s.GI_ID = g.GI_ID;



----------------------------SUBQUERIES-------------------------------
---------------------------------------------------------------------

-- Products above average price
SELECT Name FROM product
WHERE Price > (SELECT AVG(Price) FROM product);

-- Customers who placed orders
SELECT Name FROM customer
WHERE C_ID IN (SELECT C_ID FROM orders);

-- Sellers with products
SELECT Name FROM seller
WHERE S_ID IN (SELECT S_ID FROM product);

-- Highest priced product
SELECT * FROM product
WHERE Price = (SELECT MAX(Price) FROM product);


----------------------------UPDATE QUERIES---------------------------
---------------------------------------------------------------------
UPDATE product SET Price = 115000 WHERE Name = 'Laptop';
UPDATE seller SET Status = 'Inactive' WHERE S_ID = 2;
UPDATE customer SET City = 'Rawalpindi' WHERE C_ID = 1;
UPDATE product SET StockQuantity = StockQuantity - 2 WHERE P_ID = 1;


----------------------------DELETE QUERIES---------------------------
---------------------------------------------------------------------

DELETE FROM review WHERE Rating < 3;
DELETE FROM product WHERE StockQuantity = 0;
DELETE FROM seller WHERE Status = 'Inactive';
DELETE FROM cart_item WHERE Quantity = 0;


-------------------------------VIEWS--------------------------------
--------------------------------------------------------------------
CREATE VIEW product_view AS
SELECT Name, Price, StockQuantity FROM product;

CREATE VIEW active_sellers AS
SELECT Name, BusinessName FROM seller WHERE Status = 'Active';

CREATE VIEW customer_city AS
SELECT Name, City FROM customer;
 
-----------Selection for views---------------

SELECT * FROM product_view;
SELECT * FROM active_sellers;
SELECT * FROM customer_city;


-------------------------STORED PROCEDURES-------------------------
-------------------------------------------------------------------

:::::::::Get Orders by Customer::::::::

DELIMITER //
CREATE PROCEDURE GetOrdersByCustomer(IN cid INT)
BEGIN
    SELECT * FROM orders WHERE C_ID = cid;
END //
DELIMITER ;

:::::::::Update Product Stock:::::::::::
DELIMITER //
CREATE PROCEDURE UpdateStock(IN pid INT, IN qty INT)
BEGIN
    UPDATE product SET StockQuantity = StockQuantity - qty WHERE P_ID = pid;
END //
DELIMITER ;

:::::::selection functions::::::::::::::
CALL GetOrdersByCustomer(1);
CALL UpdateStock(1, 2);


----------------------Indexes----------------------------------
---------------------------------------------------------------

CREATE INDEX idx_product_price
ON product(Price);

CREATE INDEX idx_customer_city
ON customer(City);

CREATE INDEX idx_order_status
ON orders(Status);

CREATE INDEX idx_payment_status
ON payment(PaymentStatus);

------show index------
SHOW INDEX FROM product;
SHOW INDEX FROM customer;
SHOW INDEX FROM orders;

------drop index------
DROP INDEX idx_customer_city ON customer;
DROP INDEX idx_product_price ON product;


---------------------TRANSACTIONS-----------------------
--------------------------------------------------------

START TRANSACTION;

INSERT INTO orders (OrderDate, Status, TotalAmount, C_ID)
VALUES (CURDATE(), 'Pending', 80000, 1);

INSERT INTO order_detail (O_ID, P_ID, UnitPrice, Quantity, Subtotal)
VALUES (LAST_INSERT_ID(), 2, 80000, 1, 80000);

UPDATE product
SET StockQuantity = StockQuantity - 1
WHERE P_ID = 2;

COMMIT;

:::::::::::::For undo::::::::::::::
START TRANSACTION;

INSERT INTO payment (O_ID, PaymentMethod, PaymentDate, Amount, PaymentStatus)
VALUES (1, 'Credit Card', CURDATE(), 80000, 'Failed');

ROLLBACK;















