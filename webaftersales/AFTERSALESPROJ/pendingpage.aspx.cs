using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class pendingpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["pendingsearch"] != null)
                        {
                            searchtbox.Text = Session["pendingsearch"].ToString();
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
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "stpPending";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@project", searchtbox.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "tb");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "report")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = ((Label)row.Cells[0].FindControl("cidlbl")).Text;
                Session["SID"] = ((Label)row.Cells[0].FindControl("idlbl")).Text;
                Session["JO"] = ((Label)row.Cells[0].FindControl("jolbl")).Text;
                Session["PROJECT"] = ((LinkButton)row.Cells[0].FindControl("projectlbl")).Text;
                Session["ADDRESS"] = ((Label)row.Cells[0].FindControl("addresslbl")).Text;
                Session["COLOR"] = ((Label)row.Cells[0].FindControl("colorlbl")).Text;
                Session["DATE"] = ((Label)row.Cells[0].FindControl("datelbl")).Text;
                Session["TEAMID"] = ((Label)row.Cells[0].FindControl("teamlbl")).Text;
                Session["pendingSOURCE"] = true;
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["pendingsearch"] = searchtbox.Text;
            getdata();
        }

        protected void searcbtn_Click(object sender, EventArgs e)
        {
            Session["pendingsearch"] = searchtbox.Text;
            getdata();
        }
    }
}