use execution_control;
go
create function employees_tasks(@emp_name varchar(100)) returns int
as begin
	declare @rc int = 1;
	set @rc = (select count(*) 
				from job  inner join employee 
				on job.emp_name like employee.emp_name
				where employee.emp_name like @emp_name);
	return @rc;
end
go
select * from job;
select dbo.employees_tasks(emp_name), emp_name from employee;
go
create function days_passed(@id int) returns int
as begin
	declare @rc int = 0;
	declare @start datetime = (select job_start from job where job_id like @id);
	declare @now datetime = sysdatetime();
	set @rc = DATEDIFF(day, @start, @now);
	return @rc;
end
--drop function dbo.days_passed;
go
select job_id, job_start, dbo.days_passed(job_id) from job;
