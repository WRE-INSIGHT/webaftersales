using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class manageAccountsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null && Session["useraccount"].ToString() == "Admin")
            {
                if (!IsPostBack)
                {
                    getrequestdata();
                    getuserdata();
                
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }

        }
        private void getrequestdata()
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
                    sqlcmd.CommandText = "[stpmanageaccount]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@datatype", "requestdata");
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "ACCTTB");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
            }
        }
        private void getuserdata()
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
                    sqlcmd.CommandText = "[stpmanageaccount]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@datatype", "userdata");
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "ACCTTB");
                    GridView2.DataSource = ds;
                    GridView2.DataBind();
                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["id"] = ((Label)row.FindControl("Label1")).Text;
                Response.Write(ViewState["id"].ToString());


            }
            else if (e.CommandName == "myverification")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["id"] = ((Label)row.FindControl("Label1")).Text;
                Label2.Text = ViewState["id"].ToString();
                getpersonnel();
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "fncsave();", true);
            }
        }
        protected void savebtnclick(object sender, EventArgs e)
        {
            Label2.Text = ViewState["id"].ToString();
        }
        private void getpersonnel()
        {

            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand("select * from tblpersonnel", sqlcon))
                    {
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "tlpersonnel");
                        personneldl.DataSource = ds;
                        personneldl.DataValueField = "pid";
                        personneldl.DataTextField = "Fullname";
                        personneldl.DataBind();
                    }
                }
            }
            catch (Exception e)
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "fncsave();", true);
            }
        }

    }
}