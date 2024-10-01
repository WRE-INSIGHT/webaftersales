using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{

    public partial class WebForm5 : System.Web.UI.Page
    {
        static string sid = "1000";
        string filepath = "~/KMDI_FILES/Aftersales/ASuploads/SIDreport/" + sid + "/";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                loadimages();
                if (!IsPostBack)
                {


                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName);
                if (fileExtension.ToLower() != ".jpg")
                {
                    Response.Write("invalid format");
                }
                else
                {
                    int filesize = FileUpload1.PostedFile.ContentLength;
                    if (filesize < 2097152)
                    {

                        FileUpload1.SaveAs(Server.MapPath(filepath + FileUpload1.FileName));
                    }
                    else
                    {
                        Response.Write("size exeeded 2mb");
                    }
                }
                Response.Redirect("~/AFTERSALESPROJ/WebForm5.aspx");
            }

        }
        private void loadimages()
        {

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + fileinfo.Name;
                imgbutton.Width = Unit.Pixel(300);
                imgbutton.Height = Unit.Pixel(300);
                imgbutton.Style.Add("margin", "20px");
                imgbutton.CssClass = "img-thumbnail";
                imgbutton.Click += new ImageClickEventHandler(Imgbutton_Click);
                Panel1.Controls.Add(imgbutton);
            }
        }
        private void Imgbutton_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect(((ImageButton)sender).ImageUrl);
            //Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx?ImageUrl="+ ((ImageButton)sender).ImageUrl);
        }
    }
}