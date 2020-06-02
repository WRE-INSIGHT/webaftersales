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
            if (!IsPostBack)
            {
                if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
                {
                    usernametbox.Text = Request.Cookies["UserName"].Value;
                    passwordtbox.Attributes["value"] = Request.Cookies["Password"].Value;
                }
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
        protected void loginbtn_Click(object sender, EventArgs e)
        {
            try
            {



                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = new SqlCommand("select username,ID,PID,accttype,Firstname+' '+lastname as fullname from ACCTTB where username = @username and password = @password", sqlcon);
                    sqlcmd.Parameters.AddWithValue("@UserName", usernametbox.Text);
                    sqlcmd.Parameters.AddWithValue("@Password", passwordtbox.Text);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    if (rd.HasRows)
                    {

                        while (rd.Read())
                        {
                         
                            Session["username"] = rd[0].ToString();
                            Session["userid"] = rd[1].ToString();
                            Session["userpid"] = rd[2].ToString();
                            Session["useraccount"] = rd[3].ToString();
                            Session["userfullname"] = rd[4].ToString();
                            if (CheckBox1.Checked)
                            {
                                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
                            }
                            else
                            {
                                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);

                            }
                            Response.Cookies["UserName"].Value = usernametbox.Text.Trim();
                            Response.Cookies["Password"].Value = passwordtbox.Text.Trim();
                            if (Session["useraccount"].ToString() == "Admin")
                            {
                                Response.Redirect("~/AFTERSALESPROJ/homePage.aspx");
                            }
                            else
                            {
                                if (Session["userpid"].ToString() == "")
                                {
                                    CustomValidator err = new CustomValidator();
                                    err.ValidationGroup = "val1";
                                    err.IsValid = false;
                                    err.ErrorMessage = "account not verified";
                                    Page.Validators.Add(err);
                                }
                                else
                                {
                                    Response.Redirect("~/AFTERSALESPROJ/homePage.aspx");
                                }
                            }

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
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
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