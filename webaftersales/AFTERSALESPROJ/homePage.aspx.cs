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
    public partial class homePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    if (useraccount != "Admin")
                    {
                        datetbox.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    }

                    if (Session["currentdate"] != null)
                    {
                        datetbox.Text = Session["currentdate"].ToString();
                    }
                    if (Session["currentsearch"] != null)
                    {
                        searchtbox.Text = Session["currentsearch"].ToString();
                    }
                    getdata();
                 
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string userpid
        {
            get
            {
                return Session["userpid"].ToString();
            }
        }
        private string useraccount
        {
            get
            {
                return Session["useraccount"].ToString();
            }
        }
        protected void searcbtn_Click(object sender, EventArgs e)
        {
            Session["currentsearch"] = searchtbox.Text;
            Session["currentdate"] = datetbox.Text;
            getdata();
        }
       private string sqlconstr
        {
            get
            {
              return  ConnectionString.sqlconstr();
            }
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
                    sqlcmd.CommandText = "stpServicing";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@project", searchtbox.Text);
                    sqlcmd.Parameters.AddWithValue("@useraccount", useraccount);
                    sqlcmd.Parameters.AddWithValue("@userpid", userpid);
                    sqlcmd.Parameters.AddWithValue("@datekey", datetbox.Text);
                    sqlcmd.Parameters.AddWithValue("@member", membertbox.Text);
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
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
                Session["pendingSOURCE"] = false;
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
        }




    }
}