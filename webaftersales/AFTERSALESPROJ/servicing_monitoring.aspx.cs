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
    public partial class servicing_monitoring : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        retrieve_sessions();
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
        private void retrieve_sessions()
        {
            if (Session["s_monitoring_search"] != null)
            {
                tboxSearch.Text = Session["s_monitoring_search"].ToString();
            }
            if (Session["s_monitoring_status"] != null)
            {
                ddlStatus.Text = Session["s_monitoring_status"].ToString();
            }
            if (Session["s_monitoring_sdate"] != null)
            {
                tboxSdate.Text = Session["s_monitoring_sdate"].ToString();
            }
            if (Session["s_monitoring_edate"] != null)
            {
                tboxEdate.Text = Session["s_monitoring_edate"].ToString();
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
             
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        if (Session["s_monitoring_pageindex"] != null)
                        {
                            var x = Convert.ToInt32(Session["s_monitoring_pageindex"].ToString());
                            GridView1.PageIndex = x;
                        }
                        DataSet ds = new DataSet();
                        ds.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Servicing_Monitoring_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                        Session["s_monitoring_search"] = tboxSearch.Text;
                        Session["s_monitoring_status"] = ddlStatus.Text;
                        Session["s_monitoring_sdate"] = tboxSdate.Text;
                        Session["s_monitoring_edate"] = tboxEdate.Text;


                        lblRowNum.Text = ds.Tables[0].Rows.Count.ToString() + " row(s) found!";
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["s_monitoring_pageindex"] = 0;
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["s_monitoring_pageindex"] = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "showReport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = ((Label)row.Cells[0].FindControl("cidlbl")).Text;
                Session["SID"] = ((Label)row.Cells[0].FindControl("idlbl")).Text;
                Session["JO"] = ((Label)row.Cells[0].FindControl("parentjolbl")).Text;
                Session["PROJECT"] = ((LinkButton)row.Cells[0].FindControl("LinkButton2")).Text;
                Session["ADDRESS"] = ((Label)row.Cells[0].FindControl("lblAddress")).Text;
                Session["COLOR"] = ((Label)row.Cells[0].FindControl("colorlbl")).Text;
                Session["DATE"] = ((Label)row.Cells[0].FindControl("datelbl")).Text;
                Session["TEAMID"] = ((Label)row.Cells[0].FindControl("teamlbl")).Text;
                Session["servicing_page_SOURCE"] = "Monitoring";
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
        }
    }
}