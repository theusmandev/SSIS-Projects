# Retail Sales Intelligence & ETL Pipeline

##  Project Overview
This project demonstrates a **comprehensive ETL (Extract, Transform, Load) pipeline** built using **SQL Server Integration Services (SSIS)**.  
The solution automates ingestion of raw retail sales data from **Excel**, applies **business rules and analytics**, and loads curated datasets into **SQL Server** for reporting and intelligence.

---

##  Data Pipeline Architecture

###  Extraction (Source Layer)
- **Source Type:** Microsoft Excel  
- **File:** `Sales_Data.xlsx`  
- **Description:** Raw retail transaction data  
- **Records Extracted:** 15 rows  

---

###  Transformation Layer (Logic & Optimization)

#### 🔹 Derived Column
Calculated `TotalSales` dynamically:
TotalSales = Price * Quantity

#### 🔹 Data Conversion
- Converted Unicode strings to Non-Unicode:

#### DT_WSTR → DT_STR
- Ensured compatibility with SQL Server destinations.

#### 🔹 Conditional Split
Transactions categorized based on order value:

| Condition | Category |
|---------|---------|
| TotalSales > 1000 | VIP Sales |
| TotalSales ≤ 1000 | Standard Sales |

### Expression:

TotalSales > 1000

#### 🔹 Multicast
- Cloned VIP data stream
- Enabled parallel processing for:
  - Detailed storage
  - Aggregated analytics

#### 🔹 Aggregate Transformation
### City-wise aggregation:

SUM(TotalSales) GROUP BY City


---

###  Loading (Destination Layer)
- **Database:** `Sales_DB`
- **Connectivity:** ODBC
- **Target Tables:**
  - `Standard_Sales`
  - `VIP_Sales`
  - `Sales_Summary`

---

##  Technical Stack
- **ETL Tool:** SQL Server Integration Services (SSIS)
- **Database:** Microsoft SQL Server
- **Source:** Excel
- **Connectivity:** ODBC
- **Logic:** SSIS Expressions, T-SQL

---

## Execution Summary

| Metric | Result |
|------|-------|
| Total Records Processed | 15 |
| Standard Sales Records | 9 |
| VIP Sales Records | 6 |
| Aggregated Cities | 3 |
| Cities | Faisalabad, Lahore, Karachi |

---

## Setup & Installation

###  Clone the Repository
Download:
- `Retail_Sales_ETL.dtsx`
- `Sales_Data.xlsx`

---

###  Database Setup (SQL Server)

```sql
CREATE DATABASE Sales_DB;
GO
USE Sales_DB;
GO

CREATE TABLE Standard_Sales (
    SaleID INT IDENTITY PRIMARY KEY,
    OrderDate DATE,
    City VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    TotalSales DECIMAL(12,2)
);

CREATE TABLE VIP_Sales (
    SaleID INT IDENTITY PRIMARY KEY,
    OrderDate DATE,
    City VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    TotalSales DECIMAL(12,2)
);

CREATE TABLE Sales_Summary (
    City VARCHAR(50),
    TotalCitySales DECIMAL(14,2)
);




