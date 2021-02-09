use execution_control;
--создание
go
create procedure new_job @title varchar(200), @start datetime
as
begin
	insert into job(status, emp_name, job_title, job_start)
	values('default', 'default worker', @title, @start);
	print 'new job '+@title+' added';
end
--drop procedure new_job;
exec new_job @title='testing procedure 2', @start = '20210207 09:00:00 AM';
select * from job;


go
create procedure new_team @department varchar(100)
as
begin
	insert into team(lead_name, department, members)
	values('default lead', @department, 0);
	print 'new team of '+@department+' added';
end

exec new_team @department='architecture';
select * from team;
select * from employee;
delete team where  team_id=6;

go
create procedure new_employee @emp_name varchar(100), @position varchar(100)
as
begin
	insert into employee(team_id, emp_name, position)
	values(5, @emp_name, @position);
	print 'new employee '+@emp_name+' '+@position+' added';
end

exec new_employee @emp_name='Valeria Smelova', @position='junior developer';
select * from employee;

--изменение заданий
go
create procedure set_assignee @id int, @emp_name varchar(100)
as
declare @title varchar(200);
begin
	update job
	set emp_name = @emp_name
	where job_id like @id;
	set @title = (select job_title from job where job_id like @id);
	print @emp_name +' was set as assignee for job '+ cast(@id as varchar(6))+' '+@title;
end
exec set_assignee @id=24, @emp_name = 'Jessica Maddock';
--drop procedure set_assignee;
go
create procedure set_status @id int, @stat varchar(20)
as
declare @title varchar(200);
begin
	update job
	set status = @stat
	where job_id like @id;
	set @title = (select job_title from job where job_id like @id); 
	print cast(@id as varchar(6))+' '+@title+' job status was set to '+@stat;
end

exec set_status @id =22, @stat = 'IN PROCESS';

go
create procedure set_start @id int, @start datetime
as
declare @title varchar(200);
begin
	update job
	set job_start = @start
	where job_id = @id;
	set @title = (select job_title from job where job_id like @id); 
	print cast(@id as varchar(6))+' '+@title+' job start time was set to '+cast(@start as varchar(20));
end

select * from job;
exec set_start @id=21, @start = '20210206 07:00:00 PM';

--изменение сотрудников
go
create procedure add_to_team @emp_name varchar(100), @id int
as
declare @dept varchar(100);
declare @rows int;
begin
	update employee
	set team_id = @id
	where emp_name = @emp_name;
	select @rows = @@ROWCOUNT;
	set @dept = (select department from team where team_id like @id);
	
	if @rows = 0 
		print 'employee '+@emp_name + ' not found';
	else
		print 'employee '+@emp_name + ' was added to team '+cast(@id as varchar(4))+' '+@dept;
		
end
--drop procedure add_to_team;
select * from employee;
select * from team;
exec add_to_team @emp_name = 'Valeria Smelova', @id = 5;

go
create procedure set_position @emp_name varchar(100), @position varchar(100)
as
declare @rows int;
begin
	update employee
	set position = @position
	where emp_name = @emp_name;
	select @rows = @@ROWCOUNT;
	if @rows = 0 
		print 'employee '+@emp_name + ' not found';
	else
		print 'employee '+@emp_name + ' position was set to '+@position;
end
select * from employee;
exec set_position @emp_name = 'Valeria Smelova', @position = 'senior developer';

--удаление
go
create procedure delete_team @id int
as
declare @rows int;
begin
	delete team where team_id like @id;
	select @rows = @@ROWCOUNT;
	if @rows = 0 
		print 'team '+cast(@id as varchar(3)) + ' cant be deleted';
	else
		print 'team '+cast(@id as varchar(3)) + ' deleted';
end
--drop procedure delete_team;
select * from biggest_teams;
exec delete_team @id =3;

go
create procedure delete_job @id int
as
declare @rows int;
declare @title varchar(200);
begin
	set @title = (select job_title from job where job_id like @id);
	delete job where job_id like @id;
	select @rows = @@ROWCOUNT;
	if @rows = 0
		print 'job '+cast(@id as varchar(3)) + ' not found';
	else
		print 'job ' + cast(@id as varchar(3))+' '+@title + ' deleted';
end
select * from job;
exec delete_job @id = 25;

go
create procedure delete_employee @emp_name varchar(100)
as
declare @rows int;
begin
	delete employee where emp_name like @emp_name;
	select @rows = @@ROWCOUNT;
	if @rows = 0
		print 'employee '+@emp_name +' not found';
	else
		print 'employee '+@emp_name +' deleted';
end