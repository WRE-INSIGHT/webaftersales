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
    public partial class createteam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {

                        getpersonnel();
                        getteams();
                    }
                }
                else
                {
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/loginPage.aspx");
            }
        }
        private void getpersonnel()
        {
            try
            {
                string str = "select pid,fullname from TBLpersonnel";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        personneldl.DataSource = sqlcmd.ExecuteReader();
                        personneldl.DataValueField = "PID";
                        personneldl.DataTextField = "FULLNAME";
                        personneldl.DataBind();
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
          
        }
        private void getteams()
        {
            try
            {
                DataSet ds = new DataSet();
                string str = "select * from(select "+
                             " TID,"+
                             " TEAMNAME,"+
                             " STUFF((SELECT CHAR(10) + ',' + FULLNAME FROM TBLteamMember as a"+
                             " left join tblpersonnel as b"+
                             " on a.PID = b.PID WHERE A.TID = D.TID"+
                             " FOR XML PATH('')),1,2,'') AS MEMBERS"+
                             " from TBLteam AS d) as tb where TEAMNAME like @key or MEMBERS like @key";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@key", "%" + keytbox.Text + "%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "TBLteamMember");
                        GridView2.DataSource = ds;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }

        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "valerror";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            getteams();
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            getteams();
        }
    }
}