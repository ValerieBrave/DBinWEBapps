using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [SqlProcedure]
    public static void ToDoJobs (DateTime now)
    {
        SqlCommand command = new SqlCommand();
        command.Connection = new SqlConnection("Context connection = true");
        command.Connection.Open();
        command.CommandText = @"SELECT job_id, job_title, job_start 
                                    from job 
                                    where  job_start > convert(datetime,@now,120)";
        SqlParameter parameter = command.Parameters.Add("@now", SqlDbType.DateTime);
        parameter.Value = now;
        SqlContext.Pipe.ExecuteAndSend(command);
        command.Connection.Close();
    }
}
