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
    public partial class importquotationitem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        lblaseno.Text = aseno;
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
        private string aseno
        {
            get
            {
                return Session["aseno"].ToString();
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
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
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tbl"];
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getdata()
        {
            try
            {
              
                DataTable ds = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = "select * from reporttb where sid = @sid";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@sid", sid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                        ViewState["tbl"] = ds;
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "confimmessage();", true);

            List<int> l = new List<int>();
            if ((List<int>)ViewState["listid"] == null)
            {
                l.Add(0);
            }
            else
            {
                l = ViewState["listid"] as List<int>;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            try
            {

                for (int i = 0; i <= mytb.Rows.Count - 1; i++)
                {
                    int id = Convert.ToInt32(mytb.Rows[i]["id"].ToString());
                    if (l.Contains(id))
                    {
                        string kno, itemno, location, kid;

                        kno = mytb.Rows[i]["kno"].ToString();
                        itemno = mytb.Rows[i]["itemno"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        kid = mytb.Rows[i]["id"].ToString();
                        insertrecord(kno, itemno, location, kid);
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/quotationitem.aspx");
            }

            ViewState["listid"] = l;

        }

        private void insertrecord(string kno, string itemno, string location, string kid)
        {
            try
            {
              
                string str = "  declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from [ITEMTB])" +
                             "  insert into[ITEMTB] (id, aseno, item, kno, wdwloc, kid)values(@id, @aseno, @itemno, @kno, @loc, @kid)";

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@aseno", aseno);
                        sqlcmd.Parameters.AddWithValue("@kno", kno);
                        sqlcmd.Parameters.AddWithValue("@itemno", itemno);
                        sqlcmd.Parameters.AddWithValue("@loc", location);
                        sqlcmd.Parameters.AddWithValue("@kid", kid);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }
    }
}