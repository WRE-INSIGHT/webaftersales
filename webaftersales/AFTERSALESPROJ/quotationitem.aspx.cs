﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getdetails()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = "select ID,ASENO AS ASE#,NETPRICE ,QDATE AS [DATE],OTHERCHARGES,ACTUALPRICE,PARTICULAR,MOBILIZATION,TRANSPORTATION,MATERIAL_SURCHARGES,VAT_AMOUNT,FOC,LABOR,LABOR_REMARKS from quotationtb where aseno=@aseno";
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

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                ((Label)row.FindControl("lblmobilization")).Visible = false;
                ((Label)row.FindControl("lblTransportation")).Visible = false;
                ((Label)row.FindControl("lblMaterial_surcharges")).Visible = false;
                ((Label)row.FindControl("lblothercharges")).Visible = false;
                ((Label)row.FindControl("lblnetprice")).Visible = false;
                ((Label)row.FindControl("lblactualprice")).Visible = false;
                ((Label)row.FindControl("lblfoc")).Visible = false;
                ((Label)row.FindControl("lblvatamount")).Visible = false;
                ((Label)row.FindControl("lbllaborcost")).Visible = false;
                ((Label)row.FindControl("lbllaborremarks")).Visible = false;

                ((LinkButton)row.FindControl("equalbtn")).Visible = true;
                ((LinkButton)row.FindControl("updatebtn")).Visible = true;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = true;
                ((TextBox)row.FindControl("tboxparticular")).Visible = true;
                ((TextBox)row.FindControl("tboxTransportation")).Visible = true;
                ((TextBox)row.FindControl("tboxmobilization")).Visible = true;
                ((TextBox)row.FindControl("tboxMaterial_surcharges")).Visible = true;
                ((TextBox)row.FindControl("tboxothercharges")).Visible = true;
                ((TextBox)row.FindControl("tboxnetprice")).Visible = true;
                ((TextBox)row.FindControl("tboxactualprice")).Visible = true;
                ((TextBox)row.FindControl("TBOXFOC")).Visible = true;
                ((TextBox)row.FindControl("tboxvatamount")).Visible = true;
                ((TextBox)row.FindControl("tboxlaborcost")).Visible = true;
                ((TextBox)row.FindControl("tboxlaborremarks")).Visible = true;
                ((DropDownList)row.FindControl("ddlmobi")).Visible = true;



            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                ((LinkButton)row.FindControl("editbtn")).Visible = true;
                ((Label)row.FindControl("lblparticular")).Visible = true;
                ((Label)row.FindControl("lblmobilization")).Visible = true;
                ((Label)row.FindControl("lblTransportation")).Visible = true;
                ((Label)row.FindControl("lblMaterial_surcharges")).Visible = true;
                ((Label)row.FindControl("lblothercharges")).Visible = true;
                ((Label)row.FindControl("lblothercharges")).Visible = true;
                ((Label)row.FindControl("lblnetprice")).Visible = true;
                ((Label)row.FindControl("lblactualprice")).Visible = true;
                ((Label)row.FindControl("lblfoc")).Visible = true;
                ((Label)row.FindControl("lblvatamount")).Visible = true;
                ((Label)row.FindControl("lbllaborcost")).Visible = true;
                ((Label)row.FindControl("lbllaborremarks")).Visible = true;

                ((LinkButton)row.FindControl("equalbtn")).Visible = false;
                ((LinkButton)row.FindControl("updatebtn")).Visible = false;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = false;
                ((TextBox)row.FindControl("tboxparticular")).Visible = false;
                ((TextBox)row.FindControl("tboxTransportation")).Visible = false;
                ((TextBox)row.FindControl("tboxmobilization")).Visible = false;
                ((TextBox)row.FindControl("tboxMaterial_surcharges")).Visible = false;
                ((TextBox)row.FindControl("tboxothercharges")).Visible = false;
                ((TextBox)row.FindControl("tboxnetprice")).Visible = false;
                ((TextBox)row.FindControl("tboxactualprice")).Visible = false;
                ((TextBox)row.FindControl("tboxfoc")).Visible = false;
                ((TextBox)row.FindControl("tboxvatamount")).Visible = false;
                ((TextBox)row.FindControl("tboxlaborcost")).Visible = false;
                ((TextBox)row.FindControl("tboxlaborremarks")).Visible = false;
                ((DropDownList)row.FindControl("ddlmobi")).Visible = false;
            }
            else if (e.CommandName == "equal")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                if (((TextBox)row.FindControl("tboxnetprice")).Text != "" && ((TextBox)row.FindControl("tboxothercharges")).Text != "")
                {
                    double x, y, z, a, b,transpo,materials,labor;
                    x = double.Parse(((TextBox)row.FindControl("tboxnetprice")).Text);
                    y = double.Parse(((TextBox)row.FindControl("tboxothercharges")).Text);
                    a = double.Parse(((TextBox)row.FindControl("tboxmobilization")).Text);
                    transpo = double.Parse(((TextBox)row.FindControl("tboxTransportation")).Text);
                    materials = double.Parse(((TextBox)row.FindControl("tboxMaterial_surcharges")).Text);
                    labor = double.Parse(((TextBox)row.FindControl("tboxlaborcost")).Text);
                    b = double.Parse(((TextBox)row.FindControl("tboxvatamount")).Text);
                    z = x + y + a + b+ transpo+ materials +labor;
                    ((TextBox)row.FindControl("tboxactualprice")).Text = z.ToString();
                }

            }
            else if (e.CommandName == "myupdate")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                string id, netprice, actualprice, particular, othercharges, mobilization,transpo,materials, foc, vatamount,labor,labor_remarks;
                id = ((Label)row.FindControl("lblid")).Text;
                netprice = ((TextBox)row.FindControl("tboxnetprice")).Text;
                actualprice = ((TextBox)row.FindControl("tboxactualprice")).Text;
                particular = ((TextBox)row.FindControl("tboxparticular")).Text;
                mobilization = ((TextBox)row.FindControl("tboxmobilization")).Text;
                transpo = ((TextBox)row.FindControl("tboxTransportation")).Text;
                materials = ((TextBox)row.FindControl("tboxMaterial_surcharges")).Text;
                othercharges = ((TextBox)row.FindControl("tboxothercharges")).Text;
                foc = ((TextBox)row.FindControl("tboxfoc")).Text;
                labor = ((TextBox)row.FindControl("tboxlaborcost")).Text;
                labor_remarks = ((TextBox)row.FindControl("tboxlaborremarks")).Text;
                vatamount = ((TextBox)row.FindControl("tboxvatamount")).Text;
                if (othercharges == "")
                {
                    othercharges = "0";
                }
                updatefunction(id, particular, othercharges, netprice, actualprice, mobilization, transpo, materials,  foc, vatamount,labor,labor_remarks);
            }
        }

        private void updatefunction(string id, string particular, string othercharges, string netprice, string actualprice, 
            string mobilization,string transpo, string materials, string foc, string vatamount,string labor, string labor_remarks)
        {
            try
            {
                string str = "update quotationtb set particular=@particular,othercharges=@othercharges,netprice=@netprice,actualprice=@actualprice"+
                    ",mobilization=@mobilization,transportation=@transpo,material_surcharges=@materials,foc=@foc,vat_amount=@vatamount,labor=@labor,labor_remarks=@labor_remarks where id = @id";

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@particular", particular);
                        sqlcmd.Parameters.AddWithValue("@othercharges", othercharges);
                        sqlcmd.Parameters.AddWithValue("@mobilization", mobilization);
                        sqlcmd.Parameters.AddWithValue("@transpo", transpo);
                        sqlcmd.Parameters.AddWithValue("@materials", materials);
                        sqlcmd.Parameters.AddWithValue("@netprice", netprice);
                        sqlcmd.Parameters.AddWithValue("@actualprice", actualprice);
                        sqlcmd.Parameters.AddWithValue("@foc", foc);
                        sqlcmd.Parameters.AddWithValue("@vatamount", vatamount);
                        sqlcmd.Parameters.AddWithValue("@labor", labor);
                        sqlcmd.Parameters.AddWithValue("@labor_remarks", labor_remarks);
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
                getdetails();
            }
        }

        protected void mobiselectedindexchange(object sender, EventArgs e)
        {
            GridViewRow row = GridView3.Rows[(int)ViewState["rowindex"]];
            ((TextBox)row.FindControl("tboxmobilization")).Text = ((DropDownList)row.FindControl("ddlmobi")).SelectedValue.ToString();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}