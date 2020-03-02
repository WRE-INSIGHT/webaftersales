using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

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
        protected void Button1_Click(object sender, EventArgs e)
        {      
            Session["TestSession"] = Request.Form["myurl"];
            ReportParameter param1 = new ReportParameter("imagebyte", Session["TestSession"].ToString().Replace("data:image/png;base64,",""));
            ReportViewer1.LocalReport.SetParameters(param1);

           
        }
    
    }
}
