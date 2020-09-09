using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class requknoparts
    {
        public string id { get; set; }
        public string iid { get; set; }
        public string articleno { get; set; }
        public string description { get; set; }
        public string qty { get; set; }
        public string unitprice { get; set; }
    }
    public class reknoparts
    {
        public static List<requknoparts> getparts(string iid)
        {
            List<requknoparts> li = new List<requknoparts>();


            string str = " select" +
                    " ID," +
                    " IID," +
                    " ARTICLENO," +
                    " DESCRIPTION," +
                    " QTY," +
                    " UNITPRICE" +
                    " from [quotationrequesttbl] where iid = @iid";
       
            using (SqlConnection sqlcon = new SqlConnection(ConnectionString.sqlconstr()))
            {
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {

                    sqlcon.Open();
                    sqlcmd.Parameters.AddWithValue("@iid", iid);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        requknoparts p = new requknoparts();
                        p.id = rd[0].ToString();
                        p.iid = rd[1].ToString();
                        p.articleno = rd[2].ToString();
                        p.description = rd[3].ToString();
                        p.qty = rd[4].ToString();
                        p.unitprice = rd[5].ToString();
                        li.Add(p);
                    }
                }
            }
            return li;
        }
    }
}