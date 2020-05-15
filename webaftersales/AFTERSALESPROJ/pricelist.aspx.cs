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
                ((LinkButton)row.FindControl("editbtn")).Visible = false;
                ((LinkButton)row.FindControl("deletebtn")).Visible = false;
                ((Label)row.FindControl("articlelbl")).Visible = false;
                ((Label)row.FindControl("specificationlbl")).Visible = false;
                ((Label)row.FindControl("descriptionlbl")).Visible = false;
                ((Label)row.FindControl("unitlbl")).Visible = false;
                ((Label)row.FindControl("unitpricelbl")).Visible = false;
                ((Label)row.FindControl("remarkslbl")).Visible = false;

                ((LinkButton)row.FindControl("updatebtn")).Visible = true;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = true;
                ((TextBox)row.FindControl("articletbox")).Visible = true;
                ((TextBox)row.FindControl("specificationtbox")).Visible = true;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = true;
                ((TextBox)row.FindControl("unittbox")).Visible = true;
                ((TextBox)row.FindControl("unitpricetbox")).Visible = true;
                ((TextBox)row.FindControl("remarkstbox")).Visible = true;
         
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = -1;
                ((LinkButton)row.FindControl("editbtn")).Visible = true;
                ((LinkButton)row.FindControl("deletebtn")).Visible = true;
                ((Label)row.FindControl("articlelbl")).Visible = true;
                ((Label)row.FindControl("specificationlbl")).Visible = true;
                ((Label)row.FindControl("descriptionlbl")).Visible = true;
                ((Label)row.FindControl("unitlbl")).Visible = true;
                ((Label)row.FindControl("unitpricelbl")).Visible = true;
                ((Label)row.FindControl("remarkslbl")).Visible = true;

                ((LinkButton)row.FindControl("updatebtn")).Visible = false;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = false;
                ((TextBox)row.FindControl("articletbox")).Visible = false;
                ((TextBox)row.FindControl("specificationtbox")).Visible = false;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = false;
                ((TextBox)row.FindControl("unittbox")).Visible = false;
                ((TextBox)row.FindControl("unitpricetbox")).Visible = false;
                ((TextBox)row.FindControl("remarkstbox")).Visible = false;

            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
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