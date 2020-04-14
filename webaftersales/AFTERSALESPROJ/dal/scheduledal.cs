using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class scheduledal
    {
        public string id { get; set; }
        public string status { get; set; }
        public string servicing { get; set; }
        public string sdate { get; set; }
        public string callin { get; set; }
    }
    public class scheduledataaccesslayer
    {
        public static List<scheduledal> GetScheduleByCin(string cin)
        {
            List<scheduledal> li = new List<scheduledal>();
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                string str = "SELECT id,[STATUS],SERVICING,SDATE,CIN FROM SERVICINGTB WHERE CIN='" + cin + "' order by SERVICING asc";
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {
                    sqlcon.Open();
                    SqlDataReader dr = sqlcmd.ExecuteReader();
                    while (dr.Read())
                    {
                        scheduledal dal = new scheduledal();
                        dal.id = dr[0].ToString();
                        dal.status = dr[1].ToString();
                        dal.servicing = dr[2].ToString();
                        dal.sdate = dr[3].ToString();
                        dal.callin = dr[4].ToString();
                        li.Add(dal);
                    }

                }
            }
            return li;
        }
    }
}