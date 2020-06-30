using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class callinviewimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                Image1.ImageUrl = Request.QueryString["ImageUrl"];
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string imagepath
        {
            get
            {
                return Session["imgpathcallin"].ToString();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/callinphotos.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            File.Delete(Server.MapPath(imagepath));
            Response.Redirect("~/AFTERSALESPROJ/callinphotos.aspx");
        }
    }
}