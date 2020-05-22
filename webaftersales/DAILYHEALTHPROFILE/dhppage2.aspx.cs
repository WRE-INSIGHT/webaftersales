using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.DAILYHEALTHPROFILE
{
    public partial class dhppage2 : System.Web.UI.Page
    {
        string filepath3 = "~/Uploads/DHPuploads/page2/testresult/";
        protected void Page_Load(object sender, EventArgs e)

        {
           
            if (Session["dhp_EMPNO"] != null)
            {
                loadimages();
                loadsignature();
                if (!IsPostBack)
                {
                    lbldate.Text = Session["dhpdate"].ToString();
                    lblname.Text = Session["dhpname"].ToString();
                    lblempno.Text = Session["dhpempno"].ToString();
                    lblage.Text = Session["dhpage"].ToString();
                    lblbirthday.Text = Session["dhpbirthday"].ToString();
                    getdata();
                    signaturephoto();
                    testresultphotos();
                 
                }

            }
            else
            {
                Response.Redirect("~/DAILYHEALTHPROFILE/dhplogin.aspx");
            }
        }
        private string empno
        {
            get
            {
                return Session["dhp_EMPNO"].ToString();
            }
        }
        private string dhpid
        {
            get
            {
                return Session["dhp_id"].ToString();
            }
        }
        private void signaturephoto()
        {
        
            string filepath = "~/Uploads/DHPuploads/page2/signature/" + empno + dhpid + "/";
            Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
            if (!IsExists)
            {
                System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
            }
          
        }
        private void testresultphotos()
        {

            string filepath2 = "~/Uploads/DHPuploads/page2/testresult/" + empno + dhpid + "/";
            Boolean IsExists2 = System.IO.Directory.Exists(Server.MapPath(filepath2));
            if (!IsExists2)
            {
                System.IO.Directory.CreateDirectory(Server.MapPath(filepath2));
            }


        }
        private void loadsignature()
        {
            Panel1.Controls.Clear();
            Image img = new Image();
            string filepath = "~/Uploads/DHPuploads/page2/signature/" + empno + dhpid + "/";

            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath + fileinfo.Name;
                imgbutton.Width = Unit.Pixel(350);
                imgbutton.Height = Unit.Pixel(200);
                imgbutton.Style.Add("margin", "5px");
                imgbutton.CssClass = "img-thumbnail";
                Panel1.Controls.Add(imgbutton);
            }

            //img.ImageUrl = filepath + empno + "page2.jpg";
            //img.Width = Unit.Pixel(350);
            //img.Height = Unit.Pixel(200);
            //img.Style.Add("margin", "5px");
            //img.CssClass = "img-thumbnail";
            //Panel1.Controls.Add(img);
        }
        private void loadimages()
        {
            Panel2.Controls.Clear();
            string filepath2 = "~/Uploads/DHPuploads/page2/testresult/" + empno + dhpid + "/";
            foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath2)))
            {
                ImageButton imgbutton = new ImageButton();
                FileInfo fileinfo = new FileInfo(strfilename);
                imgbutton.ImageUrl = filepath2 + fileinfo.Name;
                imgbutton.Width = Unit.Pixel(300);
                imgbutton.Height = Unit.Pixel(300);
                imgbutton.Style.Add("margin", "5px");
                imgbutton.CssClass = "img-thumbnail";
                imgbutton.Click += new ImageClickEventHandler(Imgbutton_Click);
                Table tb = new Table();

                Panel2.Controls.Add(imgbutton);
            }
        }
        private void Imgbutton_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect(((ImageButton)sender).ImageUrl);
            //File.Delete(Server.MapPath(((ImageButton)sender).ImageUrl));
            //Session["imgpath"] = ((ImageButton)sender).ImageUrl.ToString();
            //Response.Redirect("~/AFTERSALESPROJ/viewimage.aspx?ImageUrl=" + ((ImageButton)sender).ImageUrl);
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "g1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void getdata()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = " select ID,EMPNO,DHPID,TRAVELHISTORY,EXPOSURETOVIRUS,DATETESTDONE,TESTRESULT,PATIENTNAME,OTHER,AFFIRMEDWITNESS,PHYSICIAN,RECOENDO,RECOCALLIN,RECOSENDHOME,RECOOTHER from dhppage2 where empno =@empno and dhpid=@dhpid";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@empno", empno);
                        sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                        string testresult = "";
                        string travelhistory = "";
                        string sendhome = "";
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                tboxexposuretovirus.Text = rd["EXPOSURETOVIRUS"].ToString();
                                tboxdatetestdone.Text = rd["DATETESTDONE"].ToString();
                                tboxpatientname.Text = rd["PATIENTNAME"].ToString();
                                tboxother.Text = rd["OTHER"].ToString();
                                tboxaffirmedwitness.Text = rd["AFFIRMEDWITNESS"].ToString();
                                tboxphysician.Text = rd["PHYSICIAN"].ToString();
                                testresult = rd["TESTRESULT"].ToString();
                                travelhistory = rd["TRAVELHISTORY"].ToString();
                                tboxrecoendo.Text = rd["RECOENDO"].ToString();
                                tboxrecocallin.Text = rd["RECOCALLIN"].ToString();
                                tboxrecoother.Text = rd["RECOOTHER"].ToString();
                                sendhome = rd["RECOSENDHOME"].ToString();
                            }
                        }
                        for (int i = 0; i < cboxTRAVELHISTORY.Items.Count; i++)
                        {
                            if (travelhistory.Contains(cboxTRAVELHISTORY.Items[i].Value.ToString()))
                            {
                                cboxTRAVELHISTORY.Items[i].Selected = true;
                            }
                        }
                        for (int i = 0; i < cboxTESTRESULT.Items.Count; i++)
                        {
                            if (testresult.Contains(cboxTESTRESULT.Items[i].Value.ToString()))
                            {
                                cboxTESTRESULT.Items[i].Selected = true;
                            }
                        }

                        if (tboxrecoendo.Text != "")
                        {
                            cboxrecoendo.Checked = true;
                        }
                        if (tboxrecocallin.Text != "")
                        {
                            cboxrecocallin.Checked = true;
                        }
                        if (sendhome != "")
                        {
                            cboxrecosendhome.Checked = true;
                        }
                        if (tboxrecoother.Text != "")
                        {
                            cboxrecoother.Checked = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            insert();
        }
        private void insert()
        {
            try
            {

                string travelhistory = "";
                foreach (ListItem li in cboxTRAVELHISTORY.Items)
                {
                    if (li.Selected)
                    {
                        travelhistory += " *" + li.Value.ToString();
                    }
                }
                string testresult = "";
                foreach (ListItem li in cboxTESTRESULT.Items)
                {
                    if (li.Selected)
                    {
                        testresult += " *" + li.Value.ToString();
                    }
                }
                string sendhome = "";
                if (cboxrecosendhome.Checked)
                {
                    sendhome = "Send home";
                }
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string find = "select * from dhppage2 where empno=@empno and dhpid=@dhpid";
                bool exist = false;
                string insertstr = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from dhppage2)" +
                                " insert into dhppage2" +
                                " (ID,EMPNO,DHPID,TRAVELHISTORY,EXPOSURETOVIRUS,DATETESTDONE,TESTRESULT,PATIENTNAME,OTHER,AFFIRMEDWITNESS,PHYSICIAN,recoendo,recocallin,recosendhome,recoother)" +
                                " values(@id,@empno,@dhpid,@travelhistory,@exposuretovirus,@datetestdone,@testresult,@patientname,@other,@affirmedwitness,@physician,@recoendo,@recocallin,@recosendhome,@recoother)";
                string updatestr = " update dhppage2 set				   " +
                                " TRAVELHISTORY=@travelhistory,		   " +
                                " EXPOSURETOVIRUS=@exposuretovirus,	   " +
                                " DATETESTDONE=@datetestdone,		   " +
                                " TESTRESULT=@testresult,			   " +
                                " PATIENTNAME=@patientname,			   " +
                                " OTHER=@other,						   " +
                                " AFFIRMEDWITNESS=@affirmedwitness,	   " +
                                " PHYSICIAN=@physician,				   " +
                                " recoendo=@recoendo,				   " +
                                " recocallin=@recocallin,			   " +
                                " recosendhome=@recosendhome,		   " +
                                " recoother=@recoother				   " +
                                " where EMPNO=@empno and DHPID=@dhpid  ";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@empno", empno);
                        sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                exist = true;
                            }
                            else
                            {
                                exist = false;
                            }
                        }

                    }
                    if (exist)
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(updatestr, sqlcon))
                        {
                            setparam(sqlcmd, travelhistory, testresult, sendhome);
                        }
                    }
                    else
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(insertstr, sqlcon))
                        {
                            setparam(sqlcmd, travelhistory, testresult, sendhome);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "val2";
                err.IsValid = false;
                err.ErrorMessage = "page 2 saved successfully";
                Page.Validators.Add(err);
            }
        }
        private void setparam(SqlCommand sqlcmd, string travelhistory, string testresult, string sendhome)
        {
            sqlcmd.Parameters.AddWithValue("@empno", empno);
            sqlcmd.Parameters.AddWithValue("@dhpid", dhpid);
            sqlcmd.Parameters.AddWithValue("@exposuretovirus", tboxexposuretovirus.Text);
            sqlcmd.Parameters.AddWithValue("@datetestdone", tboxdatetestdone.Text);
            sqlcmd.Parameters.AddWithValue("@travelhistory", travelhistory);
            sqlcmd.Parameters.AddWithValue("@testresult", testresult);
            sqlcmd.Parameters.AddWithValue("@patientname", tboxpatientname.Text);
            sqlcmd.Parameters.AddWithValue("@other", tboxother.Text);
            sqlcmd.Parameters.AddWithValue("@affirmedwitness", tboxaffirmedwitness.Text);
            sqlcmd.Parameters.AddWithValue("@physician", tboxphysician.Text);
            sqlcmd.Parameters.AddWithValue("@recoendo", tboxrecoendo.Text);
            sqlcmd.Parameters.AddWithValue("@recocallin", tboxrecocallin.Text);
            sqlcmd.Parameters.AddWithValue("@recosendhome", sendhome);
            sqlcmd.Parameters.AddWithValue("@recoother", tboxrecoother.Text);
            sqlcmd.ExecuteNonQuery();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            insert();
            Session["dhp_pagesender"] = "page2";
            Response.Redirect("~/DAILYHEALTHPROFILE/dhpsignature.aspx");
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
                        if (filesize < 4194304.00)
                        {
                            thefile.SaveAs(Server.MapPath(filepath3 +empno + dhpid + "/" + thefile.FileName));
                            loadimages();
                            loadsignature();
                        }
                        else
                        {
                            CustomValidator err = new CustomValidator();
                            errorrmessage("You can only upload files of size lesser than 4 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB");
                        }
                    }
                    else
                    {
                        errorrmessage("invalid file type");
                    }
                }
            }
            else
            {
                errorrmessage("select image first");
            }
          
        }
    }
}