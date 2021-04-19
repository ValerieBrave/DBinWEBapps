sp_configure 'show advanced options', 1;    
GO    
RECONFIGURE;    
GO    
sp_configure 'clr strict security', 0;    
GO    
RECONFIGURE;    
GO 
exec sp_configure 'clr enabled', 1;
go
reconfigure;
go

CREATE ASSEMBLY lab_3 from 'D:\DBinWEBapps\lab3\lab3\bin\Release\lab3.dll' WITH PERMISSION_SET = SAFE
drop procedure ToDoJobs;
drop type JobDescription;
drop assembly lab_3;
use execution_control;
go
CREATE PROCEDURE ToDoJobs
@now datetime
AS    
EXTERNAL NAME lab_3.[StoredProcedures].ToDoJobs;

go
CREATE TYPE dbo.JobDescription   
EXTERNAL NAME lab_3.[JobDescription];

DECLARE @p1 datetime = CONVERT(Datetime, '2021-02-07', 120)
exec ToDoJobs @p1;

CREATE TABLE Example
(ID int IDENTITY(1,1) PRIMARY KEY, descript JobDescription)

INSERT INTO Example(descript) VALUES (CONVERT(JobDescription, 'stat1,title1')); 
INSERT INTO Example(descript) VALUES (CONVERT(JobDescription, 'stat2,title2')); 
INSERT INTO Example(descript) VALUES (CONVERT(JobDescription, 'stat3,title3')); 
select descript.ToString() from Example;