using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab11
{
    class Program
    {
        static void Main(string[] args)
        {
            SQLiteConnection sqlite_conn;
            // Create a new database connection:
            sqlite_conn = 
                new SQLiteConnection("Data Source=sqlite_db.db; Version = 3; New = True; Compress = True; ");
            try
            {
                sqlite_conn.Open();
                SQLiteDataReader sqlite_datareader;
                SQLiteCommand sqlite_cmd;
                sqlite_cmd = sqlite_conn.CreateCommand();
                sqlite_cmd.CommandText = "SELECT * FROM my_view";
                sqlite_datareader = sqlite_cmd.ExecuteReader();
                while (sqlite_datareader.Read())
                {
                    string myreader = sqlite_datareader.GetString(0);
                    Console.WriteLine(myreader);
                }
                Console.WriteLine("INSERT INTO VIEW");
                //------------------------------------
                SQLiteCommand sqlite_cmd1 = sqlite_conn.CreateCommand();
                sqlite_cmd1.CommandText = "INSERT INTO my_view(string, real) VALUES('GGGG', 5.6); ";
                sqlite_cmd1.ExecuteNonQuery();
                //------------------------------------
                Console.WriteLine("AUDIT");
                SQLiteCommand sqlite_cmd2 = sqlite_conn.CreateCommand();
                sqlite_cmd2.CommandText = "SELECT * FROM Audit";
                sqlite_datareader = sqlite_cmd2.ExecuteReader();
                while (sqlite_datareader.Read())
                {
                    string myreader = sqlite_datareader.GetString(0);
                    Console.WriteLine(myreader);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("${ex}", ex);
            }
            Console.ReadKey();
        }
    }
}
