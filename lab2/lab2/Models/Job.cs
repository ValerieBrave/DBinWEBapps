using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2.Models
{
    [Table(Name = "job")]
    public class Job
    {
        private int _job_id;
        private string _status;
        private string _emp_name;
        private string _job_title;
        private DateTime _job_start;

        [Column(IsPrimaryKey =true, IsDbGenerated =true)]
        public int job_id
        {
            get { return _job_id; }
            set { _job_id = value; }
        }
        [Column]
        public string status
        {
            get { return _status; }
            set { _status = value; }
        }
        [Column]
        public string emp_name
        {
            get { return _emp_name; }
            set { _emp_name = value; }
        }
        [Column]
        public string job_title
        {
            get { return _job_title; }
            set { _job_title = value; }
        }
        [Column]
        public DateTime job_start
        {
            get { return _job_start; }
            set { _job_start = value; }
        }

        public Job( string status, string emp_name, string job_title, DateTime job_start)
        {
            
            this.status = status;
            this.emp_name = emp_name;
            this.job_title = job_title;
            this.job_start = job_start;
        }
        public Job() { }
    }
}
