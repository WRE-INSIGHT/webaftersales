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
                        myreload();
                        loadimports();
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
        private string iid
        {
            get
            {
                return Session["reportID"].ToString();
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
      

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
                ((Label)row.FindControl("lblarticleno")).Visible = false;
                ((Label)row.FindControl("lbldescription")).Visible = false;

                ((TextBox)row.FindControl("tboxarticleno")).Visible = true;
                ((TextBox)row.FindControl("tboxdescription")).Visible = true;
                ((LinkButton)row.FindControl("btnupdate")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
            }
           else if (e.CommandName == "myupdate")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("lblid")).Text,
                ((TextBox)row.FindControl("tboxarticleno")).Text,
                ((TextBox)row.FindControl("tboxdescription")).Text);
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lblarticleno")).Visible = true;
                ((Label)row.FindControl("lbldescription")).Visible = true;

                ((TextBox)row.FindControl("tboxarticleno")).Visible = false;
                ((TextBox)row.FindControl("tboxdescription")).Visible = false;
                ((LinkButton)row.FindControl("btnupdate")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deetefunction(((Label)row.FindControl("lblid")).Text);
            }
        }

        private void deetefunction(string id)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "delete from quotationrequesttbl where id = @id";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                myreload();
            }
        }

        private void updatefunction(string id, string article, string description)
        {
           try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "update quotationrequesttbl set articleno=@articleno,description=@description where id = @id";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str,sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@articleno", article);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                myreload();
            }
        }

        private void myreload()
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
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
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
            finally
            {
                myreload();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            insertfunction(iid,
             tboxarticleno.Text,
             tboxdescription.Text);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            myreload();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            myreload();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loadimports();
        }
        private void loadimports()
        {
            try
            {
                System.Data.DataSet ds = new DataSet();
                ds.Clear();
                string str = "select * from [ACCESSORIESTB] where articleno like @searchkey or description like @searchkey";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@searchkey", "%"+searchkey.Text+"%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView2.DataSource = ds;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            loadimports();
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myimport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                importfunction(((Label)row.FindControl("g2lblarticleno")).Text,
                ((Label)row.FindControl("g2lbldescription")).Text);
            }
        }

        private void importfunction(string articleno, string description)
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
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
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
            finally
            {
                myreload();
            }
        }
    }
}