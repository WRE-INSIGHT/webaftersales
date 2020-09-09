using Microsoft.Reporting.WebForms;
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
    public partial class cleaningreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        SqlDataSource1.ConnectionString = sqlconstr;
                        loadparameter();
                    }
                }
                else
                {
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/loginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void loadparameter()
        {


            ReportViewer1.LocalReport.EnableExternalImages = true;
            string prepared = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/CLEANING/" + Session["cleaningqno"].ToString() + "/signature/PREPAREDBY.jpg")).AbsoluteUri;
            string noted = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/CLEANING/" + Session["cleaningqno"].ToString() + "/signature/NOTEDBY.jpg")).AbsoluteUri;
            ReportParameter[] param = new ReportParameter[6];
            param[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            param[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            param[2] = new ReportParameter("date", Session["cleaningdate"].ToString());
            param[3] = new ReportParameter("qno", Session["cleaningqno"].ToString());
            param[4] = new ReportParameter("prepared", prepared);
            param[5] = new ReportParameter("noted", noted);
            for(int i = 0; i < 6; i++)
            {
                ReportViewer1.LocalReport.SetParameters(param[i]);
            }
            loadnames();
            ReportViewer1.LocalReport.Refresh();
        }

        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void loadnames()
        {
            string preparedby="", preparedbytitle="", notedby="", notedbytitle = "",note1="",note2="";

         
            try
            {
                string str = " declare @preparedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select preparedby from cleaningtbl where id = @iid))	" +
" declare @preparedbytitle as varchar(max) = (select TITLE from accttb where id = (select preparedby from cleaningtbl where id = @iid))				" +
" declare @notedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select notedby from cleaningtbl where id = @iid))		" +
" declare @notedbytitle as varchar(max) = (select TITLE from accttb where id = (select notedby from cleaningtbl where id = @iid))					" +
" select @preparedby,@preparedbytitle,@notedby,@notedbytitle,note1,note2 from cleaningtbl where id = @iid																						";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        using (SqlDataReader dr = sqlcmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                preparedby = dr[0].ToString();
                                preparedbytitle = dr[1].ToString();
                                notedby = dr[2].ToString();
                                notedbytitle = dr[3].ToString();
                                note1 = dr[4].ToString();
                                note2 = dr[5].ToString();

                            }
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                ReportParameter[] param = new ReportParameter[6];
                param[0] = new ReportParameter("preparedby", preparedby);
                param[1] = new ReportParameter("preparedbytitle", preparedbytitle);
                param[2] = new ReportParameter("notedby", notedby);
                param[3] = new ReportParameter("notedbytitle", notedbytitle);
                param[4] = new ReportParameter("note1", note1);
                param[5] = new ReportParameter("note2", note2);
                for (int i = 0; i < 6; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }
                tboxnote1.Text = note1;
                tboxnote2.Text = note2;
            }
        }
        private string iid
        {
            get
            {
                return Session["cleaningid"].ToString();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {try
            {
             
                string str = "update cleaningtbl set note1=@note1,note2=@note2 where id = @id";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", iid);
                        sqlcmd.Parameters.AddWithValue("@note1", tboxnote1.Text);
                        sqlcmd.Parameters.AddWithValue("@note2", tboxnote2.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                loadparameter();
            }

          
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "PREPAREDBY";
            Response.Redirect("~/AFTERSALESPROJ/cleaningsignature.aspx");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "NOTEDBY";
            Response.Redirect("~/AFTERSALESPROJ/cleaningsignature.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["cleaning_report_sender"].ToString() == "cleaningpage")
            {
                Response.Redirect("~/AFTERSALESPROJ/cleaningpage.aspx");
            }
            else if (Session["cleaning_report_sender"].ToString() == "forapproval")
            {
                Response.Redirect("~/AFTERSALESPROJ/cleaningForapproval.aspx");
            }
        }
    }
}