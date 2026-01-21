CREATE DATABASE SCD_Project;
GO
USE SCD_Project;
GO






-- 1. Source Table: Jahan naya data aaye ga
CREATE TABLE SCD_Source_Customer (
    CustomerID INT,          -- Business Key
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

-- 2. Dimension Table: Jahan history maintain hogi
CREATE TABLE DimCustomer (
    CustomerSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    CustomerID INT,                           -- Business Key
    CustomerName VARCHAR(100),                -- Type 1 (Overwrite)
    City VARCHAR(50),                         -- Type 2 (New Row)
    StartDate DATETIME,                       -- Valid From
    EndDate DATETIME,                         -- Valid To
    IsCurrent BIT                             -- 1 = Active, 0 = Expired
);


select * from SCD_Source_Customer
select * from DimCustomer


INSERT INTO SCD_Source_Customer (CustomerID, CustomerName, City)
VALUES (101, 'Ali Hamza', 'Karachi');



UPDATE SCD_Source_Customer
SET City = 'Karachi'
WHERE CustomerID = 101;

