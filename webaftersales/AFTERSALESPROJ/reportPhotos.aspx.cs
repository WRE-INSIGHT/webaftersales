using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class reportPhotos : System.Web.UI.Page
    {
        string filepath = "~/KMDI_FILES/Aftersales/ASuploads/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["link"].ToString() == "s1")
                {
                    Panel3.Visible = false;
                }
                else if (Session["link"].ToString() == "s2")
                {
                    Panel3.Visible = true;
                }
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + cid + sid + rid));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath + cid + sid + rid));
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
        private string cid
        {
            get
            {
                return Session["CIN"].ToString() + "/";
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString() + "/";
            }
        }
        private string rid
        {
            get
            {
                return Session["reportID"].ToString() + "/photos/";
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {

                foreach (HttpPostedFile thefile in FileUpload1.PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    if (fileExtension == ".jpg" || fileExtension == ".png" || fileExtension == ".jpeg" || fileExtension == ".gif")
                    {
                        double filesize = thefile.ContentLength;
                        if (filesize < 29360128)
                        {
                            thefile.SaveAs(Server.MapPath(filepath + cid + sid + rid + thefile.FileName));
                            Session["ErrorMessage"] = null;
                        }
                        else
                        {
                            CustomValidator err = new CustomValidator();
                            Session["ErrorMessage"] = "You can only upload files of size lesser than 28 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
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
            Response.Redirect("~/AFTERSALESPROJ/reportPhotos.aspx");

        }
        private void loadimages()
        {

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath + cid + sid + rid)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + cid + sid + rid + fileinfo.Name;
                imgbutton.Width = Unit.Pixel(200);
                imgbutton.Height = Unit.Pixel(200);
                imgbutton.Style.Add("margin", "5px");
                imgbutton.CssClass = "img-thumbnail";
                imgbutton.AlternateText = fileinfo.Name.ToString();
                imgbutton.Click += new ImageClickEventHandler(Imgbutton_Click);
             
                Panel pn = new Panel();
                pn.Width = Unit.Pixel(210);
                Label lbl = new Label();
                lbl.Text = fileinfo.Name;
                pn.Controls.Add(imgbutton);
                pn.Controls.Add(new LiteralControl("<br />"));
                pn.Controls.Add(lbl);

                PlaceHolder1.Controls.Add(pn);
            }
        }
        private void Imgbutton_Click(object sender, ImageClickEventArgs e)
        {
  
            Session["imgpath"] = ((ImageButton)sender).ImageUrl.ToString();
            Session["imgpathsource"] = "per item";
            Response.Redirect("~/AFTERSALESPROJ/viewimage.aspx?ImageUrl=" + ((ImageButton)sender).ImageUrl+"&ImageName="+ ((ImageButton)sender).AlternateText + "");
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string prevpage = Session["link"].ToString();
            if (prevpage == "s1")
            {
                Response.Redirect("~/AFTERSALESPROJ/ServicingschedulePage.aspx");
            }
            else if (prevpage == "s2")
            {
                Response.Redirect("~/AFTERSALESPROJ/reportPage.aspx");
            }
        }
    }
}