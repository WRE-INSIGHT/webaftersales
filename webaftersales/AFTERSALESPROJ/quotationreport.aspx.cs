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
            //ReportViewer1.LocalReport.EnableExternalImages = true;
            //string imgparam = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/inspectedby.jpg")).AbsoluteUri;
            //string imgparam1 = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/monitoredby.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[2];
            repparam[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            repparam[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            //repparam[2] = new ReportParameter("profilefinish", Session["COLOR"].ToString());
            //repparam[3] = new ReportParameter("imgparam", imgparam);
            //repparam[4] = new ReportParameter("imgparam1", imgparam1);
            for (int i = 0; i < 2; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

      
        }

    }
}