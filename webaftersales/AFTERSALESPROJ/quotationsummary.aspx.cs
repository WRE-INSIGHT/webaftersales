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
                        lblRowNum.Text = tb.Rows.Count.ToString()+" row(s) found!";
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
                showquotation(((Label)row.FindControl("lbljo")).Text, ((GridView)row.FindControl("Gridview2")));
            }
        }
        private void showquotation(string jo,GridView gv)
        {
            try
            {
                 using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd=sqlcon.CreateCommand())
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
            catch(Exception ex)
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
            getdata();
        }

    }
}