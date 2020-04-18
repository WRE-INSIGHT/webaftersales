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
    public partial class CallinPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["callinserachkey"] != null)
                        {
                            callinkey.Text = Session["callinserachkey"].ToString();
                        }
                        getdata();
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
        private void getdata()
        {
            DataSet ds = new DataSet();
            ds.Clear();
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "stdCallin";
                    sqlcmd.Parameters.AddWithValue("@key", callinkey.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "tb");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["callinserachkey"] = callinkey.Text;
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }

}