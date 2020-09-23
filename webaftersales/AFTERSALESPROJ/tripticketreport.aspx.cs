using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class tripticketreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            if (Session["username"] != null)
            {
               
                    if (!IsPostBack)
                    {
                        if (Session["tripticketdate"] != null)
                        {
                            tboxdate.Text = Session["tripticketdate"].ToString();
                        }
                        loaddata();
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
        protected void LinkButton4_Click(object sender, EventArgs e)
        {
                loaddata();
        }
        private void loaddata()
        {
            try
            {
                if (tboxdate.Text != null)
                {
                   
                }
                else
                {
                    tboxdate.Text = "";
                }
            
                SqlDataSource1.ConnectionString = sqlconstr;
                SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
                SqlDataSource1.SelectCommand = "TRIP_TICKET_STP";
                DateTime d =Convert.ToDateTime(tboxdate.Text);
                ReportParameter param1 = new ReportParameter("date", d.ToString("dddd, MMMM dd yyyy"));
                ReportViewer1.LocalReport.SetParameters(param1);
                ReportViewer1.LocalReport.Refresh();
                Session["tripticketdate"] = tboxdate.Text;
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString()+ tboxdate.Text);
            }
        }
    }
}