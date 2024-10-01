using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class callinphotos : System.Web.UI.Page
    {
        string filepath = "~/KMDI_FILES/Aftersales/ASuploads/CallinPhotos/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + callin + "/"));
                    if (!IsExists)
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(filepath + callin + "/"));
                    }
                    loadimages();
                    if (!IsPostBack)
                    {
                        lblproject.Text = projectname;
                        lbladdress.Text = address;
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
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/loginPage.aspx");
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        string callin
        {
            get
            {
                return Session["callinnumber"].ToString();
            }
        }
        string projectname
        {
            get
            {
                return Session["callinProject"].ToString();
            }
        }
        string address
        {
            get
            {
                return Session["callinAddress"].ToString();
            }
        }
        private void loadimages()
        {

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath + callin + "/")))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + callin + "/" + fileinfo.Name;
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
            Session["imgpathcallin"] = ((ImageButton)sender).ImageUrl.ToString();
            Response.Redirect("~/AFTERSALESPROJ/callinviewimage.aspx?ImageUrl=" + ((ImageButton)sender).ImageUrl);
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
                            thefile.SaveAs(Server.MapPath(filepath + callin + "/" + thefile.FileName));
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
            Response.Redirect("~/AFTERSALESPROJ/callinphotos.aspx");

        }
    }
}