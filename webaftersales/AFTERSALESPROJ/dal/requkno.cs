using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class requkno
    {
        public string id { get; set; }
        public string sid { get; set; }
        public string kno { get; set; }
        public string itemno { get; set; }
        public string location { get; set; }
        public string specification { get; set; }
        public string jo { get; set; }
        public string width { get; set; }
        public string height { get; set; }
        public List<requknoparts> thisparts
        {
            get
            {
                return reknoparts.getparts(this.id);
            }
        }

    }
    public class requknumber
    {
        public static List<requkno> getkno(string sid)
        {
            List<requkno> li = new List<requkno>();

            string str = "select " +
                            "  [ID]                " +
                            " ,[SID]			   " +
                            " ,[KNO]			   " +
                            " ,[ITEMNO]			   " +
                            " ,[LOCATION]		   " +
                            " ,[SPECIFICATION]	   " +
                            " ,[JO]				   " +
                            " ,[WIDTH]			   " +
                            " ,[HEIGHT]			   " +
                            " from [REPORTTB] where SID = @sid";
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {

                    sqlcon.Open();
                    sqlcmd.Parameters.AddWithValue("@sid", sid);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        requkno k = new requkno();
                        k.id = rd[0].ToString();
                        k.sid = rd[1].ToString();
                        k.kno = rd[2].ToString();
                        k.itemno = rd[3].ToString();
                        k.location = rd[4].ToString();
                        k.specification = rd[5].ToString();
                        k.jo = rd[6].ToString();
                        k.width = rd[7].ToString();
                        k.height = rd[8].ToString();
                        li.Add(k);
                    }
                }
            }
            return li;
        }
    }
}