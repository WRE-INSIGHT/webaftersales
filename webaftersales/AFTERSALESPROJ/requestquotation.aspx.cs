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
    public partial class requestquotation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        lblproject.Text = Session["PROJECT"].ToString();
                        lbladdress.Text = Session["ADDRESS"].ToString();
                        lbljo.Text = Session["JO"].ToString();
                        lbldate.Text = "  " + Session["DATE"].ToString();
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
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
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
                System.Data.DataSet ds = new DataSet();
                ds.Clear();
                string str = "select * from reporttb where sid = @sid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myadd")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
               insertfunction(((Label)row.FindControl("lblid")).Text,
                   ((TextBox)row.FindControl("tboxarticleno")).Text,
                   ((TextBox)row.FindControl("tboxdescription")).Text);
            }
            if (e.CommandName == "myreload")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                myreload(((Label)row.FindControl("lblid")).Text,((GridView)row.FindControl("GridView3")));
            }
        }

        private void myreload(string id,GridView gv)
        {
            try
            {
                System.Data.DataSet ds = new DataSet();
                ds.Clear();
                string str = "select * from quotationrequesttbl where iid = @iid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", id);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        gv.DataSource = ds;
                        gv.DataBind();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        private void insertfunction(string id, string articleno, string description)
        {
            try
            {
            
                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from quotationrequesttbl)" +
                    " insert into quotationrequesttbl (id,iid,articleno,description)values(@id,@iid,@articleno,@description)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", id);
                        sqlcmd.Parameters.AddWithValue("@articleno", articleno);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }
    }
}