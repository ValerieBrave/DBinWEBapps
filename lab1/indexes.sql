use execution_control;
-- nonclustered indexes
create index lead_ind on team(lead_name);
create index emp_ind on employee(emp_name);
create index title_ind on job(job_title);