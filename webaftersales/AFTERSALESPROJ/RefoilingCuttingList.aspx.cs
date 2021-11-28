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
    public partial class RefoilingCuttingList : System.Web.UI.Page
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
     
        private void loadparameter()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string prepared = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/REFOILING/" + Session["refoilingqno"].ToString() + "/signature/CL_PREPAREDBY.jpg")).AbsoluteUri;
            ReportParameter[] param = new ReportParameter[4];
            param[0] = new ReportParameter("prepared", prepared);
            param[1] = new ReportParameter("project", Session["PROJECT"].ToString());
            param[2] = new ReportParameter("address", Session["ADDRESS"].ToString());
    
            for (int i = 0; i < 3; i++)
            {
                ReportViewer1.LocalReport.SetParameters(param[i]);
            }
            loadnames();
            ReportViewer1.LocalReport.Refresh();
        }
        private void loadnames()
        {
            string preparedby = "",
                preparedbytitle = "";


            try
            {
                string str = " declare @preparedby as varchar(max) = (select FIRSTNAME+' '+LASTNAME from accttb where id = (select cl_preparedby from refoiling_id_tbl where QNO = @iid))	" +
" declare @preparedbytitle as varchar(max) = (select TITLE from accttb where id = (select cl_preparedby from refoiling_id_tbl where QNO = @iid))				" +
" select @preparedby,@preparedbytitle																					";
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
                ReportParameter[] param = new ReportParameter[2];
                param[0] = new ReportParameter("preparedby", preparedby);
                param[1] = new ReportParameter("preparedbytitle", preparedbytitle);
                for (int i = 0; i < 2; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }
            }
        }
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["columnname"] = "CL_PREPAREDBY";
            Response.Redirect("~/AFTERSALESPROJ/cuttinglistsignature.aspx");
        }
    }
}