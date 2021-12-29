using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class Refoilingreport : System.Web.UI.Page
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
        private void loadparameter()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string prepared = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/REFOILING/" + Session["refoilingqno"].ToString() + "/signature/PREPAREDBY.jpg")).AbsoluteUri;
            string noted = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/REFOILING/" + Session["refoilingqno"].ToString() + "/signature/NOTEDBY.jpg")).AbsoluteUri;
            string reviewed = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/REFOILING/" + Session["refoilingqno"].ToString() + "/signature/REVIEWEDBY.jpg")).AbsoluteUri;
            ReportParameter[] param = new ReportParameter[8];
            param[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            param[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            param[2] = new ReportParameter("date", Session["refoilingdate"].ToString());
            param[3] = new ReportParameter("qno", refoiling_qno);
            param[4] = new ReportParameter("prepared", prepared);
            param[5] = new ReportParameter("noted", noted);
            param[6] = new ReportParameter("reviewed", reviewed);
            param[7] = new ReportParameter("miscellaneous", Session["miscellaneous"].ToString());
            for (int i = 0; i < 8; i++)
            {
                ReportViewer1.LocalReport.SetParameters(param[i]);
            }
            loadnames();
            ReportViewer1.LocalReport.Refresh();
        }
        private void loadnames()
        {
            string preparedby = "",
                preparedbytitle = "",
                notedby = "",
                notedbytitle = "",
                reviewedby = "",
                reviewedbytitle = "",
                reference = "",
                salutation = "",
                body = "";


            try
            {
                string str = " declare @preparedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select preparedby from refoiling_id_tbl where QNO = @iid))	" +
" declare @preparedbytitle as varchar(max) = (select TITLE from accttb where id = (select preparedby from refoiling_id_tbl where QNO = @iid))				" +
" declare @notedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select notedby from refoiling_id_tbl where QNO = @iid))		" +
" declare @notedbytitle as varchar(max) = (select TITLE from accttb where id = (select notedby from refoiling_id_tbl where QNO = @iid))					" +
" declare @reviewedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select reviewedby from refoiling_id_tbl where QNO = @iid))		" +
" declare @reviewedbytitle as varchar(max) = (select TITLE from accttb where id = (select reviewedby from refoiling_id_tbl where QNO = @iid))					" +
" select top 1 @preparedby,@preparedbytitle,@notedby,@notedbytitle,@reviewedby,@reviewedbytitle,reference,salutation,body from refoiling_id_tbl where QNO = @iid																					";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@iid", refoiling_qno);
                        using (SqlDataReader dr = sqlcmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                preparedby = dr[0].ToString();
                                preparedbytitle = dr[1].ToString();
                                notedby = dr[2].ToString();
                                notedbytitle = dr[3].ToString();
                                reviewedby = dr[4].ToString();
                                reviewedbytitle = dr[5].ToString();
                                reference = dr[6].ToString();
                                salutation = dr[7].ToString();
                                body = dr[8].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                ReportParameter[] param = new ReportParameter[9];
                param[0] = new ReportParameter("preparedby", preparedby);
                param[1] = new ReportParameter("preparedbytitle", preparedbytitle);
                param[2] = new ReportParameter("notedby", notedby);
                param[3] = new ReportParameter("notedbytitle", notedbytitle);
                param[4] = new ReportParameter("reviewedby", reviewedby);
                param[5] = new ReportParameter("reviewedbytitle", reviewedbytitle);
                param[6] = new ReportParameter("reference", reference);
                param[7] = new ReportParameter("salutation", salutation);
                param[8] = new ReportParameter("body", body);
                for (int i = 0; i < 9; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string refoiling_qno
        {
            get
            {
                return Session["refoilingqno"].ToString();
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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["refoiling_report_sender"].ToString() == "refoilingpage")
            {
                Response.Redirect("~/AFTERSALESPROJ/refoilingpage.aspx");
            }
            else if (Session["refoiling_report_sender"].ToString() == "forapproval")
            {
                Response.Redirect("~/AFTERSALESPROJ/refoilingForapproval.aspx");
            }
        }
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "PREPAREDBY";
            Response.Redirect("~/AFTERSALESPROJ/refoilingsignature.aspx");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "NOTEDBY";
            Response.Redirect("~/AFTERSALESPROJ/refoilingsignature.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "REVIEWEDBY";
            Response.Redirect("~/AFTERSALESPROJ/refoilingsignature.aspx");
        }
    }
}