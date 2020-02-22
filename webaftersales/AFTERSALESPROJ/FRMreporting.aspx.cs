using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace webaftersales.AFTERSALESPROJ
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label l = this.Master.FindControl("lblheader") as Label;
                l.Text = "Reporting";
               
                Page lastpage =Page.PreviousPage;
                if(lastpage is WebForm1)
                {
                    lblproject.Text = ((WebForm1)lastpage).project;
                    lbladdress.Text = ((WebForm1)lastpage).address;
                }       
               
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/AFTERSALESPROJ/frmReport.aspx");
        }
    }
}