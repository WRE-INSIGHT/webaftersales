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
        string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        submitbtn.Text = "add";
                        cancelbtn.Visible = false;
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
                    string str = "select a.ID," +
                           " a.CIN," +
                           " a.STATUS," +
                           " a.STATUSDATE AS[STATUS DATE]," +
                           " a.SERVICING," +
                           " a.SDATE AS[SERVICING DATE]," +
                           " a.REMARKS," +
                           " a.teamid," +
                           " b.TEAMNAME" +
                           " from servicingtb as a" +
                           " left join" +
                           " tblteam as b" +
                           " on a.teamid = b.tid" +
                           " where a.cin = @cin ORDER BY a.SERVICING desc";
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
                errorrmessage(ex.ToString());
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
                errorrmessage(ex.ToString());
            }
        }
        protected void submitbtn_Click(object sender, EventArgs e)
        {
            if (submitbtn.Text == "add")
            {
                addfunction();
            }
            else if (submitbtn.Text == "save")
            {
                updatefunction();
            }
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
        private void updatefunction()
        {
            try
            {
                string str = "update servicingtb set sdate=@sdate,remarks=@remarks where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@sdate", servicingdate.Text);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks.Text);
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
                getdata();
            }
        }
    }
}