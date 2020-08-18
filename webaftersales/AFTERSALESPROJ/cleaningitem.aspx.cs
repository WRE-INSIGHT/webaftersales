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
    public partial class cleaningitem : System.Web.UI.Page
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private string iid
        {
            get
            {
                return Session["cleaningid"].ToString();
            }
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
   
                    string str = "select * from cleaningitem where IID=@iid";
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
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {

                    string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from cleaningitem) "+
                        " insert into cleaningitem (id,iid,location,area,unitprice,qty,totalamount)values(@id,@iid,@location,@area,@unitprice,@qty,cast(@unitprice as decimal(10,2))*cast(@qty as decimal(10,2)))";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
      
                        sqlcmd.Parameters.AddWithValue("@area", tboxarea.Text);
                        sqlcmd.Parameters.AddWithValue("@location", tboxlocation.Text);
                        sqlcmd.Parameters.AddWithValue("@unitprice", tboxunitprice.Text);
                        sqlcmd.Parameters.AddWithValue("@qty", tboxqty.Text);
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
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
                ((Label)row.FindControl("lbllocation")).Visible = false;
                ((Label)row.FindControl("lblarea")).Visible = false;
                ((Label)row.FindControl("lblunitprice")).Visible = false;
                ((Label)row.FindControl("lblqty")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((TextBox)row.FindControl("tboxlocationedit")).Visible = true;
                ((TextBox)row.FindControl("tboxareaedit")).Visible = true;
                ((TextBox)row.FindControl("tboxunitpriceedit")).Visible = true;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lbllocation")).Visible = true;
                ((Label)row.FindControl("lblarea")).Visible = true;
                ((Label)row.FindControl("lblunitprice")).Visible = true;
                ((Label)row.FindControl("lblqty")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((TextBox)row.FindControl("tboxlocationedit")).Visible = false;
                ((TextBox)row.FindControl("tboxareaedit")).Visible = false;
                ((TextBox)row.FindControl("tboxunitpriceedit")).Visible = false;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = false;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                updateme(((Label)row.FindControl("lblid")).Text, ((TextBox)row.FindControl("tboxlocationedit")).Text,
             ((TextBox)row.FindControl("tboxareaedit")).Text, ((TextBox)row.FindControl("tboxunitpriceedit")).Text, ((TextBox)row.FindControl("tboxqtyedit")).Text);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                deleteme(((Label)row.FindControl("lblid")).Text);
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
                    string str = "delete from cleaningitem where id = @id";
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

        private void updateme(string id, string location, string area, string unitprice, string qty)
        {
           try
            {
                string str = "update cleaningitem set location=@location,area=@area,unitprice=@unitprice,qty=@qty,totalamount=cast(isnull(@qty,0) as decimal(10,2))*cast(isnull(@unitprice,0) as decimal(10,2))  where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@location", location);
                        sqlcmd.Parameters.AddWithValue("@area", area);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
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