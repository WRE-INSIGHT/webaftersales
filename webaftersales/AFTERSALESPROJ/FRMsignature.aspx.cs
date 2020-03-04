using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            Console.WriteLine("still running here");
            if (IsValid)
            {
                Session["dataurlsignature"] = Request.Form["myurl"];
                Session["inspectedby"] = tboxinspector.Text;
                Session["inspecteddate"] = tboxinspectordate.Text;
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Session["dataurlsignature1"] = Request.Form["myurl1"];
                Session["monitoredby"] = tboxmonitored.Text;
                Session["monitoreddate"] = tboxmonitoreddate.Text;
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
            }

        }
    }
}
