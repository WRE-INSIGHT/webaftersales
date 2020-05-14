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
        static string kno { set; get; }
        static string itemno { set; get; }
        static string location { set; get; }
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
                        getdetails();
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

        private void getdetails()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    string str = "select ID,ASENO AS ASE#,NETPRICE ,QDATE AS [DATE],OTHERCHARGES,ACTUALPRICE,PARTICULAR from quotationtb where aseno=@aseno";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        GridView3.DataSource = sqlcmd.ExecuteReader();
                        GridView3.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
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

                ((LinkButton)row.FindControl("LinkButton2")).Visible = false;
                ((LinkButton)row.FindControl("LinkButton3")).Visible = false;
                ((Label)row.FindControl("itemnolbl")).Visible = false;
                ((Label)row.FindControl("knolbl")).Visible = false;
                ((Label)row.FindControl("locationlbl")).Visible = false;

                ((LinkButton)row.FindControl("LinkButton5")).Visible = true;
                ((LinkButton)row.FindControl("LinkButton6")).Visible = true;
                ((TextBox)row.FindControl("edititemnotbox")).Visible = true;
                ((TextBox)row.FindControl("editknotbox")).Visible = true;
                ((TextBox)row.FindControl("editlocationtbox")).Visible = true;

            }
            if (e.CommandName == "myclose")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((LinkButton)row.FindControl("LinkButton2")).Visible = true;
                ((LinkButton)row.FindControl("LinkButton3")).Visible = true;
                ((Label)row.FindControl("itemnolbl")).Visible = true;
                ((Label)row.FindControl("knolbl")).Visible = true;
                ((Label)row.FindControl("locationlbl")).Visible = true;

                ((LinkButton)row.FindControl("LinkButton5")).Visible = false;
                ((LinkButton)row.FindControl("LinkButton6")).Visible = false;
                ((TextBox)row.FindControl("edititemnotbox")).Visible = false;
                ((TextBox)row.FindControl("editknotbox")).Visible = false;
                ((TextBox)row.FindControl("editlocationtbox")).Visible = false;
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text);
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
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
                kno = ((Label)row.FindControl("knolbl")).Text;
                itemno = ((Label)row.FindControl("itemnolbl")).Text;
                location = ((Label)row.FindControl("locationlbl")).Text;

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

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                ViewState["rowindex"] = rowindex;
                ((LinkButton)row.FindControl("editbtn")).Visible = false;
                ((Label)row.FindControl("lblparticular")).Visible = false;
                ((Label)row.FindControl("lblothercharges")).Visible = false;
                ((Label)row.FindControl("lblnetprice")).Visible = false;
                ((Label)row.FindControl("lblactualprice")).Visible = false;

                ((LinkButton)row.FindControl("equalbtn")).Visible = true;
                ((LinkButton)row.FindControl("updatebtn")).Visible = true;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = true;
                ((TextBox)row.FindControl("tboxparticular")).Visible = true;
                ((TextBox)row.FindControl("tboxothercharges")).Visible = true;
                ((TextBox)row.FindControl("tboxnetprice")).Visible = true;
                ((TextBox)row.FindControl("tboxactualprice")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                ((LinkButton)row.FindControl("editbtn")).Visible = true;
                ((Label)row.FindControl("lblparticular")).Visible = true;
                ((Label)row.FindControl("lblothercharges")).Visible = true;
                ((Label)row.FindControl("lblnetprice")).Visible = true;
                ((Label)row.FindControl("lblactualprice")).Visible = true;

                ((LinkButton)row.FindControl("equalbtn")).Visible = false;
                ((LinkButton)row.FindControl("updatebtn")).Visible = false;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = false;
                ((TextBox)row.FindControl("tboxparticular")).Visible = false;
                ((TextBox)row.FindControl("tboxothercharges")).Visible = false;
                ((TextBox)row.FindControl("tboxnetprice")).Visible = false;
                ((TextBox)row.FindControl("tboxactualprice")).Visible = false;
            }
            else if (e.CommandName == "equal")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                if(((TextBox)row.FindControl("tboxnetprice")).Text!="" && ((TextBox)row.FindControl("tboxothercharges")).Text != "")
                {
                    double x, y, z;
                    x = double.Parse(((TextBox)row.FindControl("tboxnetprice")).Text);
                    y = double.Parse(((TextBox)row.FindControl("tboxothercharges")).Text);
                    z = x + y;
                    ((TextBox)row.FindControl("tboxactualprice")).Text =z.ToString();
                }
             
            }
            else if (e.CommandName == "myupdate")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                string id, netprice, actualprice, particular, othercharges;
                id = ((Label)row.FindControl("lblid")).Text;
                netprice = ((TextBox)row.FindControl("tboxnetprice")).Text;
                actualprice = ((TextBox)row.FindControl("tboxactualprice")).Text;
                particular=((TextBox)row.FindControl("tboxparticular")).Text;
                othercharges = ((TextBox)row.FindControl("tboxothercharges")).Text;
                if (othercharges == "")
                {
                    othercharges = "0";
                }
                updatefunction(id, particular, othercharges, netprice, actualprice);
            }
        }

        private void updatefunction(string id, string particular, string othercharges, string netprice, string actualprice)
        {
           try
            {
                string str = "update quotationtb set particular=@particular,othercharges=@othercharges,netprice=@netprice,actualprice=@actualprice  where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@particular", particular);
                        sqlcmd.Parameters.AddWithValue("@othercharges", othercharges);
                        sqlcmd.Parameters.AddWithValue("@netprice", netprice);
                        sqlcmd.Parameters.AddWithValue("@actualprice", actualprice);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdetails();
            }
        }

      
    }
}