use execution_control;

insert into job_status(status)
values ('NOT STARTED'), ('IN PROCESS'), ('FINISHED'), ('ON REVIEW'), ('default');
select * from job_status;


insert into team(lead_name, department, members)
values ('Carlos Santana', 'testing', 5),
		('Jane Doe', 'marketing', 3),
		('Joanna Scully', 'design', 4),
		('Aleksey Petrov', 'software development', 5);
insert into team(lead_name, department, members)
values ('default lead', 'default department', 0);
select * from team;


insert into employee(team_id, emp_name, position)
values (1, 'Carlos Santana', 'team lead'),
		(2, 'Jane Doe', 'team lead'),
		(3, 'Joanna Scully', 'team lead'),
		(4, 'Aleksey Petrov', 'team lead');
insert into employee(team_id, emp_name, position)
values (1, 'Fox Mulder', 'junior tester'), (1, 'Peter Hale', 'junior tester'), 
		(1, 'Dana Kelly', 'senior tester'), (1, 'Judy Danch', 'senior tester');
insert into employee(team_id, emp_name, position)
values (2, 'Malia Hale', 'assistant marketer'), (2, 'Scott McCall', 'senior marketer');
insert into employee(team_id, emp_name, position)
values (3, 'Helen Hunt', 'junior designer'), (3, 'Katy Pale', 'senior designer'),
		(3, 'Samantha Riley', 'senior designer');
insert into employee(team_id, emp_name, position)
values (4, 'Vasiliy Terkin', 'junior developer'), (4, 'Tony Blinkin', 'senior developer'),
		(4, 'Jessica Maddock', 'senior developer'), (4, 'Lary Croft', 'senior developer');
insert into employee(team_id, emp_name, position)
values (5, 'default worker', 'default position');
select * from employee;


insert into job(status, emp_name, job_title, job_start)
values ('NOT STARTED', 'Vasiliy Terkin', 'production server configuration', '20210212 10:00:00 AM'),
	   ('IN PROCESS', 'Katy Pale', 'main page layout', '20210205 05:00:00 PM'),
	   ('FINISHED', 'Malia Hale', 'advertisment company report', '20210207 07:00:00 PM'),
	   ('ON REVIEW', 'Jessica Maddock', 'database connection pool', '20210204 10:00:00 AM');
insert into job(status, emp_name, job_title, job_start)
values ('IN PROCESS', 'Katy Pale', 'login page style', '20210207 09:00:00 AM');