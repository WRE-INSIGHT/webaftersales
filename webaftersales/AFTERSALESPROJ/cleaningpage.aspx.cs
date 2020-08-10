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
    public partial class cleaningpage : System.Web.UI.Page
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
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {

                    string str = "select * from cleaningtbl where cin=@cin and sid=@sid";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
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
                    DataSet ds = new DataSet();
                    ds.Clear();
                    string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                    using (SqlConnection sqlcon = new SqlConnection(cs))
                    {
                        GridView1.SelectedIndex = -1;
                        string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from [CLEANINGtbl]) " +
                            " insert into [CLEANINGtbl] (ID,CIN,SID,QNO,QDATE,PREPAREDBY,NOTEDBY)values(@id,@cin,@sid,@qno,@qdate,'','')";
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@cin", cin);
                            sqlcmd.Parameters.AddWithValue("@sid", sid);
                            sqlcmd.Parameters.AddWithValue("@qdate", tboxdate.Text);
                            sqlcmd.Parameters.AddWithValue("@qno", tboxquote.Text);
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
                ((Label)row.FindControl("lblqno")).Visible = false;
                ((Label)row.FindControl("lblqdate")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((TextBox)row.FindControl("tboxqnoedit")).Visible = true;
                ((TextBox)row.FindControl("tboxqdateedit")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lblqno")).Visible = true;
                ((Label)row.FindControl("lblqdate")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((TextBox)row.FindControl("tboxqnoedit")).Visible = false;
                ((TextBox)row.FindControl("tboxqdateedit")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = false;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                updateme(((Label)row.FindControl("lblid")).Text, ((TextBox)row.FindControl("tboxqnoedit")).Text,
             ((TextBox)row.FindControl("tboxqdateedit")).Text);
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
                Session["cleaningid"] = ((Label)row.FindControl("lblid")).Text;
                Response.Redirect("~/AFTERSALESPROJ/cleaningitem.aspx");
            }
            else if (e.CommandName == "myreport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["cleaningid"] = ((Label)row.FindControl("lblid")).Text;
                Response.Redirect("~/AFTERSALESPROJ/cleaningreport.aspx");
            }
        }

        private void deleteme(string id)
        {
            try
            {

                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    string str = "delete from cleaningtbl where id = @id";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@id", id);
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

        private void updateme(string id, string qno, string qdate)
        {
            try
            {
                bool isexist;
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    string str = "select * from cleaningtbl where qno = @qno and not id = @id";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@qno", qno);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                isexist = true;
                            }
                            else
                            {
                                isexist = false;
                            }
                        }
                    }

                    if (isexist)
                    {
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "valedit";
                        err.IsValid = false;
                        err.ErrorMessage = "unable to process your request qno is already used by another proposal!";
                        Page.Validators.Add(err);

                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand("update cleaningtbl set qno=@qno,qdate=@qdate where id=@id", sqlcon))
                        {
                            cmd.Parameters.AddWithValue("@id", id);
                            cmd.Parameters.AddWithValue("@qno", qno);
                            cmd.Parameters.AddWithValue("@qdate", qdate);
                            cmd.ExecuteNonQuery();
                        }
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
