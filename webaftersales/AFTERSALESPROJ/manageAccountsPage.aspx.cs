using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class manageAccountsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        getrequestdata();
                        getuserdata();
                        getpersonnel("", "", "");
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
        private void getrequestdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
       
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "[stpmanageaccount]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@datatype", "requestdata");
                    sqlcmd.Parameters.AddWithValue("@key", "");
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "ACCTTB");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
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
        private void getuserdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
       
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "[stpmanageaccount]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@datatype", "userdata");
                    sqlcmd.Parameters.AddWithValue("@key", tboxfinduser.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "ACCTTB");
                    GridView2.DataSource = ds;
                    GridView2.DataBind();
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["id"] = ((Label)row.FindControl("lblid")).Text;
                deleterequest();

            }
            else if (e.CommandName == "myverification")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["id"] = ((Label)row.FindControl("lblid")).Text;
                getpersonnel(((Label)row.FindControl("lbllastname")).Text, ((Label)row.FindControl("lblfirstname")).Text, "");
                Panel1.Visible = true;

            }
        }
        private void deleterequest()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("delete from ACCTTB where id = '" + ViewState["id"].ToString() + "'", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
            finally
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "alertme()", true);
                ViewState["id"] = null;
                GridView1.SelectedIndex = -1;
                getrequestdata();
            }
        }
        private void getpersonnel(string lastname, string firstname, string find)
        {

            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
       
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();

                    string a, b, c;



                    if (lastname == "")
                    {
                        a = " fullname = fullname ";
                    }
                    else
                    {
                        a = " fullname like '%" + lastname + "%'";
                    }

                    if (firstname == "")
                    {
                        b = " fullname = fullname ";
                    }
                    else
                    {
                        b = " fullname like '%" + firstname + "%'";
                    }

                    if (find == "")
                    {
                        c = " fullname = fullname ";
                    }
                    else
                    {
                        c = " fullname like '%" + find + "%'";
                    }
                    string btnvisibility;
                    if (ViewState["id"] != null)
                    {
                        btnvisibility = "1";
                    }
                    else
                    {
                        btnvisibility = "";
                    }

                    using (SqlCommand sqlcmd = new SqlCommand("select PID,FULLNAME,POSITION,'" + btnvisibility + "' AS A from tblpersonnel where (" + a + " or " + b + ") and " + c + " ", sqlcon))
                    {

                        SqlDataAdapter da = new SqlDataAdapter();

                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "tlpersonnel");
                        GridView3.DataSource = ds;
                        GridView3.DataBind();

                        ViewState["searchedlastname"] = lastname;
                        ViewState["searchedfirstname"] = firstname;
                        ViewState["searchedfind"] = find;

                        lblresultdirstname.Text = firstname;
                        lblresultlastname.Text = lastname;
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getrequestdata();
        }
        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            getuserdata();
        }
        protected void GridView3_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView3.PageIndex = e.NewPageIndex;
            getpersonnel(ViewState["searchedlastname"].ToString(),
            ViewState["searchedfirstname"].ToString(),
            ViewState["searchedfind"].ToString());
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            getpersonnel("", "", tboxfind.Text);
            Panel1.Visible = false;
        }
        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            getuserdata();
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "validate")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView3.Rows[rowindex];
                validaterequest(((Label)row.FindControl("pidlbl")).Text);
            }
        }
        private void validaterequest(string pid)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("UPDATE ACCTTB SET PID = '" + pid + "' where id = '" + ViewState["id"].ToString() + "'", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
            finally
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "alertme()", true);
                ViewState["id"] = null;
                GridView1.SelectedIndex = -1;
                getrequestdata();
                getpersonnel(ViewState["searchedlastname"].ToString(),
            ViewState["searchedfirstname"].ToString(),
            ViewState["searchedfind"].ToString());
            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                deleteaccount(((Label)row.FindControl("lblid")).Text);
            }
        }
        private void deleteaccount(string id)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("delete from ACCTTB where id = '" + id + "'", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
            finally
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "alertme()", true);
                getuserdata();
            }
        }

    }
}