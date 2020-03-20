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
    public partial class reportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    lblproject.Text = Session["PROJECT"].ToString();
                    lbladdress.Text = Session["ADDRESS"].ToString();
                    lbljo.Text = Session["JO"].ToString();
                    lblcolor.Text = Session["COLOR"].ToString();
                    lbldate.Text = Session["DATE"].ToString();
                    getteam();
                }
            
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private string teamid
        {
            get
            {
                return Session["TEAMID"].ToString();
            }
        }
        private void getteam()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.Parameters.AddWithValue("@TID", teamid);
                    sqlcmd.CommandText = "stpgetteam";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    string teamname="", personnel="";
                    while (rd.Read())
                    {
                        teamname = rd[0].ToString();
                        personnel += rd[1].ToString()+ "<br />";
                    }
                    lblteamname.Text = teamname;
                    lblpersonnel.Text = personnel;
                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
            }
        }
    }
}