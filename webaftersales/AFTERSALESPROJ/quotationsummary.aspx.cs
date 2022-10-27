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

namespace webaftersales.AFTERSALESPROJ
{
    public partial class quotationsummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["q_monitoring_search"] != null)
                        {
                            searchkey.Text = Session["q_monitoring_search"].ToString();
                            ddlPaymentStatus.Text = Session["q_monitoring_status"].ToString();
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
                DataTable tb = new DataTable();


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        if (Session["p_monitoring_pageindex"] != null)
                        {
                            var x = Convert.ToInt32(Session["p_monitoring_pageindex"].ToString());
                            GridView1.PageIndex = x;
                        }
                        sqlcon.Open();
                        sqlcmd.CommandText = "Account_Receivable_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Load");
                        sqlcmd.Parameters.AddWithValue("@SearchKey", searchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        Session["q_monitoring_search"] = searchkey.Text;
                        Session["q_monitoring_status"] = ddlPaymentStatus.Text;
                        lblRowNum.Text = tb.Rows.Count.ToString() + " row(s) found!";
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {

                showsummary();
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["p_monitoring_pageindex"] = 0;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "showquotation")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                if (((GridView)row.FindControl("Gridview2")).Visible == true)
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = false;
                }
                else
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = true;
                }
                Session["PROJECT"] = ((LinkButton)row.FindControl("LinkButton2")).Text;
                Session["ADDRESS"] = ((Label)row.FindControl("g1lblfulladd")).Text;
                showquotation(((Label)row.FindControl("lbljo")).Text, ((GridView)row.FindControl("Gridview2")));
            }
        }
        protected void GridView2_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myquotation")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                var qtype = ((Label)row.FindControl("lblquotationtype")).Text;
                Session["CIN"] = ((Label)row.FindControl("lblcin")).Text;
                Session["SID"] = ((Label)row.FindControl("lblsid")).Text;

                if (qtype == "quotation")
                {
                    Session["aseno"] = ((Label)row.FindControl("lblaseno")).Text;
                    Session["qu_report_sender"] = "qu_sernder_monitoring";
                    Response.Redirect("~/AFTERSALESPROJ/quotationreport.aspx");
                }
                else if (qtype == "re-foiling")
                {
                    Session["refoilingdate"] = ((Label)row.FindControl("datelbl")).Text;
                    Session["refoilingqno"] = ((Label)row.FindControl("lblaseno")).Text;
                    Session["miscellaneous"] = ((Label)row.FindControl("lblmiscellaneous")).Text;
                    Session["refoiling_report_sender"] = "refoiling_sernder_monitoring";
                    Response.Redirect("~/AFTERSALESPROJ/refoilingreport.aspx");
                }



            }
        }
        private void showquotation(string jo, GridView gv)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Account_Receivable_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Quotation_Data");
                        sqlcmd.Parameters.AddWithValue("@jo", jo);
                        SqlDataAdapter da = new SqlDataAdapter();
                        DataTable tb = new DataTable();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        gv.DataSource = tb;
                        gv.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void showsummary()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Account_Receivable_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Summary");
                        sqlcmd.Parameters.AddWithValue("@SearchKey", searchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.Text);
                        SqlDataReader rd = sqlcmd.ExecuteReader();
                        while (rd.Read())
                        {
                            lblbill_amount_summary.Text = rd[0].ToString();
                            lbldiscounted_price_summary.Text = rd[1].ToString();
                            lblpayment_summary.Text = rd[2].ToString();
                            lblbalance_summary.Text = rd[3].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["p_monitoring_pageindex"] = e.NewPageIndex;
            getdata();
        }

    }
}