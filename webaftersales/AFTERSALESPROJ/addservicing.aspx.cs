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
                        instructiontbox.Text = Session["callinConcern"].ToString();
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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string jo
        {
            get
            {
                return Session["callinParentJo"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    GridView1.SelectedIndex = -1;
                    string str = "  select a.ID, " +
                        "  a.CIN, " +
                        "  a.STATUS, " +
                        "  CASE WHEN ISDATE(a.STATUSDATE)=1 THEN FORMAT(CAST(a.STATUSDATE AS DATE),'MMM-dd-yyyy') ELSE a.STATUSDATE END AS [STATUSDATE], " +
                        "  a.SERVICING, " +
                        "  CASE WHEN ISDATE(a.SDATE)=1 THEN FORMAT(CAST(a.SDATE AS DATE),'MMM-dd-yyyy') ELSE a.SDATE END AS[SERVICINGDATE], " +
                        "  a.REMARKS,a.SPECIFIEDJOB,a.INSTRUCTION, " +
                        "  a.teamid, " +
                        "  b.TEAMNAME," +
                        " a.plateno," +
                        " a.SORTING," +
                        " a.ASSESSMENT_SORTING," +
                        " a.MATERIALS," +
                        "  STUFF((SELECT ', ' + y.FULLNAME+ char(10) from TBLteamMember as x " +
                        " 	left join tblpersonnel as y" +
                        " 	on x.pid = y.pid" +
                        " 	where x.tid= a.teamid" +
                        " 	FOR XML PATH('')),1,2,'') AS MEMBERS" +
                        "  from servicingtb as a " +
                        "  left join " +
                        "  tblteam as b " +
                        "  on a.teamid = b.tid " +
                        "  where a.cin = @cin ORDER BY a.id desc";
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
                string str = " SELECT * INTO #TBL FROM( " +
                            " SELECT [STATUS],id, x=SUBSTRING(servicing, PATINDEX('%[0-9]%', servicing), PATINDEX('%[0-9][^0-9]%', servicing + 't') - PATINDEX('%[0-9]%'," +
                            " servicing) +1)" +
                            " FROM SERVICINGTB where cin = @cin) AS TBL" +
                            " update callintb set [status] = (SELECT top 1 case when [status] is null then '' else [status] end FROM #TBL order by convert(int,x) desc) where cin = @cin";
               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
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
                                     " insert into servicingtb(id, cin, servicing, sdate,specifiedjob,instruction, remarks,materials,plateno, status,sorting,assessment_sorting)values(@id, @cin, @servicing, @sdate,@specifiedjob,@instruction, @remarks,@materials,@plateno, 'Scheduled',@sorting,@assessment_sorting)";
                string str2 = "select isnull(count(id),0)+1 from servicingtb where cin = @cin";
               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                        sqlcmd.Parameters.AddWithValue("@specifiedjob", specifiedjobtbox.Text);
                        sqlcmd.Parameters.AddWithValue("@instruction", instructiontbox.Text);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks.Text);
                        sqlcmd.Parameters.AddWithValue("@materials", materials.Text);
                        sqlcmd.Parameters.AddWithValue("@plateno", plateno.Text);
                        sqlcmd.Parameters.AddWithValue("@sorting", tboxsorting.Text);
                        sqlcmd.Parameters.AddWithValue("@assessment_sorting", tboxAssessment.Text);
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
                    dt = Convert.ToDateTime(dt).ToString("yyyy-MM-dd");
                }
                ((TextBox)row.FindControl("servicingdatetbox")).Text = dt;
                ((TextBox)row.FindControl("remarkstbox")).Text = ((Label)row.FindControl("remarkslbl")).Text;
                ((TextBox)row.FindControl("materialstbox")).Text = ((Label)row.FindControl("materialslbl")).Text;
                ((TextBox)row.FindControl("platenotbox")).Text = ((Label)row.FindControl("platenolbl")).Text;
                ((TextBox)row.FindControl("specifiedjobtbox")).Text = ((Label)row.FindControl("specifiedjoblbl")).Text;
                ((TextBox)row.FindControl("instructiontbox")).Text = ((Label)row.FindControl("instructionlbl")).Text;
                ((TextBox)row.FindControl("assessment_sortingtbox")).Text = ((Label)row.FindControl("assessment_sortinglbl")).Text;
                ((DropDownList)row.FindControl("DropDownList1")).Text = ((Label)row.FindControl("statuslbl")).Text;
                DateTime Svalue;
                string Sdt = ((Label)row.FindControl("statusdatelbl")).Text;
                if (DateTime.TryParse(Sdt, out Svalue))
                {
                    Sdt = Convert.ToDateTime(Sdt).ToString("yyyy-MM-dd");
                }

                ((TextBox)row.FindControl("statusdatetbox")).Text = Sdt;

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
                ViewState["materials"] = ((TextBox)row.FindControl("materialstbox")).Text;
                ViewState["plateno"] = ((TextBox)row.FindControl("platenotbox")).Text;
                ViewState["sorting"] = ((TextBox)row.FindControl("sortingtbox")).Text;
                ViewState["assessment_sorting"] = ((TextBox)row.FindControl("assessment_sortingtbox")).Text;
                ViewState["specifiedjob"] = ((TextBox)row.FindControl("specifiedjobtbox")).Text;
                ViewState["instruction"] = ((TextBox)row.FindControl("instructiontbox")).Text;
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
                Session["Build_Team_Action"] = ((Button)row.FindControl("getteambtn")).Text.ToString() == "Get team" ? "Add" : "Update";
                Session["Buil_Team_Id"] = ((Label)row.FindControl("lblTeamId")).Text;
                //Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                //Session["teamsender"] = "servicing";
                //Response.Redirect("~/AFTERSALESPROJ/teampage.aspx");
                Response.Redirect("~/AFTERSALESPROJ/BuildServicingTeam.aspx");
            }
            else if (e.CommandName == "viewreport")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                getdetails(cin);
                Session["link"] = "s3";
                Response.Redirect("~/AFTERSALESPROJ/reportviewPage.aspx");
            }
            else if (e.CommandName == "quotation")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                getdetails(cin);
                Session["quotationsender"] = "joborder";
                Response.Redirect("~/AFTERSALESPROJ/quotation.aspx");
            }
            else if (e.CommandName == "cleaning")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                Session["JO"] = jo;
                getdetails(cin);
                Response.Redirect("~/AFTERSALESPROJ/cleaningpage.aspx");
            }
            else if (e.CommandName == "refoiling")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                Session["JO"] = jo;
                getdetails(cin);
                Response.Redirect("~/AFTERSALESPROJ/refoilingpage.aspx");
            }
            else if (e.CommandName == "resealant")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridView1.SelectedIndex = rowindex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CIN"] = cin;
                Session["SID"] = ((Label)row.FindControl("sidlbl")).Text;
                Session["JO"] = jo;
                getdetails(cin);
                Response.Redirect("~/AFTERSALESPROJ/resealantpage.aspx");
            }
        }
        private void getdetails(string callin)
        {
           
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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

                }
            }
        }
        private void delete()
        {

            try
            {
                string str = "delete from servicingtb where id  = @id";

               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                string str = "update servicingtb set status = @status , statusdate = @statusdate ,sdate=@sdate,specifiedjob=@specifiedjob,instruction=@instruction,remarks=@remarks,materials=@materials,plateno=@plateno,sorting=@sorting,assessment_sorting=@assessment_sorting  where id = @id";
               
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", sid);
                        sqlcmd.Parameters.AddWithValue("@status", ViewState["status"].ToString());
                        sqlcmd.Parameters.AddWithValue("@statusdate", ViewState["statusdate"].ToString());
                        sqlcmd.Parameters.AddWithValue("@sdate", ViewState["servicingdate"].ToString());
                        sqlcmd.Parameters.AddWithValue("@remarks", ViewState["remarks"].ToString());
                        sqlcmd.Parameters.AddWithValue("@materials", ViewState["materials"].ToString());
                        sqlcmd.Parameters.AddWithValue("@plateno", ViewState["plateno"].ToString());
                        sqlcmd.Parameters.AddWithValue("@sorting", ViewState["sorting"].ToString());
                        sqlcmd.Parameters.AddWithValue("@assessment_sorting", ViewState["assessment_sorting"].ToString());
                        sqlcmd.Parameters.AddWithValue("@specifiedjob", ViewState["specifiedjob"].ToString());
                        sqlcmd.Parameters.AddWithValue("@instruction", ViewState["instruction"].ToString());
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



        protected void Button4_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["servicingsource"].ToString() == "report")
            {
                Response.Redirect("~/AFTERSALESPROJ/reportpage.aspx");
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/callinpage.aspx");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}