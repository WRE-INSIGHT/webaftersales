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
    public partial class ServicingschedulePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    if (Session["currentsearch1"] != null)
                    {
                        servicingkeytbox.Text = Session["currentsearch1"].ToString();
                    }
                    getdata();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        protected void searcbtn_Click(object sender, EventArgs e)
        {
            Session["currentsearch1"] = servicingkeytbox.Text;
            getdata();
        }
        private void getdata()
        {
            try
            {
                GridView1.DataSource = dal.servicedataaccesslayer.GetService(servicingkeytbox.Text, Session["userpid"].ToString(), Session["useraccount"].ToString());
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewreport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("Label5")).Text;
                Session["CIN"] = ((Label)row.FindControl("Label6")).Text;
                getdetails(Session["CIN"].ToString());
            }
            else if (e.CommandName == "viewphoto")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("Label5")).Text;
                Session["CIN"] = ((Label)row.FindControl("Label6")).Text;
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
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            getdata();
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
    }
}