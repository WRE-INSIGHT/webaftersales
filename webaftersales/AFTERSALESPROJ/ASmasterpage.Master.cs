using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

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
            if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "3" || Session["userid"].ToString() == "2"))
            {
                countresealantforapproval();
            }
            if (Session["useraccount"].ToString() == "Admin" && (Session["userid"].ToString() == "3" || Session["userid"].ToString() == "2"))
            {
                countrefoilingforapproval();
            }
            getpendingcount();
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getpendingcount()
        {
            try
            {
               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
            
                string str = "select count(id) from [RequestCollectionApproval] where [APPROVED] = '' and [DISAPPROVED] = ''";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
              
                string str = "select count(id) from quotationtb where approvedby = '' and lock = 0";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                           
                            while (rd.Read())
                            {
                                LinkButton3.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " Quotation";
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
              
                string str = "select count(id) from cleaningtbl where notedby = ''";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {

                            while (rd.Read())
                            {
                                LinkButton5.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " Re-cleaning";
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
        private void countresealantforapproval()
        {
            try
            {
              
                string str = "select count(id) from re_sealant_quotation_tbl where notedby = ''";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {

                            while (rd.Read())
                            {
                                LinkButton9.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " Re-sealant";
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
        private void countrefoilingforapproval()
        {
            try
            {
               
                string str = "select count(id) from refoiling_id_tbl where notedby = ''";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {

                            while (rd.Read())
                            {
                                LinkButton7.Text = "<span class='btn btn-danger'  style='font-size:smaller'>" + rd[0].ToString() + "</span>" + " Re-foiling";
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
        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            if (Session["tripticketdate"] == null)
            {
                Session["tripticketdate"] = DateTime.Now.ToString("yyyy-MM-dd");
            }
            Response.Redirect("~/AFTERSALESPROJ/tripticketreport.aspx");
        }
    }
}