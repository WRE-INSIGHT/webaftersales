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
    public partial class callin_monitoring : System.Web.UI.Page
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
            if (Session["c_monitoring_search"] != null)
            {
                tboxSearch.Text = Session["c_monitoring_search"].ToString();
            }
            if (Session["c_monitoring_status"] != null)
            {
                ddlStatus.Text = Session["c_monitoring_status"].ToString();
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
                        if (Session["c_monitoring_pageindex"] != null)
                        {
                            var x = Convert.ToInt32(Session["c_monitoring_pageindex"].ToString());
                            GridView1.PageIndex = x;
                        }
                        sqlcon.Open();
                        sqlcmd.CommandText = "Callin_Monitoring_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@Status", ddlStatus.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        Session["c_monitoring_search"] = tboxSearch.Text;
                        Session["c_monitoring_status"] = ddlStatus.Text;
                      
                        lblRowNum.Text = tb.Rows.Count.ToString() + " row(s) found!";
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
            Session["c_monitoring_pageindex"] = 0;
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["c_monitoring_pageindex"] = e.NewPageIndex;
            getdata();
           
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "showServicing")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                if (((GridView)row.FindControl("Gridview2")).Visible == true)
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = false;
                }
                else
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = true;
                }
                showServicing(((Label)row.FindControl("lblCin")).Text, ((GridView)row.FindControl("Gridview2")));
            }
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewreport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("lblg2Id")).Text;
                Session["CIN"] = ((Label)row.FindControl("lblg2Cin")).Text;
                getdetails(Session["CIN"].ToString());
            }
            else if (e.CommandName == "viewphoto")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("lblg2Id")).Text;
                Session["CIN"] = ((Label)row.FindControl("lblg2Cin")).Text;
                Session["link"] = "s1";
                Response.Redirect("~/AFTERSALESPROJ/sidgalleryPage.aspx");
            }

        }
        private void getdetails(string callin)
        {

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                string str = "select A.STATUS,CIN,CDATE,JO,PROJECT_LABEL,FULLADD,PROFILE_FINISH from callintb as a " +
                         "left join kmdidata.dbo.ADDENDUM_TO_CONTRACT_TB as b " +
                         "on a.jo = b.job_order_no " +
                         "where a.cin = '" + callin + "'";
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {
                    sqlcon.Open();
                    SqlDataReader rdr = sqlcmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        Session["PROJECT"] = rdr[4].ToString();
                        Session["ADDRESS"] = rdr[5].ToString();
                        Session["COLOR"] = rdr[6].ToString();
                    }
                    Session["link"] = "s1";
                    Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
                }
            }
        }
        private void showServicing(string cin, GridView gv)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Callin_Monitoring_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Servicing");
                        sqlcmd.Parameters.AddWithValue("@Cin", cin);
                        SqlDataAdapter da = new SqlDataAdapter();
                        DataTable tb = new DataTable();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        gv.DataSource = tb;
                        gv.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
    }
}