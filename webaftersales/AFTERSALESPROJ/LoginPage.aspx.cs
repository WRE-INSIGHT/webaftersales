using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] != null)
            {
                Response.Redirect("~/AFTERSALESPROJ/homePage.aspx");
            }
        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select username,id from ACCTTB where username = @username and password = @password", sqlcon);
                sqlcmd.Parameters.AddWithValue("@UserName", usernametbox.Text);
                sqlcmd.Parameters.AddWithValue("@Password", passwordtbox.Text);
                SqlDataReader rd = sqlcmd.ExecuteReader();
                if (rd.HasRows)
                {
                 
                    while (rd.Read())
                    {
                        Session["username"] = rd[0].ToString();
                        Session["userid"] = rd[1].ToString();
                        Response.Redirect("~/AFTERSALESPROJ/homePage.aspx");
                    }
                    rd.Close();
                }
                else
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "val1";
                    err.IsValid = false;
                    err.ErrorMessage = "invalid login";
                    Page.Validators.Add(err);
                }
            }
        }
        //public string Encrypt(string clearText)
        //{
        //    string EncryptionKey = "MAKV2SPBNI99212";
        //    byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        //    using (Aes encryptor = Aes.Create())
        //    {
        //        Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6E, 0x20, 0x4D, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
        //        encryptor.Key = pdb.GetBytes(32);
        //        encryptor.IV = pdb.GetBytes(16);
        //        using (MemoryStream ms = new MemoryStream())
        //        {
        //            using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
        //            {
        //                cs.Write(clearBytes, 0, clearBytes.Length);
        //                cs.Close();
        //            }
        //            clearText = Convert.ToBase64String(ms.ToArray());
        //        }
        //    }
        //    return clearText;
        //}

     
    }
}