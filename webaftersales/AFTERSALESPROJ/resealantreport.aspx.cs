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
    public partial class resealantreport : System.Web.UI.Page
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
            string prepared = new Uri(Server.MapPath("~/KMDI_FILES/Aftersales/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/RESEALANT/" + Session["re_sealantqno"].ToString() + "/signature/PREPAREDBY.jpg")).AbsoluteUri;
            string noted = new Uri(Server.MapPath("~/KMDI_FILES/Aftersales/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/RESEALANT/" + Session["re_sealantqno"].ToString() + "/signature/NOTEDBY.jpg")).AbsoluteUri;
            ReportParameter[] param = new ReportParameter[6];
            param[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            param[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            param[2] = new ReportParameter("date", Session["re_sealantdate"].ToString());
            param[3] = new ReportParameter("qno", Session["re_sealantqno"].ToString());
            param[4] = new ReportParameter("prepared", prepared);
            param[5] = new ReportParameter("noted", noted);
            for (int i = 0; i < 6; i++)
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
            string preparedby = "", preparedbytitle = "", notedby = "", notedbytitle = "", reference = "", salutation = "", body = "";
            string labor_rate = "", no_of_worker = "", mobilization = "", labor_cost = "";


            try
            {
                string str = " declare @preparedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select preparedby from re_sealant_quotation_tbl where id = @iid))	" +
" declare @preparedbytitle as varchar(max) = (select TITLE from accttb where id = (select preparedby from re_sealant_quotation_tbl where id = @iid))				" +
" declare @notedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select notedby from re_sealant_quotation_tbl where id = @iid))		" +
" declare @notedbytitle as varchar(max) = (select TITLE from accttb where id = (select notedby from re_sealant_quotation_tbl where id = @iid))					" +
" select @preparedby,@preparedbytitle,@notedby,@notedbytitle,reference,salutation,body,labor_rate,no_of_workers,mobilization_cost,labor_cost from re_sealant_quotation_tbl where id = @iid																						";
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
                                reference = dr[4].ToString();
                                salutation = dr[5].ToString();
                                body = dr[6].ToString();
                                labor_rate = dr[7].ToString();
                                no_of_worker = dr[8].ToString();
                                mobilization = dr[9].ToString();
                                labor_cost = dr[10].ToString();
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
                ReportParameter[] param = new ReportParameter[11];
                param[0] = new ReportParameter("preparedby", preparedby);
                param[1] = new ReportParameter("preparedbytitle", preparedbytitle);
                param[2] = new ReportParameter("notedby", notedby);
                param[3] = new ReportParameter("notedbytitle", notedbytitle);
                param[4] = new ReportParameter("reference", reference);
                param[5] = new ReportParameter("salutation", salutation);
                param[6] = new ReportParameter("body", body);
                param[7] = new ReportParameter("laborrate", labor_rate);
                param[8] = new ReportParameter("noofworkers", no_of_worker);
                param[9] = new ReportParameter("mobilization", mobilization);
                param[10] = new ReportParameter("laborcost", labor_cost);
                for (int i = 0; i < 11; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }

            }
        }
        private string iid
        {
            get
            {
                return Session["re_sealantid"].ToString();
            }
        }



        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "PREPAREDBY";
            Response.Redirect("~/AFTERSALESPROJ/resealantsignature.aspx");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "NOTEDBY";
            Response.Redirect("~/AFTERSALESPROJ/resealantsignature.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["re_sealant_report_sender"].ToString() == "re_sealant_page")
            {
                Response.Redirect("~/AFTERSALESPROJ/resealantpage.aspx");
            }
            else if (Session["re_sealant_report_sender"].ToString() == "forapproval")
            {
                Response.Redirect("~/AFTERSALESPROJ/resealantForapproval.aspx");
            }
        }
    }
}