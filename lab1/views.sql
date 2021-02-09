use execution_control;
go
create view done_jobs
as select status, job_title, emp_name
from job
where status like 'FINISHED';
go
create view tostart_jobs
as select status, job_title, emp_name
from job
where status like 'NOT STARTED';
go
create view reviewing_jobs
as select status, job_title, emp_name
from job
where status like 'ON REVIEW';
go
create view inproc_jobs
as select status, job_title, emp_name
from job
where status like 'IN PROCESS';
go

create view busiest_workers
as select top 1000 emp_name, count(job_title) [jobs]
from job
group by emp_name
order by [jobs] desc;
go

create view biggest_teams
as select top 1000
lead_name, department, members
from team
order by members desc;
go
select * from biggest_teams;