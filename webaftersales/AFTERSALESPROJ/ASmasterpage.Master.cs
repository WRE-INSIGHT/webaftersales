using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class ASmasterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            acctlink.Text = "Hi, " + Session["username"].ToString() + " ";
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["teamsender"] = null;
            Response.Redirect("~/AFTERSALESPROJ/teampage.aspx");
        }
    }
}