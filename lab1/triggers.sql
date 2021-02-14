use execution_control;
go

create trigger EMP_INSERT on employee after insert 
as
	declare @team int = (select team_id from inserted)
	update team
	set members = members+1
	where team_id like @team;
return
go
create trigger EMP_DELETE on employee after delete 
as
	declare @team int = (select team_id from deleted)
	update team
	set members = members-1
	where team_id like @team;
return
go
create trigger EMP_UPDATE on employee after update
as
	declare @old_team int = (select team_id from deleted)
	declare @new_team int = (select team_id from inserted)
	if @old_team != @new_team
		update team set members = members + 1 where team_id like @new_team
		update team set members = members - 1 where team_id like @old_team
return



insert into employee(team_id, emp_name, position)
values(2, 'trigger test', 'trigger test')
delete employee where emp_name like 'trigger test';
update employee set team_id =1 where emp_name like 'trigger test';
select * from employee;
select * from team;
