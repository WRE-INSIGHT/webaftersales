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
    public partial class joborderapproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "2" || Session["userid"].ToString() == "24" || Session["userid"].ToString() == "3"))
                {
                    if (!IsPostBack)
                    {
                        if (Session["joapprovalsearch"] != null)
                        {
                            searchkey.Text = Session["joapprovalsearch"].ToString();

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
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();

                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.CommandText = "std_RequestCollectionApproval";
                        sqlcmd.Parameters.AddWithValue("@key", searchkey.Text);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        Session["joapprovalsearch"] = searchkey.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "approve")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel2")).Visible = false;
                ((Panel)row.FindControl("Panel1")).Visible = true;
                ((LinkButton)row.FindControl("btnsave")).Text = "Approve";
                ((LinkButton)row.FindControl("btnsave")).CssClass = "btn btn-success";
            }
            else if (e.CommandName == "disapprove")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel2")).Visible = false;
                ((Panel)row.FindControl("Panel1")).Visible = true;
                ((LinkButton)row.FindControl("btnsave")).Text = "Disapprove";
                ((LinkButton)row.FindControl("btnsave")).CssClass = "btn btn-danger";
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updaterequest(((Label)row.FindControl("lblid")).Text,
                 ((TextBox)row.FindControl("tboxmessage")).Text,
                    ((LinkButton)row.FindControl("btnsave")).Text+"d",
                       ((LinkButton)row.FindControl("btnsave")).Text+"d");
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel2")).Visible = true;
                ((Panel)row.FindControl("Panel1")).Visible = false;
             
            }
            else if(e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel4")).Visible = true;

            }
            else if (e.CommandName == "editcancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel4")).Visible = false;

            }
            else if (e.CommandName == "editapprove")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updaterequest(((Label)row.FindControl("lblid")).Text,
                 ((TextBox)row.FindControl("edittboxmessage")).Text,
                    "Approved",
                      "Approved");
            }
            else if (e.CommandName == "editdisapprove")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updaterequest(((Label)row.FindControl("lblid")).Text,
                 ((TextBox)row.FindControl("edittboxmessage")).Text,
                    "Disapproved",
                      "Disapproved");
            }
        }
        private void updaterequest(string id, string comment, string col, string status)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = " update RequestCollectionApproval set message=@comment," + col + "=getdate(),rstatus=@status where id =@id";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@status", status);
                        sqlcmd.Parameters.AddWithValue("@comment", comment);
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
                getdata();
            }
        }
    }
}