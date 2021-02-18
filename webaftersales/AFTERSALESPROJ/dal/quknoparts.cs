using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class quknoparts
    {
        public string id { get; set; }
        public string iid { get; set; }
        public string articleno { get; set; }
        public string description { get; set; }
        public string markup { get; set; }
        public string unitprice { get; set; }
        public string qty { get; set; }
        public string netamount { get; set; }
        public string vat_amount { get; set; }
    }
    public class knoparts
    {
        public static List<quknoparts> getparts(string knoid)
        {
            List<quknoparts> li = new List<quknoparts>();


            string str = " select" +
                    " ID," +
                    " IID," +
                    " ARTICLENO as [ARTICLE NO]," +
                    " DESCRIPTION," +
                    " MARKUP," +
                    " UNITPRICE AS[UNIT PRICE]," +
                    " QTY," +
                    " NETAMOUNT AS[NET AMOUNT], " +
                    " Vat_amount "+
                    " from partstb where iid = @iid";
       
            using (SqlConnection sqlcon = new SqlConnection(ConnectionString.sqlconstr()))
            {
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {

                    sqlcon.Open();
                    sqlcmd.Parameters.AddWithValue("@iid", knoid);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        quknoparts p = new quknoparts();
                        p.id = rd[0].ToString();
                        p.iid = rd[1].ToString();
                        p.articleno = rd[2].ToString();
                        p.description = rd[3].ToString();
                        p.markup = rd[4].ToString();
                        p.unitprice = rd[5].ToString();
                        p.qty = rd[6].ToString();
                        p.netamount = rd[7].ToString();
                        p.vat_amount = rd[8].ToString();
                        li.Add(p);
                    }
                }
            }
            return li;
        }
    }
}