using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class Servicing_Report_SummaryRPT : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ReportViewer2.LocalReport.DisplayName = Session["lblCIN"].ToString();
                ReportViewer2.LocalReport.Refresh();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/Servicing_Report_Summary.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?tboxSearch=" + Request.QueryString["tboxSearch"].ToString()+
                     "&gvPageIndex=" + Request.QueryString["gvPageIndex"].ToString();
            }
        }
        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            ReportViewer2.LocalReport.Refresh();
        }
    }
}