using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class Servicing_Report_Summary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        tboxSearch.Text = Request.QueryString["tboxSearch"] != null ? Request.QueryString["tboxSearch"].ToString() : "";
                        GridView1.PageIndex = Request.QueryString["gvPageIndex"] != null ? Convert.ToInt32(Request.QueryString["gvPageIndex"].ToString()) : 0;
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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void getdata()
        {
            try
            {
                DataTable tb = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Servicing_Report_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Callin");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        SqlDataAdapter da = new SqlDataAdapter { SelectCommand = sqlcmd };
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        lblRowNum.Text = tb.Rows.Count.ToString() + " row(s) found!";
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewReport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                Session["lblCIN"] = ((Label)row.FindControl("lblCIN")).Text;
                Response.Redirect("~/AFTERSALESPROJ/Servicing_Report_SummaryRPT.aspx" + AddQuerystring);
            }
        }
        private string AddQuerystring
        {
            get
            {
                return "?tboxSearch=" + tboxSearch.Text.ToString() +
                    "&gvPageIndex=" + GridView1.PageIndex.ToString();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}