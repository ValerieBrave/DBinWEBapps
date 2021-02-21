using lab2.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["EcontrolCon"].ConnectionString;
            
            DataContext db = new DataContext(connectionString);
            
            // entities lists
            Table<JobStatus> statuses = db.GetTable<JobStatus>();
            Table<Team> teams = db.GetTable<Team>();
            Table<Employee> employees = db.GetTable<Employee>();
            Table<Job> jobs = db.GetTable<Job>();

            //objects to add
            JobStatus new_status = new JobStatus("NEW STATUS");
            Team new_team = new Team("NEW TEAM LEAD", "UNKNOWN DEPARTMENT", 0);
            Employee new_employee = new Employee(1, "NEW EMPLOYEE", "unknown position");
            Job new_job = new Job("NEW STATUS", "NEW EMPLOYEE", "NEW JOB TITLE", DateTime.Now);

            //BEFORE CHANGES
            Console.WriteLine("Statuses before add:--------------------------");
            foreach (var stat in statuses) Console.WriteLine(stat.status);
            Console.WriteLine("Teams before add:-----------------------------");
            foreach (var t in teams) Console.WriteLine("{0}\t{1}\t{2}\t{3}", t.team_id, t.department, t.lead_name, t.members);
            Console.WriteLine("Employees before add:-----------------------------");
            foreach (var emp in employees) Console.WriteLine("{0}\t{1}\t{2}", emp.team_id, emp.emp_name, emp.position);
            Console.WriteLine("Jobs before add:-----------------------------");
            foreach (var j in jobs) Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}", j.job_id, j.job_title, j.status, j.job_start.ToString(), j.emp_name);
            
            //ADDING
            statuses.InsertOnSubmit(new_status); db.SubmitChanges();
            teams.InsertOnSubmit(new_team); db.SubmitChanges();
            employees.InsertOnSubmit(new_employee); db.SubmitChanges();
            jobs.InsertOnSubmit(new_job); db.SubmitChanges();

            //RESULTS
            Console.WriteLine("Statuses after add:--------------------------");
            foreach (var stat in statuses) Console.WriteLine(stat.status);
            Console.WriteLine("Teams after add:-----------------------------");
            foreach (var t in teams) Console.WriteLine("{0}\t{1}\t{2}\t{3}", t.team_id, t.department, t.lead_name, t.members);
            Console.WriteLine("Employees after add:-----------------------------");
            foreach (var emp in employees) Console.WriteLine("{0}\t{1}\t{2}", emp.team_id, emp.emp_name, emp.position);
            Console.WriteLine("Jobs after add:-----------------------------");
            foreach (var j in jobs) Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}", j.job_id, j.job_title, j.status, j.job_start.ToString(), j.emp_name);

            //UPDATING
            //no statuses because the only updatable column is primary key
            new_team.department = new_team.department + " XXX";
            new_employee.position = new_employee.position + " XXX";
            new_job.job_title = new_job.job_title + " XXX";
            db.SubmitChanges();

            //RESULTS
            Console.WriteLine("Teams after update:-----------------------------");
            foreach (var t in teams) Console.WriteLine("{0}\t{1}\t{2}\t{3}", t.team_id, t.department, t.lead_name, t.members);
            Console.WriteLine("Employees after update:-----------------------------");
            foreach (var emp in employees) Console.WriteLine("{0}\t{1}\t{2}", emp.team_id, emp.emp_name, emp.position);
            Console.WriteLine("Jobs after update:-----------------------------");
            foreach (var j in jobs) Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}", j.job_id, j.job_title, j.status, j.job_start.ToString(), j.emp_name);

            //DELETING
            jobs.DeleteOnSubmit(new_job); db.SubmitChanges();
            employees.DeleteOnSubmit(new_employee); db.SubmitChanges();
            teams.DeleteOnSubmit(new_team); db.SubmitChanges();
            statuses.DeleteOnSubmit(new_status); db.SubmitChanges();

            //RESULTS
            Console.WriteLine("Statuses after delete:--------------------------");
            foreach (var stat in statuses) Console.WriteLine(stat.status);
            Console.WriteLine("Teams after delete:-----------------------------");
            foreach (var t in teams) Console.WriteLine("{0}\t{1}\t{2}\t{3}", t.team_id, t.department, t.lead_name, t.members);
            Console.WriteLine("Employees after delete:-----------------------------");
            foreach (var emp in employees) Console.WriteLine("{0}\t{1}\t{2}", emp.team_id, emp.emp_name, emp.position);
            Console.WriteLine("Jobs after delete:-----------------------------");
            foreach (var j in jobs) Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}", j.job_id, j.job_title, j.status, j.job_start.ToString(), j.emp_name);

            //OVERDUE JOBS
            List<Job> overs = new List<Job> {
                new Job("NOT STARTED", "default worker", "overdue job 1", DateTime.Now),
                new Job("NOT STARTED", "default worker", "overdue job 2", DateTime.Now),
                new Job("NOT STARTED", "default worker", "overdue job 3", DateTime.Now)
            };
            foreach (var j in overs) jobs.InsertOnSubmit(j);
            db.SubmitChanges();

            var overdues = from j in jobs
                           where j.status == "NOT STARTED" 
                           && j.job_start < DateTime.Now
                           select j;
            Console.WriteLine("Overdue jobs-----------------------------");
            foreach (var o in overdues) Console.WriteLine("{0}\t{1}\t{2}\t{3}\t{4}", o.job_id, o.job_title, o.status, o.job_start.ToString(), o.emp_name);
            foreach (var o in overs) jobs.DeleteOnSubmit(o);
            db.SubmitChanges();

            Console.ReadKey();
        }
    }
}
