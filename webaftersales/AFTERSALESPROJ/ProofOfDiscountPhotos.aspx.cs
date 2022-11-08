using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class ProofOfDiscountPhotos : System.Web.UI.Page
    {
        string filepath = "~/Uploads/ProofOfPayment/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {

                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + subfolder + quotation_id));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath + subfolder + quotation_id));
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

                    if (userfullname == "Warren Mangaring" || userfullname == "Amanda Aquino ")
                    {
                        Panel3.Visible = true;
                        Session["link"] = "s2";
                    }
                    else
                    {
                        Panel3.Visible = false;
                        Session["link"] = "s1";
                    }
                }

            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string userfullname
        {
            get
            {
                return Session["userfullname"].ToString();
            }
        }
        private string subfolder
        {
            get
            {
                return Session["subfolder"].ToString() + "/";
            }
        }
        private string quotation_id
        {
            get
            {
                return Session["quotation_id"].ToString() + "/";
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
                            thefile.SaveAs(Server.MapPath(filepath + subfolder + quotation_id + thefile.FileName));
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
            Response.Redirect("~/AFTERSALESPROJ/ProofOfDiscountPhotos.aspx");

        }
        private void loadimages()
        {

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath + subfolder + quotation_id)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + subfolder + quotation_id + fileinfo.Name;
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
            Session["imgpathsource"] = "ProofOfDiscountPhotos";

            Response.Redirect("~/AFTERSALESPROJ/viewimage.aspx?ImageUrl=" + ((ImageButton)sender).ImageUrl);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string prevpage = Session["page_caller"].ToString();
            if (prevpage == "materials_quotation")
            {
                Response.Redirect("~/AFTERSALESPROJ/quotationForapproval.aspx");
            }
            else if (prevpage == "refoiling_quotation")
            {
                Response.Redirect("~/AFTERSALESPROJ/refoilingForapproval.aspx");
            }
        }
    }
}
