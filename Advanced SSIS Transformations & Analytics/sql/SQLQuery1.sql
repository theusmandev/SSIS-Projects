create database Sales_DB

-- 1. Standard Sales Table
CREATE TABLE Standard_Sales (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Price DECIMAL(18, 2),
    Quantity INT,
    City VARCHAR(255),
    TotalSales DECIMAL(18, 2)
);

-- 2. VIP Sales Table (High Value Orders)
CREATE TABLE VIP_Sales (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255),
    Price DECIMAL(18, 2),
    Quantity INT,
    City VARCHAR(255),
    TotalSales DECIMAL(18, 2)
);

-- 3. Summary Table (Aggregate output ke liye)
CREATE TABLE Sales_Summary (
    City VARCHAR(255),
    CityTotalSales DECIMAL(18, 2)
);


USE Sales_DB;

-- Check VIP Orders
SELECT * FROM VIP_Sales;

-- Check Standard Orders 
SELECT * FROM Standard_Sales;

-- Check City Summary
SELECT * FROM Sales_Summary;