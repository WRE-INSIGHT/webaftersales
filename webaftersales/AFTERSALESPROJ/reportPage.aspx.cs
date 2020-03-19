using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class reportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] != null)
            {
                lblproject.Text = Session["PROJECT"].ToString();
                lbladdress.Text = Session["ADDRESS"].ToString();
                lbljo.Text = Session["JO"].ToString();
                lblcolor.Text = Session["COLOR"].ToString();
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
    }
}