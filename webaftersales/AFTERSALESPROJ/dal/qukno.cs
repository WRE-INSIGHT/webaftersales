﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class qukno
    {
        public string id { get; set; }
        public string aseno { get; set; }
        public string itemno { get; set; }
        public string kno { get; set; }
        public string location { get; set; }
        public string netprice { get; set; }
        public string vat_amount { get; set; }
        public List<quknoparts> thisparts
        {
            get
            {
                return knoparts.getparts(this.id);
            }
        }
    
    }
   
    public class knumber
    {
        public static List<qukno> getkno(string ase)
        {
            List<qukno> li = new List<qukno>();

            string str = "select " +
                            " ID," +
                            " ASENO," +
                            " ITEM," +
                            " KNO AS[K#]," +
                            " WDWLOC as [WDW / DOOR LOCATION], " +
                            " NETPRICE, " +
                             " VAT_AMOUNT " +
                            " from itemtb where aseno = @aseno order by item asc";
         
            using (SqlConnection sqlcon = new SqlConnection(ConnectionString.sqlconstr()))
            {
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {

                    sqlcon.Open();
                    sqlcmd.Parameters.AddWithValue("@aseno", ase);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        qukno k = new qukno();
                        k.id = rd[0].ToString();
                        k.aseno = rd[1].ToString();
                        k.itemno = rd[2].ToString();
                        k.kno = rd[3].ToString();
                        k.location = rd[4].ToString();
                        k.netprice = rd[5].ToString();
                        k.vat_amount = rd[6].ToString();
                        li.Add(k);
                    }
                }
            }
            return li;
        }
    }
}
