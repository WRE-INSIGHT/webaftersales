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
    public partial class teampage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        getpersonnel();
                        getteams();
                        if (Session["teamsender"] == null)
                        {
                            Button1.Visible = false;
                        }
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
        private void getpersonnel()
        {
            try
            {
                GridView1.SelectedIndex = -1;
                DataSet ds = new DataSet();
                string str = "select * from tblpersonnel where fullname like @key";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        SqlDataAdapter da = new SqlDataAdapter();
                        sqlcmd.Parameters.AddWithValue("@key", "%" + keytbox.Text + "%");
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void getteams()
        {
            try
            {
                GridView2.SelectedIndex = -1;
                DataSet ds = new DataSet();
                string str = "select * from(select " +
                                " TID," +
                                " TEAMNAME," +
                                " STUFF((SELECT ', ' + FULLNAME + CHAR(10) FROM TBLteamMember as a" +
                                " left join tblpersonnel as b" +
                                " on a.PID = b.PID WHERE A.TID = D.TID" +
                                " FOR XML PATH('')),1,2,'') AS MEMBERS" +
                                " from TBLteam AS d) as tb where teamname like @key or members like @key";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        SqlDataAdapter da = new SqlDataAdapter();
                        sqlcmd.Parameters.AddWithValue("@key", "%" + teamkey.Text + "%");
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView2.DataSource = ds;
                        GridView2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorrgroup";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = rowindex;
                ((TextBox)row.FindControl("fullnametbox")).Text = ((Label)row.FindControl("fullnamelbl")).Text;
                ((TextBox)row.FindControl("positiondl")).Text = ((Label)row.FindControl("positionlbl")).Text;
                ((Panel)row.FindControl("Panel1")).Visible = true;
            }

            else if (e.CommandName == "cancelbtn")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((Panel)row.FindControl("Panel1")).Visible = false;
                GridView1.SelectedIndex = -1;
            }
            else if (e.CommandName == "savebtn")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                string pid = ((Label)row.FindControl("pidlbl")).Text;
                string fullname = ((TextBox)row.FindControl("fullnametbox")).Text;
                string position = ((TextBox)row.FindControl("positiondl")).Text;
                updatefunction(pid, fullname, position);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                string pid = ((Label)row.FindControl("pidlbl")).Text;
                deletefunction(pid);
            }
        }
        private void updatefunction(string pid, string fullname, string position)
        {
            try
            {

                string str = "update tblpersonnel set fullname = @fullname, position=@position where pid = @pid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@pid", pid);
                        sqlcmd.Parameters.AddWithValue("@fullname", fullname);
                        sqlcmd.Parameters.AddWithValue("@position", position);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
            finally
            {
                getpersonnel();
            }
        }
        private void deletefunction(string pid)
        {
            try
            {

                string str = "delete from tblpersonnel where pid = @pid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@pid", pid);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
            finally
            {
                getpersonnel();
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getpersonnel();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getpersonnel();
        }
        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            getteams();
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                GridView2.SelectedIndex = rowindex;
                ViewState["tid"] = ((Label)row.FindControl("tidlbl")).Text;
                string tid = ((Label)row.FindControl("tidlbl")).Text;
                ((TextBox)row.FindControl("teamnametbox")).Text = ((Label)row.FindControl("teamnamelbl")).Text;
                ((Panel)row.FindControl("Panel2")).Visible = true;
                getmembers(tid, ((GridView)row.FindControl("Gridview3")));
                loaddl(((DropDownList)row.FindControl("memberdl")));
            }
            if (e.CommandName == "myadd")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                string tid = ((Label)row.FindControl("tidlbl")).Text;
                addmember(tid, ((DropDownList)row.FindControl("memberdl")).SelectedValue.ToString());
                getmembers(tid, ((GridView)row.FindControl("Gridview3")));
            }
            if (e.CommandName == "changename")
            {
                int rowindex = ((GridViewRow)((Button)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                string tid = ((Label)row.FindControl("tidlbl")).Text;
                changename(tid, ((TextBox)row.FindControl("teamnametbox")).Text.ToString());
                getteams();
            }
            if (e.CommandName == "assign")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                string tid = ((Label)row.FindControl("tidlbl")).Text;
                assignteam(tid, Session["SID"].ToString());
            }

            if (e.CommandName == "myclose")
            {
                getteams();
            }
        }
        private void assignteam(string tid,string sid)
        {
            try
            {

                string str = "update servicingtb set teamid = @tid where id = @sid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@tid", tid);
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
            }
        }
        private void changename(string tid, string teamname)
        {
            try
            {

                string str = "update tblteam set teamname = @teamname where tid = @tid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@tid", tid);
                        sqlcmd.Parameters.AddWithValue("@teamname", teamname);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void addmember(string tid, string pid)
        {
            try
            {

                string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from TBLteamMember)" +
                             " insert into TBLteamMember(id, tid, pid)values(@id,@tid,@pid)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@tid", tid);
                        sqlcmd.Parameters.AddWithValue("@pid", pid);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void getmembers(string tid, object sender)
        {
            try
            {
                DataSet ds = new DataSet();
                string str = "select a.id,b.fullname from tblteammember as a left join tblpersonnel as b on a.pid = b.pid where tid = @tid";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        SqlDataAdapter da = new SqlDataAdapter();
                        sqlcmd.Parameters.AddWithValue("@tid", tid);
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        ((GridView)sender).DataSource = ds;
                        ((GridView)sender).DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void loaddl(object sender)
        {
            try
            {
                DataSet ds = new DataSet();
                string str = "select * from tblpersonnel order by fullname asc";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        ((DropDownList)sender).DataSource = ds;
                        ((DropDownList)sender).DataTextField = "FULLNAME";
                        ((DropDownList)sender).DataValueField = "PID";
                        ((DropDownList)sender).DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myremove")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                string id = ((Label)row.FindControl("memberidlbl")).Text;
                removemember(id);
                getmembers(ViewState["tid"].ToString(), sender);
            }
        }
        private void removemember(string id)
        {
            try
            {

                string str = "delete from TBLteamMember where id = @id";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            getteams();
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "declare @id as integer = (select isnull(max(isnull(tid,0)),0)+1 from TBLteam) insert into TBLteam(tid, teamname)values(@id,@teamname)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@teamname", newteamnametbox.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
            finally
            {
                teamkey.Text = newteamnametbox.Text;
                getteams();
            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            try
            {
                string str = "declare @id as integer = (select isnull(max(isnull(pid,0)),0)+1 from TBLpersonnel) insert into TBLpersonnel(pid, fullname, position)values(@id,@fullname,@position)";
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@fullname", newfullnametbox.Text);
                        sqlcmd.Parameters.AddWithValue("@position", newpositiontbox.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
            finally
            {
                keytbox.Text = newfullnametbox.Text;
                getpersonnel();
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (Session["teamsender"] == null)
            {
                for (int i = 0; i <= GridView2.Rows.Count - 1; i++)
                {
                    ((LinkButton)GridView2.Rows[i].FindControl("assignbtn")).Visible = false;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
        }
    }
}