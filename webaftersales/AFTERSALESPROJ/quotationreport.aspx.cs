using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class quotationreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        getparameters();
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
        private string aseno
        {
            get
            {
                return Session["aseno"].ToString();
            }
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string prepared = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString()+"/" + Session["aseno"].ToString()+ "/signature/PREPAREDBY.jpg")).AbsoluteUri;
            string approved = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + Session["aseno"].ToString() + "/signature/APPROVEDBY.jpg")).AbsoluteUri;
            string accepted = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + Session["aseno"].ToString() + "/signature/ACCEPTEDBY.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[5];
            repparam[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            repparam[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            repparam[2] = new ReportParameter("prepared", prepared);
            repparam[3] = new ReportParameter("approved", approved);
            repparam[4] = new ReportParameter("accepted", accepted);
            for (int i = 0; i < 5; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

      
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "PREPAREDBY";
            Response.Redirect("~/AFTERSALESPROJ/quotationsignature.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "APPROVEDBY";
            Response.Redirect("~/AFTERSALESPROJ/quotationsignature.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "ACCEPTEDBY";
            Response.Redirect("~/AFTERSALESPROJ/quotationsignature.aspx");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {

            if (Session["qu_report_sender"].ToString() == "qu_sender_qu")
            {
                Response.Redirect("~/AFTERSALESPROJ/quotation.aspx");
            }
            else if (Session["qu_report_sender"].ToString() == "qu_sernder_approval")
            {
                Response.Redirect("~/AFTERSALESPROJ/quotationforms/quotationForapproval.aspx");
            }
        }
    }
}