using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class quotationsignature : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {

                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string columnname
        {
            get
            {
                return Session["columnname"].ToString();
            }
        }
        public static void UploadImage(string imageData, string fileNameWitPath)
        {
            using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))

                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            if (columnname == "PREPAREDBY")
            {
                senderbutton(columnname);
            }
            else if (columnname == "APPROVEDBY")
            {
                senderbutton(columnname);
            }
            if (columnname == "ACCEPTEDBY")
            {
                senderbutton(columnname);
            }
        }
        private void senderbutton(string column)
        {
            if (IsValid)
            {

                string filepath = "~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + Session["aseno"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + column + ".jpg"));

                string str = "update quotationtb set " + column + "='" + tboxname.Text + "' where aseno = @aseno";
                updatetb(str);

            }
        }
        private void updatetb(string qry)
        {
            try
            {
             
               using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(qry, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", Session["aseno"].ToString());
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/quotationreport.aspx");
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + Session["aseno"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                string sourcepath = "~/Uploads/ASuploads/UserSignature/" + Session["userid"].ToString() + "/";
                Boolean IsExists1 = System.IO.Directory.Exists(Server.MapPath(sourcepath));
                if (!IsExists1)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(sourcepath));
                }

                foreach (string strfilename in Directory.GetFiles(Server.MapPath(sourcepath)))
                {
                  
                    FileInfo fileinfo = new FileInfo(strfilename);
                    File.Copy(Server.MapPath(sourcepath + fileinfo.Name), Server.MapPath(filepath + columnname + ".jpg"), true);
                }

                string str = "update quotationtb set " + columnname + "='" + Session["userfullname"].ToString() + "' where aseno = @aseno";
                updatetb(str);

            }
        }
    }
}