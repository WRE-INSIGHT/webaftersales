using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ.quotationforms
{
    public partial class quotationForapproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["qu_searchkey"] != null)
                        {
                            tboxsearchkey.Text = Session["qu_searchkey"].ToString();
                        }
                        if (Session["qu_cbox"] != null)
                        {
                            CheckBox1.Checked = Convert.ToBoolean(Session["qu_cbox"]);
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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string userfullname
        {
            get
            {
                return Session["userfullname"].ToString();
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


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        string c = "0";
                        if (CheckBox1.Checked)
                        {
                            c = "1";
                        }
                        sqlcmd.CommandText = "stp_qu_forapproval";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@searchkey", tboxsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@forapproval", c);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        lblcountrow.Text = tb.Rows.Count.ToString() + " resul(s)";

                        Session["qu_searchkey"] = tboxsearchkey.Text;
                        Session["qu_cbox"] = CheckBox1.Checked;
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
            if (e.CommandName == "myquotation")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = ((Label)row.FindControl("lblcin")).Text;
                Session["SID"] = ((Label)row.FindControl("lblsid")).Text;
                Session["aseno"] = ((Label)row.FindControl("lblaseno")).Text;
                Session["PROJECT"] = ((LinkButton)row.FindControl("projectlbl")).Text;
                Session["ADDRESS"] = ((Label)row.FindControl("addresslbl")).Text;
                Session["qu_report_sender"] = "qu_sernder_approval";
                Response.Redirect("~/AFTERSALESPROJ/quotationreport.aspx");
            }
            else if (e.CommandName == "myEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Label)row.FindControl("lbldiscountedprice")).Visible = false;
                ((Label)row.FindControl("lblwaived")).Visible = false;
                ((LinkButton)row.FindControl("btnEdit")).Visible = false;

                ((TextBox)row.FindControl("tboxdiscountedprice")).Visible = true;
                ((DropDownList)row.FindControl("ddlwaived")).Visible = true;

                ((LinkButton)row.FindControl("btnSave")).Visible = true;
                ((LinkButton)row.FindControl("btnCancel")).Visible = true;
            }
            else if (e.CommandName == "myCancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Label)row.FindControl("lbldiscountedprice")).Visible = true;
                ((Label)row.FindControl("lblwaived")).Visible = true;
                ((LinkButton)row.FindControl("btnEdit")).Visible = true;

                ((TextBox)row.FindControl("tboxdiscountedprice")).Visible = false;
                ((DropDownList)row.FindControl("ddlwaived")).Visible = false;

                ((LinkButton)row.FindControl("btnSave")).Visible = false;
                ((LinkButton)row.FindControl("btnCancel")).Visible = false;
            }
            else if (e.CommandName == "mySave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatePayment(((Label)row.FindControl("lblid")).Text,
                     ((TextBox)row.FindControl("tboxdiscountedprice")).Text,
                     ((DropDownList)row.FindControl("ddlwaived")).Text);

            }
        }
        private void updatePayment(string id, string discountedprice, string waived)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "stp_qu_forapproval";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@discountedprice", discountedprice);
                        sqlcmd.Parameters.AddWithValue("@waived", waived);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                if (userfullname == "Warren Mangaring" || userfullname == "Amanda Aquino ")
                {
                    GridViewRow row = GridView1.Rows[i];
                    ((LinkButton)row.FindControl("btnEdit")).Visible = true;
                }
                else
                {
                    GridViewRow row = GridView1.Rows[i];
                    ((LinkButton)row.FindControl("btnEdit")).Visible = false;
                }
            }
        }
    }
}