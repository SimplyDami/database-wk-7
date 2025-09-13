USE salesdb;

-- @block
-- Question 1 Achieving 1NF--
-- Transforming ProductDetail into 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- @block
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- @block
-- Question 2
-- Achieving 2NF
-- Orders table (no redundancy of CustomerName)

-- @block
SET FOREIGN_KEY_CHECKS = 0;

-- @block
DROP TABLE IF EXISTS OrderDetails;
-- @block
DROP TABLE IF EXISTS OrderProducts;
-- @block
DROP TABLE IF EXISTS Orders;

-- @block
SET FOREIGN_KEY_CHECKS = 1;


-- @block
-- Recreate tables in correct order
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);


-- @block
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- @block
-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- @block
-- Insert data into OrderProducts
INSERT INTO OrderProducts (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


-- Question 3
-- @block
-- Drop old tables (clean slate)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS OrderProducts;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
SET FOREIGN_KEY_CHECKS = 1;

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    CustomerCity VARCHAR(100)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

-- Orders table (only order info)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderProducts table (many-to-many relationship)
CREATE TABLE OrderProducts (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- @block
-- Customers
INSERT INTO Customers (CustomerName, CustomerCity) VALUES
('John Doe', 'Lagos'),
('Jane Smith', 'Abuja'),
('Emily Clark', 'Ibadan');

-- @block
-- Products
INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 800),
('Mouse', 20),
('Tablet', 300),
('Keyboard', 40),
('Phone', 500);

-- @block
-- Orders
INSERT INTO Orders (OrderID, CustomerID) VALUES
(101, 1), -- John Doe
(102, 2), -- Jane Smith
(103, 3); -- Emily Clark


--@block
-- OrderProducts
INSERT INTO OrderProducts (OrderID, ProductID, Quantity) VALUES
(101, 1, 2),  -- John Doe ordered 2 Laptops
(101, 2, 1),  -- John Doe ordered 1 Mouse
(102, 3, 3),  -- Jane Smith ordered 3 Tablets
(102, 4, 1),  -- Jane Smith ordered 1 Keyboard
(102, 2, 2),  -- Jane Smith ordered 2 Mice
(103, 5, 1);  -- Emily Clark ordered 1 Phone
