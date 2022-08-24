using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class ServicingCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    var x = DateTime.Now.ToString("yyyy");
                    var y = DateTime.Now.ToString("MM");
                    tboxyear.Text = x;
                    ddlmonth.Text = y;
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private void loaddata()
        {
            DateTime D = Convert.ToDateTime("01-" + ddlmonth.SelectedValue.ToString() + "-" + tboxyear.Text);
            lblMonth.Text = D.ToString("MMMM");
            loadCalendarData(ddlmonth.SelectedValue.ToString() + "-01-" + tboxyear.Text);
        }

        private void loadCalendarData(string d)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Servicing_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "calendar");
                        sqlcmd.Parameters.AddWithValue("@Date", d);
                        sqlcmd.Parameters.AddWithValue("@Status", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@Area", ddlarea.Text);

                        GridView1.DataSource = sqlcmd.ExecuteReader();
                        GridView1.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                    finally
                    {

                    }
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }


        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loaddata();
        }
    }
}