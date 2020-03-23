using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class SignupPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signupbtn_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (checkusername() == true)
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "val1";
                    err.IsValid = false;
                    err.ErrorMessage = "Username already exist";
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
                            SqlCommand sqlcmd = sqlcon.CreateCommand();
                            sqlcmd.CommandText = "stpSignup";
                            sqlcmd.CommandType = CommandType.StoredProcedure;
                            sqlcmd.Parameters.AddWithValue("@lastname", lastnametbox.Text);
                            sqlcmd.Parameters.AddWithValue("@firstname", firstnametbox.Text);
                            sqlcmd.Parameters.AddWithValue("@username", usernametbox.Text);
                            sqlcmd.Parameters.AddWithValue("@password", passwordtbox.Text);
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.ToString());
                    }
                    finally
                    {
                        Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
                    }
                }
            }
        }
        private bool checkusername()
        {
            bool hasrow;

            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select * from accttb where username = '" + usernametbox.Text + "'", sqlcon);
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

        protected void firstnametbox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}