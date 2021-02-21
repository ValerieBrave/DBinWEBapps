using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2.Models
{
    [Table(Name = "job_status")]
    public class JobStatus
    {
        private string _status;

        [Column(IsPrimaryKey =true)]
        public string status
        {
            get { return _status; }
            set { _status = value; }
        }
        
        public JobStatus(string st)
        {
            this.status = st;
        }
        public JobStatus() { }
    }
}
