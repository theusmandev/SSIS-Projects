# SSIS – Tracking Data Evolution (SCD Type 2)

In the world of data engineering, information is never static.  
People move, preferences shift, and records evolve.

This project demonstrates how to **track data evolution over time** using **Slowly Changing Dimension (SCD) Type 2** in **SQL Server Integration Services (SSIS)**—not by overwriting history, but by preserving it.

---

## Project Philosophy 

Technically, this is an ETL pipeline.  
Humanly, this is about **data integrity and respect for history**.

When a customer changes their city, we do not erase their past.  
We **archive it**, timestamp it, and let the data tell its full story.

This project was also a personal engineering journey—overcoming **Visual Studio 2022 UI bugs**, avoiding unreliable wizards, and implementing **manual, transparent logic** to ensure correctness.

---

##  Tech Stack

| Component | Technology |
|--------|------------|
| ETL Engine | SQL Server Integration Services (SSIS) |
| Database | Microsoft SQL Server |
| Development IDE | Visual Studio 2022 (64-bit Runtime) |
| Connectivity | Microsoft OLE DB Driver for SQL Server |

---

##  Architecture & Design

###  Database Schema

#### Staging Table
**`SCD_Source_Customer`**
- Holds the latest incoming customer data
- Represents the current snapshot from source systems

#### Dimension Table
**`DimCustomer`**
- Stores historical versions of customer records
- Uses technical metadata to track change history

Key columns:
- `StartDate`
- `EndDate`
- `IsCurrent`

---

###  SSIS Data Flow Logic

The data flow follows **true SCD Type 2 behavior**:

#### 🔑 Business Key Matching
- `CustomerID` is used to uniquely identify customers

####  Change Detection
- Attribute-level comparison (e.g., City)

####  Expiration Path (Old Record)
When a change is detected:
- `IsCurrent = 0`
- `EndDate = Current Date`

####  Insertion Path (New Record)
- New row inserted
- `IsCurrent = 1`
- `StartDate = Current Date`
- `EndDate = '9999-12-31'`

This ensures:
- One active record per customer
- Complete historical traceability

---

##  Engineering Challenges & Workarounds

###  Visual Studio 2022 SCD Wizard Bug
System variables like `StartTime` were **not visible** in SCD Wizard dropdowns.

###  Solution (Manual & Reliable)
- Created a **package-level variable**:

### @[User::SCD_Date]

- Injected the variable manually using:
- **Derived Column Transformation**
- **OLE DB Command**

This approach:
- Eliminates dependency on buggy UI
- Ensures accurate historical timestamps
- Makes the logic transparent and debuggable

---

## Final Outcome

After successful execution:

- Full customer history is preserved
- Only one record per customer is marked as current
- Every change is traceable with dates
- No data is overwritten or lost

The database now reflects **time-aware reality** instead of just the latest state.

---

---

##  Let’s Connect

I am passionate about:
- Real-world ETL pipelines
- SSIS optimization
- Data warehousing best practices
- Building systems that **respect data history**

If you’d like to discuss this implementation or collaborate on data engineering projects, feel free to reach out.

---

**Built with precision, curiosity, and a lot of testing.** 
