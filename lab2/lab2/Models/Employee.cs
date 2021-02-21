using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2.Models
{
    [Table(Name="employee")]
    public class Employee
    {
        private int _team_id;
        private string _emp_name;
        private string _position;
        [Column]
        public int team_id 
        {
            get { return _team_id; }
            set { _team_id = value; }
        }
        [Column(IsPrimaryKey =true)]
        public string emp_name 
        {
            get { return _emp_name; }
            set { _emp_name = value; }
        }
        [Column]
        public string position 
        { 
            get { return _position; }
            set { _position = value; }
        }

        public Employee(int team_id, string emp_name, string position)
        {
            this.team_id = team_id;
            this.emp_name = emp_name;
            this.position = position;
        }

        public Employee() { }
    }
}
