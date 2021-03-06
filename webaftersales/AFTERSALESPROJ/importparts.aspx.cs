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
    public partial class importparts : System.Web.UI.Page
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
                        getpricelist();
                        getdetails();
                        getknofromfab();
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
                    string str = "select wdwloc AS LOCATION, ITEM,kno AS K#, FORMAT(netprice,'N2') AS [NET PRICE],Vat_Amount from itemtb where id = @iid ";

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
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
        private void getknofromfab()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "display_cl";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        GridView4.DataSource = sqlcmd.ExecuteReader();
                        GridView4.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
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
                return Session["IID"].ToString();
            }
        }
        private string aseno
        {
            get
            {
                return Session["aseno"].ToString();
            }
        }
        private void getpricelist()
        {
            try
            {

                DataSet ds = new DataSet();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = "select ID, " +
                   "       SPECIFICATION," +
                   "       ARTICLENO as [ARTICLE NO]," +
                   "       DESCRIPTION," +
                   "       UNIT," +
                   "       UNITPRICE AS[UNIT PRICE]," +
                   "       REMARKS" +
                   "       from ACCESSORIESTB" +
                   "       where " +
                   "       description like @searchkey or" +
                   "       articleno like @searchkey or" +
                   "       specification like @searchkey";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@searchkey", "%" + searchtbox.Text + "%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView2.DataSource = ds;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void getdata()
        {
            try
            {

                DataSet ds = new DataSet();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = "select * from partstb where iid = @iid";
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


        protected void tboxunitprice_TextChanged(object sender, EventArgs e)
        {
            if (tboxunitprice.Text != "" && tboxqty.Text != "" && tboxmarkup.Text != "" && tboxVatPer.Text != "")
            {
                double netamount, v, w, x, y, z,vat;
                w = double.Parse(tboxmarkup.Text);
                x = double.Parse(tboxqty.Text);
                y = double.Parse(tboxunitprice.Text);

                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;
                tboxnetprice.Text = Convert.ToString(netamount);
                vat = double.Parse(tboxVatPer.Text);
                tboxVatamount.Text = Convert.ToString(netamount*(vat*0.01));
            }
            else
            {
                tboxnetprice.Text = "0";
            }
        }

        protected void insertbtn_Click(object sender, EventArgs e)
        {
            addfunction(tboxarticle.Text, tboxdescription.Text, tboxmarkup.Text, tboxunitprice.Text, tboxqty.Text, tboxnetprice.Text,tboxVatamount.Text);
        }
        private void addfunction(string articleno, string description, string markup, string unitprice, string qty, string netprice,string vatamount)
        {
            try
            {

                string str = "  declare @id as integer = (select isnull(max(id),0)+1 from partstb) " +
                  "  insert into partstb(id, iid, articleno, description, markup, unitprice, qty, netamount,vat_amount) " +
                  "  values(@id, @iid, @articleno, @description, @markup, @unitprice, @qty, @netamount,@vatamount) " +
                             " declare @x as decimal(10,2) = (select sum(netamount) from partstb where iid=@iid) " +
                              " declare @totalVatamountParts as decimal(10,2) = (select sum(vat_amount) from partstb where iid=@iid) " +
                             " update itemtb set netprice = @x,vat_amount = @totalVatamountParts where id = @iid " +
                             " declare @y as decimal(10,2) = (select sum(netprice) from itemtb where aseno=@aseno) " +
                              " declare @totalVatamountItem as decimal(10,2) = (select sum(vat_amount) from itemtb where aseno=@aseno) " +
                             " update [QUOTATIONTB] set netprice = @y,vat_amount = @totalVatamountItem where aseno = @aseno ";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        sqlcmd.Parameters.AddWithValue("@articleno", articleno);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@markup", markup);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
                        sqlcmd.Parameters.AddWithValue("@netamount", netprice);
                        sqlcmd.Parameters.AddWithValue("@vatamount", vatamount);
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
                getpricelist();
                getdata();
                getdetails();
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            getpricelist();
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myimport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                ((Panel)row.FindControl("Panel3")).Visible = true;
            }
            if (e.CommandName == "myadd")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];

                double netamount, v, w, x, y, z;
                w = double.Parse(((TextBox)row.FindControl("importmarkuptbox")).Text);
                x = double.Parse(((TextBox)row.FindControl("importqtytbox")).Text);
                y = double.Parse(((Label)row.FindControl("lblunitprice")).Text);

                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;

                addfunction(((Label)row.FindControl("lblarticleno")).Text,
                    ((Label)row.FindControl("lbldescription")).Text,
                    w.ToString(),
                    y.ToString(),
                    x.ToString(), netamount.ToString(),tboxVatamount.Text);
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                ((Panel)row.FindControl("Panel3")).Visible = false;
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            getpricelist();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.EditIndex = -1;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {

                if (e.CommandName == "myedit")
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];
                    ViewState["rowindex"] = rowindex;
                    ((LinkButton)row.FindControl("LinkButton7")).Visible = true;
                    ((LinkButton)row.FindControl("LinkButton8")).Visible = true;
                    ((TextBox)row.FindControl("articlenotboxedit")).Visible = true;
                    ((TextBox)row.FindControl("descriptiontboxedit")).Visible = true;
                    ((TextBox)row.FindControl("markuptboxedit")).Visible = true;
                    ((TextBox)row.FindControl("unitpricetboxedit")).Visible = true;
                    ((TextBox)row.FindControl("qtytboxedit")).Visible = true;
                    ((TextBox)row.FindControl("netamounttboxedit")).Visible = true;
                    ((TextBox)row.FindControl("vatamounttboxedit")).Visible = true;

                    ((LinkButton)row.FindControl("LinkButton6")).Visible = false;
                    ((LinkButton)row.FindControl("LinkButton9")).Visible = false;
                    ((Label)row.FindControl("articleno")).Visible = false;
                    ((Label)row.FindControl("description")).Visible = false;
                    ((Label)row.FindControl("markup")).Visible = false;
                    ((Label)row.FindControl("unitprice")).Visible = false;
                    ((Label)row.FindControl("qty")).Visible = false;
                    ((Label)row.FindControl("netamount")).Visible = false;
                    ((Label)row.FindControl("vatamount")).Visible = false;


                }
                else if (e.CommandName == "mycancel")
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];

                    ((LinkButton)row.FindControl("LinkButton7")).Visible = false;
                    ((LinkButton)row.FindControl("LinkButton8")).Visible = false;
                    ((TextBox)row.FindControl("articlenotboxedit")).Visible = false;
                    ((TextBox)row.FindControl("descriptiontboxedit")).Visible = false;
                    ((TextBox)row.FindControl("markuptboxedit")).Visible = false;
                    ((TextBox)row.FindControl("unitpricetboxedit")).Visible = false;
                    ((TextBox)row.FindControl("qtytboxedit")).Visible = false;
                    ((TextBox)row.FindControl("netamounttboxedit")).Visible = false;
                    ((TextBox)row.FindControl("vatamounttboxedit")).Visible = false;

                    ((LinkButton)row.FindControl("LinkButton6")).Visible = true;
                    ((LinkButton)row.FindControl("LinkButton9")).Visible = true;
                    ((Label)row.FindControl("articleno")).Visible = true;
                    ((Label)row.FindControl("description")).Visible = true;
                    ((Label)row.FindControl("markup")).Visible = true;
                    ((Label)row.FindControl("unitprice")).Visible = true;
                    ((Label)row.FindControl("qty")).Visible = true;
                    ((Label)row.FindControl("netamount")).Visible = true;
                    ((Label)row.FindControl("vatamount")).Visible = true;
                }
                else if (e.CommandName == "myupdate")
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];

                    updatefunction(((Label)row.FindControl("id")).Text,
                        ((TextBox)row.FindControl("articlenotboxedit")).Text,
                     ((TextBox)row.FindControl("descriptiontboxedit")).Text,
                     ((TextBox)row.FindControl("markuptboxedit")).Text,
                     ((TextBox)row.FindControl("unitpricetboxedit")).Text,
                     ((TextBox)row.FindControl("qtytboxedit")).Text,
                     ((TextBox)row.FindControl("netamounttboxedit")).Text,
                        ((TextBox)row.FindControl("vatamounttboxedit")).Text);
                }
                else if (e.CommandName == "mydelete")
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];

                    deletefunction(((Label)row.FindControl("id")).Text);
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        private void deletefunction(string id)
        {
            try
            {

                string str = "delete from partstb where id = @id" +
                             " declare @x as decimal(10,2) = (select sum(netamount) from partstb where iid=@iid) " +
                             " declare @b as decimal(10,2) = (select sum(vat_amount) from partstb where iid=@iid) " +
                             " update itemtb set netprice = @x,vat_amount=@b where id = @iid " +
                             " declare @y as decimal(10,2) = (select sum(netprice) from itemtb where aseno=@aseno) " +
                             " declare @z as decimal(10,2) = (select sum(vat_amount) from itemtb where aseno=@aseno) " +
                             " update [QUOTATIONTB] set netprice = @y,vat_amount=@z where aseno = @aseno "; ;
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
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

        private void updatefunction(string id, string articleno, string description, string markup, string unitprice, string qty, string netprice, string vatamount)
        {
            try
            {

                string str = " update partstb set articleno=@articleno, description= @description, markup = @markup, unitprice = @unitprice, qty = @qty, netamount = @netamount, vat_amount=@vatamount where id = @id" +
                             " declare @x as decimal(10,2) = (select sum(netamount) from partstb where iid=@iid) " +
                             " declare @totalVatamountParts as decimal(10,2) = (select sum(VAT_amount) from partstb where iid=@iid) " +
                             " update itemtb set netprice = @x, VAT_AMOUNT = @totalVatamountParts where id = @iid " +
                             " declare @y as decimal(10,2) = (select sum(netprice) from itemtb where aseno=@aseno) " +
                             " declare @totalVatamountItem as decimal(10,2) = (select sum(VAT_amount) from itemtb where aseno=@aseno) " +
                             " update [QUOTATIONTB] set netprice = @y, VAT_AMOUNT = @totalVatamountItem where aseno = @aseno ";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@articleno", articleno);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@markup", markup);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
                        sqlcmd.Parameters.AddWithValue("@netamount", netprice);
                        sqlcmd.Parameters.AddWithValue("@vatamount", vatamount);
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
                getdetails();
            }
        }

        protected void edittboxunitprice_TextChanged(object sender, EventArgs e)
        {
            GridViewRow row = GridView1.Rows[(int)ViewState["rowindex"]];

            if (((TextBox)row.FindControl("unitpricetboxedit")).Text != "" && ((TextBox)row.FindControl("markuptboxedit")).Text != "" && ((TextBox)row.FindControl("qtytboxedit")).Text != "")
            {
                double netamount, v, w, x, y, z;
                w = double.Parse(((TextBox)row.FindControl("markuptboxedit")).Text);
                x = double.Parse(((TextBox)row.FindControl("qtytboxedit")).Text);
                y = double.Parse(((TextBox)row.FindControl("unitpricetboxedit")).Text);

                z = x * y;
                v = z * (w * 0.01);
                netamount = z + v;
                ((TextBox)row.FindControl("netamounttboxedit")).Text = Convert.ToString(netamount);
            }
            else
            {
                ((TextBox)row.FindControl("netamounttboxedit")).Text = "0";
            }
        }

       
    }
}