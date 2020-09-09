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
    public partial class cleaningForapproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["cleaning_searchkey"] != null)
                        {
                            tboxsearchkey.Text = Session["cleaning_searchkey"].ToString();
                        }
                        if (Session["cleaning_cbox"] != null)
                        {
                            CheckBox1.Checked = Convert.ToBoolean(Session["cleaning_cbox"]);
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
        private void getdata()
        {
            try
            {
                

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        string c = "0";
                        if (CheckBox1.Checked)
                        {
                            c = "1";
                        }
                        sqlcmd.CommandText = "stp_cleaning_forapproval";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@searchkey", tboxsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@forapproval", c);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        lblcountrow.Text = tb.Rows.Count.ToString() + " resul(s)";

                        Session["cleaning_searchkey"] = tboxsearchkey.Text;
                        Session["cleaning_cbox"] = CheckBox1.Checked;
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
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "mycleaning")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                Session["cleaningdate"] = ((Label)row.FindControl("datelbl")).Text;
                Session["cleaningqno"] = ((Label)row.FindControl("lblqno")).Text;
                Session["cleaningid"] = ((Label)row.FindControl("lblid")).Text;

                Session["CIN"] = ((Label)row.FindControl("lblcin")).Text;
                Session["SID"] = ((Label)row.FindControl("lblsid")).Text;
          
                Session["PROJECT"] = ((LinkButton)row.FindControl("projectlbl")).Text;
                Session["ADDRESS"] = ((Label)row.FindControl("addresslbl")).Text;
                Session["cleaning_report_sender"] = "forapproval";
                Response.Redirect("~/AFTERSALESPROJ/cleaningreport.aspx");
            }
        }
    }
}