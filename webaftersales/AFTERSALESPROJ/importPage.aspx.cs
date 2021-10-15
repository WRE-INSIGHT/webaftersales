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
    public partial class importPage : System.Web.UI.Page
    {
        DataTable tb;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
           
                if (!IsPostBack)
                {
                    getdata("reload");
                    getlocations();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string jo
        {
            get
            {
                return Session["JO"].ToString();
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getlocations()
        {
            try
            {
                 using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "[stdImportItem]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@sid", sid);
                    sqlcmd.Parameters.AddWithValue("@jo", jo);
                    sqlcmd.Parameters.AddWithValue("@datarequest", "getlocation");
                    sqlcmd.Parameters.AddWithValue("@location", locationdl.Text);
                    locationdl.DataSource = sqlcmd.ExecuteReader();
                    locationdl.DataTextField = "LOCATION";
                    locationdl.DataBind();
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
        private void getdata(string datareq)
        {
            try
            {
                tb = new DataTable();
        
                 using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.CommandText = "[stdImportItem]";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@sid", sid);
                    sqlcmd.Parameters.AddWithValue("@jo", jo);
                    sqlcmd.Parameters.AddWithValue("@datarequest", datareq);
                    sqlcmd.Parameters.AddWithValue("@location", tboxsearch.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(tb);
                    GridView1.DataSource = tb;
                    GridView1.DataBind();
                    ViewState["tb"] = tb;
                    ViewState["datareq"] = datareq;
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
            getdata(ViewState["datareq"].ToString());
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

        protected void btnimport_Click(object sender, EventArgs e)
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
                    int x = int.Parse(((Label)row.FindControl("Label6")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("Label6")).Text.ToString());
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
                        string joborder, kno, itemno, location, width, height;
                        joborder = mytb.Rows[i]["job_order_no"].ToString();
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        itemno = mytb.Rows[i]["item_no"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        width = mytb.Rows[i]["width"].ToString();
                        height = mytb.Rows[i]["height"].ToString();
                        insertrecord(sid, joborder, kno, itemno, location, width, height);
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/reportpage.aspx");
                //CustomValidator err = new CustomValidator();
                //err.ValidationGroup = "val1";
                //err.IsValid = false;
                //err.ErrorMessage = "Data imported successfully!";
                //ValidationSummary1.CssClass = "alert alert-success";
                //Page.Validators.Add(err);

                //foreach (GridViewRow row in GridView1.Rows)
                //{
                //    CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                //    if (cbk.Checked == true)
                //    {
                //        int x = int.Parse(((Label)row.FindControl("Label6")).Text.ToString());
                //        if (l.Contains(x))
                //        {
                //            l.Remove(x);
                //            cbk.Checked = false;
                //        }
                //    }
                //}
            }

            ViewState["listid"] = l;

        }
        private void insertrecord(string sid, string joborder, string kno, string itemno, string location,string width, string height)
        {
            try
            {
        
                 using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    string qry = " declare @id as integer = (select max(id)+1 from reporttb) " +
                        "insert into reporttb (id,sid,jo,kno,itemno,location,specification,width,height)values" +
                        "(@id,'" + sid + "','" + joborder + "','" + kno + "','" + itemno + "','" + location + "','Window','" + width + "','" + height + "')";

                    SqlCommand sqlcmd = new SqlCommand(qry, sqlcon);
                    sqlcmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
             
              errorrmessage(ex.Message.ToString());
            }

        }

        protected void searchbtn_Click(object sender, EventArgs e)
        {
            getdata("filter");
        }

        protected void locationdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            tboxsearch.Text = locationdl.Text;
        }
    }
}