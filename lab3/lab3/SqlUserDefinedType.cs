using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using Microsoft.SqlServer.Server;


[Serializable]
[SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
public struct JobDescription: INullable, IBinarySerialize
{
    string status;
    string title;
    public override string ToString()
    {
        return $"Status: {this.status}, Title: {this.title}";
    }
    
    public bool IsNull
    {
        get
        {
            return _null;
        }
    }
    
    public static JobDescription Null
    {
        get
        {
            JobDescription h = new JobDescription();
            h._null = true;
            return h;
        }
    }
    
    public static JobDescription Parse(SqlString s)
    {
        if (s.IsNull)
            return Null;
        string[] param = s.Value.Split(',');
        JobDescription u = new JobDescription();
        u.status = param[0];
        u.title = param[1];
        return u;
    }
    
    // Это метод-заполнитель
    public string Method1()
    {
        return string.Empty;
    }
    
    public static SqlString Method2()
    {
        return new SqlString("");
    }

    public void Read(BinaryReader r)
    {
        status = r.ReadString();
    }

    public void Write(BinaryWriter w)
    {
        w.Write(status.ToString() + " - " + title.ToString());
    }

    // Это поле элемента-заполнителя
    public int _var1;
 
    // Закрытый член
    private bool _null;
}