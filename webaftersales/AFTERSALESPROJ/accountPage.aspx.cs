using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class accountPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }

        protected void updatepasswordbtn_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (checkpassword() == false)
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "val1";
                    err.IsValid = false;
                    err.ErrorMessage = "old password is incorrect";
                    Page.Validators.Add(err);
                }
                else
                {
                    try
                    {
                        string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                        using (SqlConnection sqlcon = new SqlConnection(cs))
                        {
                            sqlcon.Open();
                            SqlCommand sqlcmd = new SqlCommand("update accttb set password = '" + newpasswordtbox.Text + "' where id = " + Convert.ToUInt32(Session["userid"]) + "",sqlcon); 
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.ToString());
                    }
                    finally
                    {
                        Session.Abandon();
                        Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
                    }
                }
            }
        }
        private bool checkpassword()
        {
            bool hasrow;

            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select * from accttb where username = '" + Session["username"].ToString() + "' and password = '" + oldpasswordtbox.Text + "'", sqlcon);
                SqlDataReader dr = sqlcmd.ExecuteReader();
                if (dr.HasRows)
                {
                    hasrow = true;
                }
                else
                {
                    hasrow = false;
                }
            }
            return hasrow;
        }

    }
}