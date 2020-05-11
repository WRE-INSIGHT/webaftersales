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
    public partial class quotationitem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        lblproject.Text = Session["callinProject"].ToString();
                        lbladdress.Text = Session["callinAddress"].ToString();
                        lblaseno.Text = aseno;
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
        private string aseno
        {
            get
            {
                return Session["aseno"].ToString();
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
                GridView1.DataSource = dal.knumber.getkno(aseno);
                GridView1.DataBind();

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "declare @id as integer = (select isnull(max(id),0)+1 from itemtb)" +
                          "   insert into itemtb(id, aseno, ITEM, kno, wdwloc)" +
                          "  values(@id, @aseno, @item, @kno, @loc)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@item", itemnotbox.Text);
                        sqlcmd.Parameters.AddWithValue("@kno", knotbox.Text);
                        sqlcmd.Parameters.AddWithValue("@loc", locationtbox.Text);
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("edititemnotbox")).Text = ((Label)row.FindControl("itemnolbl")).Text;
                ((TextBox)row.FindControl("editknotbox")).Text = ((Label)row.FindControl("knolbl")).Text;
                ((TextBox)row.FindControl("editlocationtbox")).Text = ((Label)row.FindControl("locationlbl")).Text;
                ((Panel)row.FindControl("Panel1")).Visible = true;
            }
            if (e.CommandName == "myclose")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel1")).Visible = false;
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text);
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("idlbl")).Text,
                ((TextBox)row.FindControl("edititemnotbox")).Text,
                ((TextBox)row.FindControl("editknotbox")).Text,
                ((TextBox)row.FindControl("editlocationtbox")).Text);
            }
            if (e.CommandName == "parts")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["IID"] = ((Label)row.FindControl("idlbl")).Text;
                Response.Redirect("~/AFTERSALESPROJ/importparts.aspx");
            }
        }
        private void deletefunction(string id)
        {
            try
            {
                string str = "delete from  itemtb where id = @id";
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
        private void updatefunction(string id, string itemno, string kno, string location)
        {
            try
            {
                string str = "update itemtb set WDWLOC=@location,item=@itemno,kno=@kno where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@itemno", itemno);
                        sqlcmd.Parameters.AddWithValue("@kno", kno);
                        sqlcmd.Parameters.AddWithValue("@location", location);
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
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
         
            if (e.CommandName == "g2mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                deleteprice(((Label)row.FindControl("partsidlbl")).Text);
            }
          
        }

        private void deleteprice(string id)
        {
            try
            {
                string str = "delete from  partstb where id = @id";
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

      

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/importquotationitem.aspx");
        }
    }
}