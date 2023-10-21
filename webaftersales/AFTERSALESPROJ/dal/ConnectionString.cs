using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class ConnectionString
    {
        static string con = string.Empty;
        static string con1 = string.Empty;
        public static string getConnectionString(string server)
        {
            string connectionstring = string.Empty;     
            switch (server)
            {
                case "server1":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlcon_server1_asdb"].ConnectionString;     
                    break;
                case "server2":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlcon_server2_asdb"].ConnectionString;
                    break;
                default:
                    break;
            }
            con = connectionstring;
            return connectionstring;
        }
        public static string getConnectionString1(string server)
        {
     
            string connectionstring1 = string.Empty;
            switch (server)
            {
                case "server1": 
                    connectionstring1 = ConfigurationManager.ConnectionStrings["sqlcon_server1_kmdidata"].ConnectionString;
                    break;
                case "server2":
                    connectionstring1 = ConfigurationManager.ConnectionStrings["sqlcon_server2_kmdidata"].ConnectionString;
                    break;
                default:
                    break;
            }
            con1 = connectionstring1;
            return connectionstring1;
        }
        public static string sqlconstr()
        {

            return con;
        }
        public static string sqlconstr1()
        {

            return con1;
        }
    }
}
