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
    public partial class addservicing : System.Web.UI.Page
    {
        int scount;
        string suffix = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {             
                        lblproject.Text = Session["callinProject"].ToString();
                        lbladdress.Text = Session["callinAddress"].ToString();
                        getdata();
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
        private string cin
        {
            get
            {
                return Session["callinnumber"].ToString();
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    GridView1.SelectedIndex = -1;
                    string str = "  select a.ID, " +
                        "  a.CIN, " +
                        "  a.STATUS, " +
                        "  a.STATUSDATE AS[STATUSDATE], " +
                        "  a.SERVICING, " +
                        "  CASE WHEN ISDATE(a.SDATE)=1 THEN FORMAT(CAST(a.SDATE AS DATE),'MMM-dd-yyyy') ELSE a.SDATE END AS[SERVICINGDATE], " +
                        "  a.REMARKS, " +
                        "  a.teamid, " +
                        "  b.TEAMNAME," +
                        "  STUFF((SELECT ', ' + y.FULLNAME+ char(10) from TBLteamMember as x " +
                        " 	left join tblpersonnel as y" +
                        " 	on x.pid = y.pid" +
                        " 	where x.tid= a.teamid" +
                        " 	FOR XML PATH('')),1,2,'') AS MEMBERS" +
                        "  from servicingtb as a " +
                        "  left join " +
                        "  tblteam as b " +
                        "  on a.teamid = b.tid " +
                        "  where a.cin = @cin ORDER BY a.SERVICING desc";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "tb");
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                updatestatus();
            }
        }
        private void updatestatus()
        {
            try
            {
                string c = "";
                string str = "SELECT id , x=SUBSTRING(servicing, PATINDEX('%[0-9]%', servicing), PATINDEX('%[0-9][^0-9]%', servicing + 't') - PATINDEX('%[0-9]%'," +
                     " servicing) +1)" +
                     " FROM SERVICINGTB where cin = @cin order by x asc ";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                c = rd[0].ToString();
                            }
                        }
                    }
                    string str2 = " declare @status as varchar(100) = (select case when status is null then '' else status end from servicingtb where id = @id)" +
                                   " update callintb set status = @status where cin = @cin" +
                                   " update callintb set status = '' where status is null";
                    using (SqlCommand sqlcmd = new SqlCommand(str2, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("id", c);
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        protected void submitbtn_Click(object sender, EventArgs e)
        {
           
                addfunction();
          
        }
        private void addfunction()
        {
            try
            {
                string str = " declare @id as integer = (select isnull(max(id),0)+1 from servicingtb)" +
                                     " declare @sss as integer = (select isnull(max(id), 0) from servicingtb where cin = @cin)" +
                                     " update servicingtb set[status] = 'Reschedule',statusdate = @sdate where id = @sss" +
                                     " insert into servicingtb(id, cin, servicing, sdate, remarks, status)values(@id, @cin, @servicing, @sdate, @remarks, 'Scheduled')";
                string str2 = "select isnull(count(id),0)+1 from servicingtb where cin = @cin";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str2, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                scount = Convert.ToInt32(rd[0].ToString());
                            }
                        }
                    }
                    string x;
                    switch (scount)
                    {
                        case 1:
                            x = "st";
                            break;
                        case 2:
                            x = "nd";
                            break;
                        case 3:
                            x = "rd";
                            break;
                        default:
                            x = "th";
                            break;
                    }
                    suffix = "" + scount + "" + x + " Servicing Schedule";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@cin", cin);
                        sqlcmd.Parameters.AddWithValue("@servicing", suffix);
                        sqlcmd.Parameters.AddWithValue("@sdate", servicingdate.Text);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.ToString());
            }
            finally
            {
                getdata();
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
      

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];

                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                DateTime value;
                string dt = ((Label)row.FindControl("servicingdatelbl")).Text;
                if (DateTime.TryParse(dt, out value))
                {
                   dt = Convert.ToDateTime(dt).ToString("MM-dd-yyyy");
                }
                ((TextBox)row.FindControl("servicingdatetbox")).Text = dt;
                ((TextBox)row.FindControl("remarkstbox")).Text = ((Label)row.FindControl("remarkslbl")).Text;
                ((DropDownList)row.FindControl("DropDownList1")).Text = ((Label)row.FindControl("statuslbl")).Text;
                ((TextBox)row.FindControl("statusdatetbox")).Text = ((Label)row.FindControl("statusdatelbl")).Text;

                Panel pnl = ((Panel)row.FindControl("Panel2"));
                pnl.Visible = true;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                ViewState["servicingdate"] = ((TextBox)row.FindControl("servicingdatetbox")).Text;
                ViewState["remarks"] = ((TextBox)row.FindControl("remarkstbox")).Text;
                ViewState["status"] = ((DropDownList)row.FindControl("DropDownList1")).Text;
                ViewState["statusdate"] = ((TextBox)row.FindControl("statusdatetbox")).Text;
                updatecurrentstatus();
                Panel pnl = ((Panel)row.FindControl("Panel2"));
                pnl.Visible = false;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Panel pnl = ((Panel)row.FindControl("Panel2"));
                pnl.Visible = false;
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
            
                delete();
            }
            else if (e.CommandName == "myteam")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];

                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                Session["teamsender"] = "servicing";
                Response.Redirect("~/AFTERSALESPROJ/teampage.aspx");
            }
            else if (e.CommandName == "viewreport")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CID"]= cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                getdetails(cin);
            }

        }
        private void getdetails(string callin)
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                string str = "select A.STATUS,CIN,CDATE,JO,PROJECT_LABEL,FULLADD,PROFILE_FINISH from callintb as a " +
                         "left join kmdidata.dbo.ADDENDUM_TO_CONTRACT_TB as b " +
                         "on a.jo = b.job_order_no " +
                         "where a.cin = '" + callin + "'";
                using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                {
                    sqlcon.Open();
                    SqlDataReader rdr = sqlcmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        Session["PROJECT"] = rdr[4].ToString();
                        Session["ADDRESS"] = rdr[5].ToString();
                        Session["COLOR"] = rdr[6].ToString();
                    }
                    Session["link"] = "s3";
                    Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
                }
            }
        }
        private void delete()
        {
          
            try
            {
                string str = "delete from servicingtb where id  = @id";

                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", sid);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();

            }
        }
        private void updatecurrentstatus()
        {
            try
            {
                string str = "update servicingtb set status = @status , statusdate = @statusdate ,sdate=@sdate,remarks=@remarks  where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", sid);
                        sqlcmd.Parameters.AddWithValue("@status", ViewState["status"].ToString());
                        sqlcmd.Parameters.AddWithValue("@statusdate", ViewState["statusdate"].ToString());
                        sqlcmd.Parameters.AddWithValue("@sdate", ViewState["servicingdate"].ToString());
                        sqlcmd.Parameters.AddWithValue("@remarks", ViewState["remarks"].ToString());
                        sqlcmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();
            }
        }
   
        private void cleanme()
        {
            GridView1.SelectedIndex = -1;
            servicingdate.Text = "";
            remarks.Text = "";
        }

        protected void servicingdate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            getdata();
        }
    }
}