using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace webaftersales.AFTERSALESPROJ.dal
{
    public class servicedal
    {
        public string status { set; get; }
        public string cin { set; get; }
        public string cdate { set; get; }
        public string jo { set; get; }
        public string project { set; get; }
        public string fulladd { set; get; }
        public string caller { set; get; }
        public string pid { set; get; }
        public string useracct { set; get; }
        public List<scheduledal> schedule
        {
            get
            {
                return scheduledataaccesslayer.GetScheduleByCin(this.cin,this.pid,this.useracct);
            }
        }

    }
    public class servicedataaccesslayer
    {
        public static List<servicedal> GetService(string key,string pid,string useracct)
        {

            List<servicedal> li = new List<servicedal>();
   
            using (SqlConnection sqlcon = new SqlConnection(ConnectionString.sqlconstr()))
            {
                string str;
                if (useracct == "Admin")
                {
                    str = "select A.STATUS,CIN,CDATE,JO,PROJECT_LABEL,FULLADD,CALLER from callintb as a " +
                             "left join kmdidata.dbo.ADDENDUM_TO_CONTRACT_TB as b " +
                             "on a.jo = b.job_order_no " +
                             "where a.cin in (select cin from SERVICINGTB) and " +
                             "(PROJECT_LABEL like '%" + key + "%' or cin like '%" + key + "%' or fulladd like '%" + key + "%' or CDATE like '%" + key + "%' or a.status like  '%" + key + "%' or caller like '%" + key + "%') " +
                             "ORDER BY CIN DESC";
                }
                else
                {
                    str = "select A.STATUS,CIN,CDATE,JO,PROJECT_LABEL,FULLADD,CALLER from callintb as a " +
                             "left join kmdidata.dbo.ADDENDUM_TO_CONTRACT_TB as b " +
                             "on a.jo = b.job_order_no " +
                             "where a.cin in (select cin from SERVICINGTB where TEAMID in (select tid from tblteamMember where PID = @pid)) and " +
                             "(PROJECT_LABEL like '%" + key + "%' or cin like '%" + key + "%' or fulladd like '%" + key + "%' or CDATE like '%" + key + "%' or a.status like  '%" + key + "%' or caller like '%" + key + "%') " +
                             "ORDER BY CIN DESC";
                }
            
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {
                    sqlcon.Open();
                    sqlcmd.Parameters.AddWithValue("@pid", pid);
                    
                    SqlDataReader dr = sqlcmd.ExecuteReader();
                    while (dr.Read())
                    {
                        servicedal dal = new servicedal();
                        dal.status = dr[0].ToString();
                        dal.cin = dr[1].ToString();
                        dal.cdate = dr[2].ToString();
                        dal.jo = dr[3].ToString();
                        dal.project = dr[4].ToString();
                        dal.fulladd = dr[5].ToString();
                        dal.caller = dr[6].ToString();
                        dal.useracct = useracct;
                        dal.pid = pid;
                        li.Add(dal);
                    }
                }
            }
            return li;
        }
    }

}