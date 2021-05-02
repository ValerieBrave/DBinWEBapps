use execution_control
go
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--USE TUTORIAL https://docs.microsoft.com/en-us/sql/relational-databases/tables/lesson-2-creating-and-managing-data-in-a-hierarchical-table?view=sql-server-ver15
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
----------
alter table employee
add hid hierarchyid

alter table employee
add h_level as hid.GetLevel()

select * from employee where position like '%senior%'
select h_level from employee
update team set department='administration', lead_name='Director' where team_id =5

--MAIN DUDE
insert into employee(team_id, emp_name, position, hid)
values(5, 'Director', 'director', hierarchyid::GetRoot())

--TEAM LEADS follow MAIN DUDE
go
DECLARE @director hierarchyid   
SELECT @director = hierarchyid::GetRoot()  
FROM employee 
update employee set hid = @director.GetDescendant(NULL, NULL) where emp_name like 'Aleksey Petrov'
update employee set hid = @director.GetDescendant(NULL, NULL) where emp_name like 'Carlos Santana'
update employee set hid = @director.GetDescendant(NULL, NULL) where emp_name like 'Jane Doe'
update employee set hid = @director.GetDescendant(NULL, NULL) where emp_name like 'Joanna Scully'

--PROCEDURE TO SHOW HEIRARCHY FROM GIVEN LEVEL
go
CREATE PROCEDURE SelectRoot(@level int)    
AS   
BEGIN  
   select hid.ToString(), * from employee where hid.GetLevel() = @level;
END;
  
GO  
exec SelectRoot 2;


go
--PROCEDURE FOR ADDING EMPLOYEES
CREATE PROC AddEmp(@boss_name varchar(100), @team_id int, @emp_name varchar(100), @position varchar(100))
as begin
	DECLARE @bossOrgNode hierarchyid, @lc hierarchyid  
	SELECT @bossOrgNode = hid  --boss level
	FROM employee   
	WHERE emp_name = @boss_name  

	SELECT @lc = max(hid)   
    FROM employee   
    WHERE hid.GetAncestor(1) =@bossOrgNode

	insert into employee(team_id, emp_name, position, hid)
	values(@team_id, @emp_name, @position, @bossOrgNode.GetDescendant(@lc, NULL))
end
go

select * from employee
exec AddEmp 'Carlos Santana', 4, 'santana sub employee', 'sub sub'	--works


--PROCEDURE FOR MOVING BRANCHES
go
CREATE PROCEDURE MovRoot(@old_uzel varchar(100), @new_uzel varchar(100) )
AS  
BEGIN  
DECLARE @nold hierarchyid, @nnew hierarchyid  
SELECT @nold = hid FROM employee WHERE emp_name = @old_uzel ;  
  
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE  
BEGIN TRANSACTION  
SELECT @nnew = hid FROM employee WHERE emp_name = @new_uzel ; 
  
SELECT @nnew = @nnew.GetDescendant(max(hid), NULL)   
FROM employee WHERE hid.GetAncestor(1)=@nnew ; 
UPDATE employee   
SET hid = hid.GetReparentedValue(@nold, @nnew)   
WHERE hid.IsDescendantOf(@nold) = 1 ;   
 commit;
  END ;  
GO  

exec MovRoot 'santana sub employee', 'Aleksey Petrov'


go
declare @CurrentEmployee hierarchyid
select @CurrentEmployee = hid from employee where emp_name like 'Aleksey Petrov'
SELECT *  
FROM employee  
WHERE hid.IsDescendantOf(@CurrentEmployee ) = 1

--PREPARATIONS BEFORE LAB DEFENCE
delete employee where emp_name like 'santana sub emloyee'
delete employee where emp_name like 'sub emloyee'
delete employee where emp_name like 'Director'
update employee set hid = null