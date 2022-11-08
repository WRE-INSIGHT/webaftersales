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
    public partial class refoilingForapproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["refoiling_searchkey"] != null)
                        {
                            tboxsearchkey.Text = Session["refoiling_searchkey"].ToString();
                        }
                        if (Session["refoiling_cbox"] != null)
                        {
                           ddlForApproval.SelectedValue = Session["refoiling_cbox"].ToString();
                        }
                        if (Session["refoiling_locksearch"] != null)
                        {
                            ddlLockSearch.SelectedValue = Session["refoiling_locksearch"].ToString();
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
        private void getdata()
        {
            try
            {


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        //string c = "0";
                        //if (CheckBox1.Checked)
                        //{
                        //    c = "1";
                        //}
                        sqlcmd.CommandText = "Refoiling_Forapproval_Stp_Revised";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@searchkey", tboxsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@forapproval", ddlForApproval.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@lock", ddlLockSearch.SelectedValue.ToString());
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        lblcountrow.Text = tb.Rows.Count.ToString() + " resul(s)";

                        Session["refoiling_searchkey"] = tboxsearchkey.Text;
                        Session["refoiling_cbox"] = ddlForApproval.SelectedValue.ToString();
                        Session["refoiling_locksearch"] = ddlLockSearch.SelectedValue.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
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

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myrefoiling")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                Session["refoilingdate"] = ((Label)row.FindControl("datelbl")).Text;
                Session["refoilingqno"] = ((Label)row.FindControl("lblqno")).Text;
                Session["miscellaneous"] = ((Label)row.FindControl("lblmiscellaneous")).Text;
                Session["CIN"] = ((Label)row.FindControl("lblcin")).Text;
                Session["SID"] = ((Label)row.FindControl("lblsid")).Text;

                Session["PROJECT"] = ((LinkButton)row.FindControl("projectlbl")).Text;
                Session["ADDRESS"] = ((Label)row.FindControl("addresslbl")).Text;
                Session["refoiling_report_sender"] = "forapproval";
                Response.Redirect("~/AFTERSALESPROJ/refoilingreport.aspx");
            }
            else if (e.CommandName == "myEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Label)row.FindControl("lbldiscountedprice")).Visible = false;
                ((Label)row.FindControl("lblwaived")).Visible = false;
                ((Label)row.FindControl("lbllock")).Visible = false;
                ((LinkButton)row.FindControl("btnEdit")).Visible = false;

                ((TextBox)row.FindControl("tboxdiscountedprice")).Visible = true;
                ((DropDownList)row.FindControl("ddlwaived")).Visible = true;
                ((DropDownList)row.FindControl("ddllock")).Visible = true;

                ((LinkButton)row.FindControl("btnSave")).Visible = true;
                ((LinkButton)row.FindControl("btnCancel")).Visible = true;
            }
            else if (e.CommandName == "myCancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Label)row.FindControl("lbldiscountedprice")).Visible = true;
                ((Label)row.FindControl("lblwaived")).Visible = true;
                ((Label)row.FindControl("lbllock")).Visible = true;
                ((LinkButton)row.FindControl("btnEdit")).Visible = true;

                ((TextBox)row.FindControl("tboxdiscountedprice")).Visible = false;
                ((DropDownList)row.FindControl("ddlwaived")).Visible = false;
                ((DropDownList)row.FindControl("ddllock")).Visible = false;

                ((LinkButton)row.FindControl("btnSave")).Visible = false;
                ((LinkButton)row.FindControl("btnCancel")).Visible = false;
            }
            else if (e.CommandName == "mySave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatePayment(((Label)row.FindControl("lblid")).Text,
                     ((TextBox)row.FindControl("tboxdiscountedprice")).Text,
                     ((DropDownList)row.FindControl("ddlwaived")).Text,
                     ((DropDownList)row.FindControl("ddllock")).SelectedValue.ToString());

            }
            else if (e.CommandName == "proofOfPayment")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["subfolder"] = "RefoilingQuotation";
                Session["quotation_id"] = ((Label)row.FindControl("lblid")).Text;
                Session["page_caller"] = "refoiling_quotation";
                Response.Redirect("~/AFTERSALESPROJ/ProofOfDiscountPhotos.aspx");
            }
        }
        private void updatePayment(string id, string discountedprice, string waived, string strlock)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_Forapproval_Stp_Revised";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@discountedprice", discountedprice);
                        sqlcmd.Parameters.AddWithValue("@waived", waived);
                        sqlcmd.Parameters.AddWithValue("@lock", strlock);
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

        private string userfullname
        {
            get
            {
                return Session["userfullname"].ToString();
            }
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