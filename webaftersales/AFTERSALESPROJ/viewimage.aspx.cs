using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class viewimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                Image1.ImageUrl = Request.QueryString["ImageUrl"];
                if (Session["link"].ToString() == "s1")
                {
                    Button1.Visible = false;
                }
                else if (Session["link"].ToString() == "s2")
                {
                    Button1.Visible = true;
                }
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
                return Session["imgpath"].ToString();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/sidgalleryPage.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            File.Delete(Server.MapPath(imagepath));
            Response.Redirect("~/AFTERSALESPROJ/sidgalleryPage.aspx");
        }
    }
}