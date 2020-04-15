using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class sidgalleryPage : System.Web.UI.Page
    {

        string filepath = "~/Uploads/ASuploads/SIDreport/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + sid));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath + sid));
                }
                loadimages();
                if (!IsPostBack)
                {
                    if (Session["ErrorMessage"] != null)
                    {
                        errorlbl.Text = Session["ErrorMessage"].ToString();
                        Panel2.Visible = true;
                    }
                    else
                    {
                        Panel2.Visible = false;
                    }

                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString() + "/";
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {

                foreach (HttpPostedFile thefile in FileUpload1.PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    if (fileExtension == ".jpg")
                    {
                        double filesize = thefile.ContentLength;
                        if (filesize < 2097152.00)
                        {
                            thefile.SaveAs(Server.MapPath(filepath + sid + thefile.FileName));
                            Session["ErrorMessage"] = null;
                        }
                        else
                        {
                            CustomValidator err = new CustomValidator();  
                            Session["ErrorMessage"] = "You can only upload files of size lesser than 2 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
                        }
                    }
                    else
                    {
                        Session["ErrorMessage"] = "invalid file type";
                    }
                }
            }
            else
            {
                Session["ErrorMessage"] = "select image first";
            }
            Response.Redirect("~/AFTERSALESPROJ/sidgalleryPage.aspx");

        }
        private void loadimages()
        {

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath + sid)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + sid + fileinfo.Name;
                imgbutton.Width = Unit.Pixel(200);
                imgbutton.Height = Unit.Pixel(200);
                imgbutton.Style.Add("margin", "5px");
                imgbutton.CssClass = "img-thumbnail";
                imgbutton.Click += new ImageClickEventHandler(Imgbutton_Click);
                Table tb = new Table();

                Panel1.Controls.Add(imgbutton);
            }
        }
        private void Imgbutton_Click(object sender, ImageClickEventArgs e)
        {
            //Response.Redirect(((ImageButton)sender).ImageUrl);
            //File.Delete(Server.MapPath(((ImageButton)sender).ImageUrl));
            Session["imgpath"] = ((ImageButton)sender).ImageUrl.ToString();
            Response.Redirect("~/AFTERSALESPROJ/viewimage.aspx?ImageUrl=" + ((ImageButton)sender).ImageUrl);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
        }
    }
}