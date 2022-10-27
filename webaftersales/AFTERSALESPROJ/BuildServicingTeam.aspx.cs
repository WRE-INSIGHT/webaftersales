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
    public partial class BuildServicingTeam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        if (Session["Build_Team_Action"].ToString() == "Update")
                        {
                            getExistingTeam();
                        }
                        else if (Session["Build_Team_Action"].ToString() == "Add")
                        {
                            createNewTeam();
                        }
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

        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<int> idlist = new List<int>();
            if (ViewState["listid"] != null)
            {
                idlist = (List<int>)ViewState["listid"];
            }

            foreach (GridViewRow row in this.GridView1.Rows)
            {
                CheckBox cbx = (CheckBox)row.FindControl("cboxselect");

                var selectedkey = int.Parse(GridView1.DataKeys[row.RowIndex].Value.ToString());

                if (cbx.Checked)
                {
                    if (!idlist.Contains(selectedkey))
                    {
                        idlist.Add(selectedkey);
                    }
                }
                else
                {
                    if (idlist.Contains(selectedkey))
                    {
                        idlist.Remove(selectedkey);
                    }
                }
            }

            ViewState["listid"] = idlist;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        private void getdata()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "Servicing_Team_Stp";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Command", "Get_Personnel");
                    sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(tb);
                    GridView1.DataSource = tb;
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());

            }
        }
        private void createNewTeam()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "Servicing_Team_Stp";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Command", "Create_New_Team");
                    sqlcmd.Parameters.AddWithValue("@Sid", Session["SID"].ToString());
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        Session["Buil_Team_Id"] = rd[0];
                    }
                    Session["Build_Team_Action"] = "Update";
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());

            }
        }
        private void getExistingTeam()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    List<int> li = new List<int>();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "Servicing_Team_Stp";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Command", "Get_Existing_Team");
                    sqlcmd.Parameters.AddWithValue("@TeamId", Session["Buil_Team_Id"].ToString());
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    while (rd.Read())
                    {
                        li.Add(Convert.ToInt32(rd[0].ToString()));
                    }
                    ViewState["listid"] = li;
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
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

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "confimmessage();", true);

            List<int> l = new List<int>();
            if ((List<int>)ViewState["listid"] != null)
            {
                l = ViewState["listid"] as List<int>;
            }

            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("lblId")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("lblId")).Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            try
            {

                var teamid = Session["Buil_Team_Id"].ToString();
                manageTeamMember("Delete_Team_Member", teamid, "");
                for (int i = 0; i <= l.Count - 1; i++)
                {
                    int id = l[i];
                    manageTeamMember("Create_Team_Member", teamid, id.ToString());
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/addservicing.aspx");
            }
            ViewState["listid"] = l;
        }

        private void manageTeamMember(string command, string teamid, string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "Servicing_Team_Stp";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@Command", command);
                    sqlcmd.Parameters.AddWithValue("@TeamId", teamid);
                    sqlcmd.Parameters.AddWithValue("@Pid", id);
                    sqlcmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<int> idlist = ViewState["listid"] as List<int>;
            if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            {
                var autoid = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
                if (idlist.Contains(autoid))
                {
                    CheckBox cbx = (CheckBox)e.Row.FindControl("cboxselect");
                    cbx.Checked = true;
                }
            }
        }
    }
}