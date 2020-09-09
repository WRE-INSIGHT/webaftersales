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
    public partial class reportviewPage : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {

                if (!IsPostBack)
                {
                    
                    SqlDataSource2.ConnectionString = sqlconstr;
                    SqlDataSource3.ConnectionString = sqlconstr;
                    ReportViewer1.LocalReport.Refresh();
                    getparameters();
                    if (Session["link"].ToString() == "s1" || Session["link"].ToString() == "s3")
                    {
                        Panel1.Visible = false;
                    }
                    else if (Session["link"].ToString() == "s2")
                    {
                        Panel1.Visible = true;
                    }
                }

            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters();
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string imgparam = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/inspectedby.jpg")).AbsoluteUri;
            string imgparam1 = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/signature/monitoredby.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[5];
            repparam[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            repparam[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            repparam[2] = new ReportParameter("profilefinish", Session["COLOR"].ToString());
            repparam[3] = new ReportParameter("imgparam", imgparam);
            repparam[4] = new ReportParameter("imgparam1", imgparam1);
            for (int i = 0; i < 5; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

            //if (Session["dataurlsignature"] != null)
            //{
            //    ReportParameter[] param = new ReportParameter[3];
            //    param[0] = new ReportParameter("imgparam",imgparam);
            //    param[1] = new ReportParameter("inspectedby", Session["inspectedby"].ToString());
            //    param[2] = new ReportParameter("inspecteddate", Session["inspecteddate"].ToString());
            //    for (int i = 0; i < 3; i++)
            //    {
            //        ReportViewer1.LocalReport.SetParameters(param[i]);
            //    }
            //}
            //if (Session["dataurlsignature1"] != null)
            //{
            //    ReportParameter[] param = new ReportParameter[3];
            //    param[0] = new ReportParameter("imgparam1", Session["dataurlsignature1"].ToString().Replace("data:image/png;base64,", ""));
            //    param[1] = new ReportParameter("monitoredby", Session["monitoredby"].ToString());
            //    param[2] = new ReportParameter("monitoreddate", Session["monitoreddate"].ToString());
            //    for (int i = 0; i < 3; i++)
            //    {
            //        ReportViewer1.LocalReport.SetParameters(param[i]);
            //    }

            //}
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

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            string prevpage = Session["link"].ToString();
            if (prevpage == "s1")
            {
                Response.Redirect("~/AFTERSALESPROJ/ServicingschedulePage.aspx");
            }
            else if (prevpage == "s2")
            {
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
            else if (prevpage == "s3")
            {
                Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
            }

        }
    }
}