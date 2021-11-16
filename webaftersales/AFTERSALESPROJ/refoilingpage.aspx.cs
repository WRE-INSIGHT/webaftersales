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
    public partial class refoilingpage : System.Web.UI.Page
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
        private string jo
        {
            get
            {
                return Session["JO"].ToString();
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private string cin
        {
            get
            {
                return Session["CIN"].ToString();
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
                        sqlcmd.CommandText = "Refoiling_Id_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@CIN", cin);
                        sqlcmd.Parameters.AddWithValue("@SID", sid);
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        GridView1.SelectedIndex = -1;
                        using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                        {
                            sqlcon.Open();
                            sqlcmd.CommandText = "Refoiling_Id_Stp";
                            sqlcmd.CommandType = CommandType.StoredProcedure;
                            sqlcmd.Parameters.AddWithValue("@Command", "Create");
                            sqlcmd.Parameters.AddWithValue("@CIN", cin);
                            sqlcmd.Parameters.AddWithValue("@SID", sid);
                            sqlcmd.Parameters.AddWithValue("@QDATE", tboxdate.Text);
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
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
                ((Label)row.FindControl("lblqdate")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((TextBox)row.FindControl("tboxqdateedit")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lblqdate")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((TextBox)row.FindControl("tboxqdateedit")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = false;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                updateme(((Label)row.FindControl("lblid")).Text,((TextBox)row.FindControl("tboxqdateedit")).Text);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                deleteme(((Label)row.FindControl("lblid")).Text);
            }
            else if (e.CommandName == "myitem")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["refoilingqno"] = ((Label)row.FindControl("lblqno")).Text;
                Session["SID"] = sid;
                Response.Redirect("~/AFTERSALESPROJ/refoilingitem.aspx");
            }
            else if (e.CommandName == "myreport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["refoilingdate"] = ((Label)row.FindControl("lblqdate")).Text;
                Session["refoilingqno"] = ((Label)row.FindControl("lblqno")).Text;
        
                Session["refoiling_report_sender"] = "cleaningpage";
                Response.Redirect("~/AFTERSALESPROJ/refoilingreport.aspx");
            }
        }

        private void deleteme(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd =sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Id_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Delete");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }


            }
            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "valedit";
                err.IsValid = false;
                err.ErrorMessage = ex.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                if (IsValid)
                {
                    loaddata();
                }

            }
        }

        private void updateme(string id, string qdate)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Id_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@QDATE", qdate);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }

            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "valedit";
                err.IsValid = false;
                err.ErrorMessage = ex.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                if (IsValid)
                {
                    loaddata();
                }

            }
        }
    }
}
