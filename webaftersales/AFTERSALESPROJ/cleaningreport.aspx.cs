using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class cleaningreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {

                        loadparameter();
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

        private void loadparameter()
        {
            ReportParameter param1 = new ReportParameter("project", Session["PROJECT"].ToString());
            ReportParameter param2 = new ReportParameter("address", Session["ADDRESS"].ToString());
            ReportParameter param3 = new ReportParameter("date", Session["cleaningdate"].ToString());
            ReportParameter param4 = new ReportParameter("qno", Session["cleaningqno"].ToString());
            ReportParameter param5 = new ReportParameter("note1", tboxnote1.Text);
            ReportParameter param6 = new ReportParameter("note2", tboxnote2.Text);
            ReportViewer1.LocalReport.SetParameters(param1);
            ReportViewer1.LocalReport.SetParameters(param2);
            ReportViewer1.LocalReport.SetParameters(param3);
            ReportViewer1.LocalReport.SetParameters(param4);
            ReportViewer1.LocalReport.SetParameters(param5);
            ReportViewer1.LocalReport.SetParameters(param6);
            ReportViewer1.LocalReport.Refresh();
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
                return Session["cleaningid"].ToString();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            loadparameter();
        }
    }
}