--  Create Database
CREATE DATABASE ecommerce_store;

USE ecommerce_store;

--  Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    ProductDescription TEXT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Stock INT NOT NULL DEFAULT 0 CHECK (Stock >= 0)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
    PaymentMethod ENUM('Credit Card','M-pesa','Cash','Bank Transfer') NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

-- Insert Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Mercy', 'J', 'mercy.j@email.com', '1234567890', '123 Main St'),
('Jack', 'Smith', 'jack.smith@email.com', '0987654321', '456 Oak Ave'),
('Evans', 'Clark', 'evans.clark@email.com', '5551234567', '789 Pine Rd');

-- Insert Products
INSERT INTO Products (ProductName, ProductDescription, Price, Stock) VALUES
('Laptop', '15-inch laptop with 8GB RAM and 256GB SSD', 750.00, 10),
('Mouse', 'Wireless optical mouse', 20.00, 50),
('Keyboard', 'Mechanical keyboard with RGB lighting', 60.00, 30),
('Phone', 'Smartphone with 6.5-inch display', 500.00, 25),
('Tablet', '10-inch tablet with stylus support', 300.00, 15);

-- Insert Orders
INSERT INTO Orders (CustomerID, Status) VALUES
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered');

-- Insert OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 1), 
(1, 2, 2), 
(2, 5, 1), 
(2, 3, 1), 
(2, 2, 1), 
(3, 4, 1); 

-- Insert Payments
INSERT INTO Payments (OrderID, Amount, PaymentMethod) VALUES
(1, 790.00, 'Credit Card'), 
(2, 380.00, 'M-pesa'),      
(3, 500.00, 'Cash');        
