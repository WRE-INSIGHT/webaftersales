using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class quotationreportclient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (aseno == "")
                {
                    Response.Redirect("~/AFTERSALESPROJ/Sessionexpired.aspx");
                }
                else
                {
                    getdata();
                }
                SqlDataSource1.ConnectionString = sqlconstr;
                SqlDataSource2.ConnectionString = sqlconstr;
                SqlDataSource3.ConnectionString = sqlconstr;
                ReportViewer1.LocalReport.Refresh();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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
        private void getdata()
        {
            try
            {
                Session["PROJECT"] = "";
                Session["ADDRESS"] = "";

                string str = "select CIN,SID from quotationtb where aseno = @aseno";
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@aseno", Convert.ToString(aseno));
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                Session["SID"] = rd["SID"].ToString();
                                Session["CIN"] = rd["CIN"].ToString();
                            }
                        }
                    }

                    string basicinfo = " select b.project_label,b.fulladd from callintb as a 	  " +
                                    " left join kmdidata.dbo.addendum_to_contract_tb as b		  " +
                                    " on a.jo = b.job_order_no where a.cin = @cin				  ";
                    using (SqlCommand sqlcmd1 = new SqlCommand(basicinfo, sqlcon))
                    {

                        sqlcmd1.Parameters.AddWithValue("@cin", Session["CIN"].ToString());
                        using (SqlDataReader rd1 = sqlcmd1.ExecuteReader())
                        {
                            while (rd1.Read())
                            {
                                Session["PROJECT"] = rd1["project_label"].ToString();
                                Session["ADDRESS"] = rd1["fulladd"].ToString();
                            }
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {

                getparameters();

            }
        }
        private string aseno
        {
          
            get
            {
                    Session["aseno"] = Request.QueryString["aseno"].ToString();
                    return Session["aseno"].ToString(); 
            }
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string prepared = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + aseno.ToString() + "/signature/PREPAREDBY.jpg")).AbsoluteUri;
            string approved = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + aseno.ToString() + "/signature/APPROVEDBY.jpg")).AbsoluteUri;
            string accepted = new Uri(Server.MapPath("~/Uploads/ASuploads/" + Session["CIN"].ToString() + "/" + Session["SID"].ToString() + "/" + aseno.ToString() + "/signature/ACCEPTEDBY.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[5];
            repparam[0] = new ReportParameter("project", Session["PROJECT"].ToString());
            repparam[1] = new ReportParameter("address", Session["ADDRESS"].ToString());
            repparam[2] = new ReportParameter("prepared", prepared);
            repparam[3] = new ReportParameter("approved", approved);
            repparam[4] = new ReportParameter("accepted", accepted);
            for (int i = 0; i < 5; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }


        }
    }
}