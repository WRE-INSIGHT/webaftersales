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
    public partial class ASmasterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            username.Text = Session["username"].ToString() + " ";
            if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "2" || Session["userid"].ToString() == "24" || Session["userid"].ToString() == "3"))
            {
                countjoapproval();
            }
            if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "4" || Session["userid"].ToString() == "9" || Session["userid"].ToString() == "10") || Session["userid"].ToString() == "3" || Session["userid"].ToString() == "2")
            {
                countforapproval();
            }
            if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "3" || Session["userid"].ToString() == "2"))
            {
                countcleaningforapproval();
            }
            getpendingcount();
        }
        private void getpendingcount()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("select count(id) from servicingtb where [status] = 'Pending For Reschedule'", sqlcon))
                    {
                        sqlcon.Open();
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                HyperLink8.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " Pending JO";
                            }
                        }
                    }

                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
            }
        }
        private void countjoapproval()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "select count(id) from [RequestCollectionApproval] where [APPROVED] = '' and [DISAPPROVED] = ''";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                          
                            while (rd.Read())
                            {
                                HyperLink9.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " For JO Approval";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
        private void countforapproval()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "select count(id) from quotationtb where approvedby = ''";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                           
                            while (rd.Read())
                            {
                                LinkButton3.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " For Approval";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
        private void countcleaningforapproval()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = "select count(id) from cleaningtbl where notedby = ''";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {

                            while (rd.Read())
                            {
                                LinkButton5.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " For Approval";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["teamsender"] = null;
            Response.Redirect("~/AFTERSALESPROJ/teampage.aspx");
        }
    }
}