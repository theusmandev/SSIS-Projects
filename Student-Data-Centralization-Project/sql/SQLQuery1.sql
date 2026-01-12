create database StudentDB
go
use StudentDB
Go

create table Students(
StudentID varchar(50) primary key,
FirstName varchar(100),
LastName varchar(50),
Course varchar(50),
EnrollmentDate Date,
LoadedAt datetime default getdate()
)

SELECT * FROM Students;




CREATE TABLE ETL_Logs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    FileName VARCHAR(255),
    StartTime DATETIME,
    EndTime DATETIME,
    Status VARCHAR(50),
    ErrorMessage VARCHAR(MAX)
);

SELECT * FROM  ETL_Logs

SELECT * FROM ETL_Logs ORDER BY StartTime DESC;