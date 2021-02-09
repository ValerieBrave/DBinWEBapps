
create database execution_control;

use execution_control;
--3.	—оздать необходимые объекты базы данных Ц таблицы, индексы, представлени€.
--4.	—оздать необходимые программные объекты Ц процедуры, функции, триггеры дл€ работы с Ѕƒ.

---TABLES
create table job_status (
	status varchar(20) primary key
);

create table team (
	team_id int identity(1,1) primary key,
	lead_name varchar(100),
	department varchar(100),
	members int
);

create table employee (
	team_id int foreign key references team(team_id),
	emp_name varchar(100) primary key,
	position varchar(100)
);

create table job (
	job_id int identity(1,1) primary key,
	status varchar(20) foreign key references job_status(status),
	emp_name varchar(100) foreign key references employee(emp_name),
	job_title varchar(200),
	job_start datetime
);