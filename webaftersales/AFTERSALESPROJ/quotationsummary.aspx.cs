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
                string str = "  select                                                                                         " +
                            "  c.PROJECT_LABEL AS PROJECT,                                                                                               " +
                            "  C.JOB_ORDER_NO AS JO,                                                                                                     " +
                            "  a.ID,                                                                                                                     " +
                            "  a.CIN,                                                                                                                    " +
                            "  a.ASENO,                                                                                                                  " +
                            "  case when isdate(a.QDATE) = 1 then format(cast(a.qdate as date), 'MMM-dd-yyyy') else a.qdate end as [DATE],               " +
                            "  format(a.OTHERCHARGES, 'n2') as [OTHER CHARGES],                                                                          " +
                            "  a.PARTICULAR,                                                                                                             " +
                            "  case when isdate(a.ACCEPTED) = 1 then format(cast(a.ACCEPTED as date), 'MMM-dd-yyyy') else a.ACCEPTED end as ACCEPTED,    " +
                            "  format(a.NETPRICE, 'n2') as NETPRICE,                                                                                     " +
                            "  format(a.Actualprice, 'n2') as [ACTUAL PRICE]                                                                             " +
                            "  from((quotationtb as a                                                                                                    " +
                            "   left join CALLINTB as b                                                                                                  " +
                            "  on a.cin = b.cin)                                                                                                         " +
                            "  left join kmdidata.dbo.addendum_to_contract_tb as c                                                                       " +
                            "  on b.JO = c.job_order_no)"+
                            "  WHERE C.PROJECT_LABEL LIKE @searchkey or c.JOB_ORDER_NO like @searchkey or a.aseno like @searchkey or a.cin like @searchkey";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@searchkey", "%" + searchkey.Text + "%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }
    }
}