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
    public partial class ProfileWidth : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        loaddata();
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
        private void loaddata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
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
            adddata();
        }
        private void adddata()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Create");
                        sqlcmd.Parameters.AddWithValue("@Article_No", tboxArticleNo.Text);
                        sqlcmd.Parameters.AddWithValue("@Color", tboxColor.Text);
                        sqlcmd.Parameters.AddWithValue("@Width_In", tboxWidthIn.Text);
                        sqlcmd.Parameters.AddWithValue("@Width_Out",tboxWidthOut.Text);
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
                loaddata();
            }
        }
        private void updatedata(GridViewRow row)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@Id", ((Label)row.FindControl("lblid")).Text);
                        sqlcmd.Parameters.AddWithValue("@Article_No", ((TextBox)row.FindControl("tboxArticleNoEdit")).Text);
                        sqlcmd.Parameters.AddWithValue("@Color", ((TextBox)row.FindControl("tboxColorEdit")).Text);
                        sqlcmd.Parameters.AddWithValue("@Width_In", ((TextBox)row.FindControl("tboxWidthInEdit")).Text);
                        sqlcmd.Parameters.AddWithValue("@Width_Out", ((TextBox)row.FindControl("tboxWidthOutEdit")).Text);
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
                loaddata();
            }
        }
        private void deletedata(string id)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Delete");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
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
                loaddata();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletedata(((Label)row.FindControl("lblid")).Text);
            }
            else if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                controlVisibility(row, false);
                ((Panel)row.FindControl("btnpanel2")).Visible = true;
                ((Panel)row.FindControl("btnpanel1")).Visible = false;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                controlVisibility(row, true);
                ((Panel)row.FindControl("btnpanel2")).Visible = false;
                ((Panel)row.FindControl("btnpanel1")).Visible = true;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatedata(row);

            }
        }
        private void controlVisibility(GridViewRow row, bool b)
        {
            ((Label)row.FindControl("lblArticleNo")).Visible = b;
            ((Label)row.FindControl("lblColor")).Visible = b;
            ((Label)row.FindControl("lblInside")).Visible = b;
            ((Label)row.FindControl("lblOutside")).Visible = b;

            ((TextBox)row.FindControl("tboxColorEdit")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxArticleNoEdit")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxWidthInEdit")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxWidthOutEdit")).Visible = b == true ? false : true;

        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }
    }
}