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
    public partial class AccountsReceivable : System.Web.UI.Page
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

        private void getdata()
        {
           try
            {
                string sdate, edate = "";
                if (tboxSdate.Text == "")
                {
                    sdate = "1900-01-01";
                }
                else
                {
                    sdate = tboxSdate.Text;
                }
                if (tboxEdate.Text == "")
                {
                    edate = "2100-01-01";
                }
                else
                {
                    edate = tboxEdate.Text;
                }
              
                DataTable tb = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AccountsReceivable_Stp";
                        sqlcmd.CommandType =CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@Paid", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@Sdate", sdate);
                        sqlcmd.Parameters.AddWithValue("@Edate", edate);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        int rownum = 0;
                        decimal totalamount = 0;
                        for(int i = 0; i<= tb.Rows.Count-1; i++)
                        {
                            rownum += 1;
                            totalamount += Convert.ToDecimal(tb.Rows[i]["actualprice"].ToString());
                        }
                        lblTotalRowCount.Text = rownum.ToString("N0");
                        lblTotalAmount.Text = totalamount.ToString("N2");
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}