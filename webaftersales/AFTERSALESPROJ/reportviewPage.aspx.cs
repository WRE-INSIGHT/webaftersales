using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class reportviewPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {

                if (!IsPostBack)
                {
                    //Session["dataurlsignature"] = "";
                    //Session["inspectedby"] = "";
                    //Session["inspecteddate"] = "";

                    //Session["dataurlsignature1"] = "";
                    //Session["monitoredby"] = "";
                    //Session["monitoreddate"] = "";
                    getparameters();

                }

            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }

        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters();
        }
        private void getparameters()
        {
            ReportParameter[] repparam = new ReportParameter[3];
            repparam[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            repparam[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            repparam[2] = new ReportParameter("profilefinish", Session["COLOR"].ToString());
            for (int i = 0; i < 3; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

            if (Session["dataurlsignature"] != null)
            {
                ReportParameter[] param = new ReportParameter[3];
                param[0] = new ReportParameter("imgparam", Session["dataurlsignature"].ToString().Replace("data:image/png;base64,", ""));
                param[1] = new ReportParameter("inspectedby", Session["inspectedby"].ToString());
                param[2] = new ReportParameter("inspecteddate", Session["inspecteddate"].ToString());
                for (int i = 0; i < 3; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }
            }
            if (Session["dataurlsignature1"] != null)
            {
                ReportParameter[] param = new ReportParameter[3];
                param[0] = new ReportParameter("imgparam1", Session["dataurlsignature1"].ToString().Replace("data:image/png;base64,", ""));
                param[1] = new ReportParameter("monitoredby", Session["monitoredby"].ToString());
                param[2] = new ReportParameter("monitoreddate", Session["monitoreddate"].ToString());
                for (int i = 0; i < 3; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }

            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["Signatureby"] = "panel1";
            Response.Redirect("~/AFTERSALESPROJ/signaturePage.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["Signatureby"] = "panel2";
            Response.Redirect("~/AFTERSALESPROJ/signaturePage.aspx");
        }
    }
}