using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                getdata();
              
            }

        }
        private void getdata()
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select * from reporttb",sqlcon);
//                SqlCommand sqlcmd = new SqlCommand("SELECT * FROM ("+
//"  select"+
//"   a.ID, "+
//"   a.sdate as [DATE], "+
//"   a.SERVICING, "+
//"   c.PROJECT_LABEL AS PROJECT, "+
//"   c.FULLADD AS[ADDRESS] from"+
//"  ((SERVICINGTB as a"+
//"  left join CALLINTB as b"+
//"  on a.CIN = b.CIN)"+
//"  left join heretosave.dbo.ADDENDUM_TO_CONTRACT_TB as c"+
//"  on b.jo = c.JOB_ORDER_NO)) AS TB"+
//"  where project like '%%'", sqlcon);
                GridView1.DataSource = sqlcmd.ExecuteReader();
                GridView1.DataBind();
            }
            //try
            //{
            //    DataSet ds = new DataSet();
            //    ds.Clear();
            //    string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
            //    using (SqlConnection sqlcon = new SqlConnection(cs))
            //    {
            //        sqlcon.Open();
            //        SqlCommand sqlcmd = sqlcon.CreateCommand();
            //        sqlcmd.CommandText = "stpServicing";
            //        sqlcmd.CommandType = CommandType.StoredProcedure;
            //        sqlcmd.Parameters.AddWithValue("@project", "");
            //        SqlDataAdapter da = new SqlDataAdapter();
            //        da.SelectCommand = sqlcmd;
            //        da.Fill(ds, "tb");
            //        GridView1.DataSource = ds;
            //        GridView1.DataBind();
            //    }
            //}
            //catch (Exception e)
            //{
            //    Response.Write(e.ToString());
            //}
        }

       
    }
}
