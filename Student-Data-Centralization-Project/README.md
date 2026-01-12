#  Student Data Centralization & ETL Pipeline (SSIS)

This project demonstrates a **professional-grade ETL (Extract, Transform, Load) pipeline** built using **SQL Server Integration Services (SSIS)**.  
The pipeline centralizes student data from multiple CSV sources into a **single, managed SQL Server database**, implementing **enterprise-level data engineering practices** such as incremental loading, audit logging, and automated error handling.

---

##  Key Features

###  Dynamic File Ingestion
- Uses a **Foreach Loop Container** to automatically detect and process all `.csv` files within a specified source directory.
- No hardcoded file names — fully scalable for new data sources.

###  Incremental Load (Upsert)
- Implements **Upsert logic** using the **Lookup Transformation**.
- Identifies:
  - **New records** → Insert  
  - **Existing records** → Update  
- Matching is based on `StudentID`.

###  Automated Audit Logging
- Custom-built logging mechanism records:
  - Start Time  
  - End Time  
  - Execution Status (`Running`, `Success`, `Failed`)  
  - Detailed error messages
- Ensures full traceability of every ETL execution.

###  Robust Error Handling

**File-Level Error Handling**
- Corrupt or improperly formatted files are **automatically moved to an Error Folder**.
- Prevents pipeline failures due to bad input files.

**Row-Level Error Handling**
- Faulty rows during transformation are redirected instead of crashing the entire package.
- Enables partial success with full visibility of failed records.

### Enterprise Automation
- Fully automated using **SQL Server Agent**.
- Supports **scheduled daily execution** with zero manual intervention.

---

##  Tech Stack

- **ETL Tool:** SQL Server Integration Services (SSIS)
- **Database Engine:** Microsoft SQL Server (T-SQL)
- **IDE:** Visual Studio with SQL Server Data Tools (SSDT)
- **Scheduling:** SQL Server Agent

---

##  Project Architecture

### 1️⃣ Control Flow Logic
- Acts as the master workflow.
- Responsibilities include:
  - Initializing audit logs
  - Looping through incoming CSV files
  - Handling failures using **Failure Paths (Red Arrows)**

### 2️⃣ Data Flow – Upsert Mechanism

**Components Used:**
- **Flat File Source**  
  - Dynamically maps incoming CSV files.

- **Lookup Transformation**  
  - Compares source data with the target table to detect existing records.

- **OLE DB Destination**  
  - Handles **No Match Output** → Inserts new records.

- **OLE DB Command**  
  - Executes parameterized `UPDATE` statements for matched records.

---

##  Monitoring & Auditing

All ETL executions are tracked in the `ETL_Logs` table.

###  Audit Query
```sql
SELECT 
    LogID, 
    FileName, 
    StartTime, 
    EndTime, 
    Status, 
    ErrorMessage 
FROM ETL_Logs 
ORDER BY StartTime DESC;
