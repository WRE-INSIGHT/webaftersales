using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class resealantsignature : System.Web.UI.Page
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
        private string columnname
        {
            get
            {
                return Session["columnname"].ToString();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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

            senderbutton();


        }
        private void senderbutton()
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/Aftersales/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/RESEALANT/" + Session["re_sealantqno"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + columnname + ".jpg"));

                string str = "update re_sealant_quotation_tbl set " + columnname + "='" + Session["userid"].ToString() + "' where ID = @ID";
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
                        sqlcmd.Parameters.AddWithValue("@ID", Session["re_sealantid"].ToString());
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
                Response.Redirect("~/AFTERSALESPROJ/resealantreport.aspx");
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/Aftersales/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/RESEALANT/" + Session["re_sealantqno"].ToString() + "/signature/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                string sourcepath = "~/KMDI_FILES/Aftersales/ASuploads/UserSignature/" + Session["userid"].ToString() + "/";
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

                string str = "update re_sealant_quotation_tbl set " + columnname + "='" + Session["userid"].ToString() + "' where ID = @ID";
                updatetb(str);

            }
        }
    }
}