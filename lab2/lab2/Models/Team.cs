using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab2.Models
{
    [Table(Name = "team")]
    public class Team
    {
        private int _team_id;
        private string _lead_name;
        private string _department;
        private int _members;

        [Column(IsPrimaryKey =true, IsDbGenerated =true)]
        public int team_id
        {
            get { return _team_id; }
            set { _team_id = value; }
        }
        [Column]
        public string lead_name
        {
            get { return _lead_name; }
            set { _lead_name = value; }
        }
        [Column]
        public string department
        {
            get { return _department; }
            set { _department = value; }
        }
        [Column]
        public int members
        {
            get { return _members; }
            set { _members = value; }
        }

        public Team( string lead_name, string department, int members)
        {
            this.lead_name = lead_name;
            this.department = department;
            this.members = members;
        }

        public Team() { }
    }
}
