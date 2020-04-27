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
    public partial class pricelist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
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
                string str = "select ID," +
                         " SPECIFICATION," +
                         " ARTICLENO," +
                         " DESCRIPTION," +
                         " UNIT," +
                         " UNITPRICE as [UNIT PRICE]," +
                         " REMARKS" +
                         " from accessoriestb" +
                         " where " +
                         " description like @key or" +
                         " articleno like @key or unit like @key or" +
                         " specification like @key";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                {
                    using (SqlConnection sqlcon = new SqlConnection(cs))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            DataSet ds = new DataSet();
                            GridView1.SelectedIndex = -1;
                            sqlcmd.Parameters.AddWithValue("@key", "%" + key.Text + "%");
                            SqlDataAdapter da = new SqlDataAdapter();
                            da.SelectCommand = sqlcmd;
                            da.Fill(ds);
                            GridView1.DataSource = ds;
                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = rowindex;

                ((TextBox)row.FindControl("articletbox")).Text = ((Label)row.FindControl("articlelbl")).Text;
                ((TextBox)row.FindControl("specificationtbox")).Text = ((Label)row.FindControl("specificationlbl")).Text;
                ((TextBox)row.FindControl("descriptiontbox")).Text = ((Label)row.FindControl("descriptionlbl")).Text;
                ((TextBox)row.FindControl("unittbox")).Text = ((Label)row.FindControl("unitlbl")).Text;
                ((TextBox)row.FindControl("unitpricetbox")).Text = ((Label)row.FindControl("unitpricelbl")).Text;
                ((TextBox)row.FindControl("remarkstbox")).Text = ((Label)row.FindControl("remarkslbl")).Text;
                ((Panel)row.FindControl("Panel1")).Visible = true;
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = -1;
                ((Panel)row.FindControl("Panel1")).Visible = false;
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("idlbl")).Text,
                            ((TextBox)row.FindControl("articletbox")).Text,
                            ((TextBox)row.FindControl("specificationtbox")).Text,
                            ((TextBox)row.FindControl("descriptiontbox")).Text,
                            ((TextBox)row.FindControl("unittbox")).Text,
                            ((TextBox)row.FindControl("unitpricetbox")).Text,
                            ((TextBox)row.FindControl("remarkstbox")).Text);
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text);
            }

        }
        private void deletefunction(string id)
        {
            try
            {
                string str = "delete from accessoriestb where id=@id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
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
                getdata();
            }
        }
        private void updatefunction(string id, string article, string specification, string description, string unit, string unitprice, string remarks)
        {
            try
            {
                string str = "update accessoriestb set ARTICLENO = @article,SPECIFICATION =@specification,DESCRIPTION=@description,UNIT=@unit,UNITPRICE=@unitprice,remarks=@remarks  where id=@id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@article", article);
                        sqlcmd.Parameters.AddWithValue("@specification", specification);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@unit", unit);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks);
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            addfunction(articletbox.Text, specificationtbox.Text, descriptiontbox.Text, unittbox.Text, unitpricetbox.Text, remarkstbox.Text);
        }
        private void addfunction(string article, string specification, string description, string unit, string unitprice, string remarks)
        {
            try
            {
               
                string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from accessoriestb) insert into accessoriestb (id,ARTICLENO,SPECIFICATION,DESCRIPTION,UNIT,UNITPRICE,remarks)values(@id,@article,@specification,@description,@unit,@unitprice,@remarks)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
              
                        sqlcmd.Parameters.AddWithValue("@article", article);
                        sqlcmd.Parameters.AddWithValue("@specification", specification);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@unit", unit);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks);
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}