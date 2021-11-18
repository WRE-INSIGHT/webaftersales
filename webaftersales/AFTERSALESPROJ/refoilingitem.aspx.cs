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
    public partial class refoilingitem : System.Web.UI.Page
    {
        DataTable tb;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {

                        getlocations();
                        loaditem();
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
        private string refoilingqno
        {
            get
            {
                return Session["refoilingqno"].ToString();
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
                return Session["JO"].ToString();
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
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
        protected void searchbtn_Click(object sender, EventArgs e)
        {
            getdata("filter");
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
                    GridView2.DataSource = tb;
                    GridView2.DataBind();
                    ViewState["tb"] = tb;
                    ViewState["datareq"] = datareq;
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());

            }


        }
        protected void locationdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            tboxsearch.Text = locationdl.Text;
        }
        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<int> idlist = new List<int>();
            if (ViewState["listid"] != null)
            {
                idlist = (List<int>)ViewState["listid"];
            }

            foreach (GridViewRow row in this.GridView2.Rows)
            {
                CheckBox cbx = (CheckBox)row.FindControl("cboxselect");

                var selectedkey = int.Parse(GridView2.DataKeys[row.RowIndex].Value.ToString());

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
            GridView2.PageIndex = e.NewPageIndex;
            getdata(ViewState["datareq"].ToString());
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<int> idlist = ViewState["listid"] as List<int>;
            if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            {
                var autoid = int.Parse(GridView2.DataKeys[e.Row.RowIndex].Value.ToString());
                if (idlist.Contains(autoid))
                {
                    CheckBox cbx = (CheckBox)e.Row.FindControl("cboxselect");
                    cbx.Checked = true;
                }
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            add(tboxitemno.Text, tboxkno.Text, tboxlocation.Text, tboxparts.Text, tboxarticleno.Text, tboxlength.Text, tboxwidthin.Text, tboxwidthout.Text, tboxqty.Text);
            loaditem();
        }
        private void add(string itemno, string kno, string location, string parts, string articleno, string length, string widthin, string widthout, string qty)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Create");
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        sqlcmd.Parameters.AddWithValue("@Item_No", itemno);
                        sqlcmd.Parameters.AddWithValue("@K_No", kno);
                        sqlcmd.Parameters.AddWithValue("@Location", location);
                        sqlcmd.Parameters.AddWithValue("@Parts", parts);
                        sqlcmd.Parameters.AddWithValue("@Article_No", articleno);
                        sqlcmd.Parameters.AddWithValue("@Profile_Length", length);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_In", widthin);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_Out", widthout);
                        sqlcmd.Parameters.AddWithValue("@Qty", qty);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
         
        }
        private void loaditem()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        GridView1.DataSource = sqlcmd.ExecuteReader();
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void deleteme(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Delete");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
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
                loaditem();
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView1.Rows[rowindex];
            if (e.CommandName == "mydelete")
            {
                deleteme(((Label)row.FindControl("lblid")).Text);
            }
            else if (e.CommandName == "myedit")
            {
                controlVisibility(row, false);
                ((Panel)row.FindControl("btnpanel2")).Visible = true;
                ((Panel)row.FindControl("btnpanel1")).Visible = false;
            }
            else if (e.CommandName == "mycancel")
            {
                controlVisibility(row, true);
                ((Panel)row.FindControl("btnpanel2")).Visible = false;
                ((Panel)row.FindControl("btnpanel1")).Visible = true;
            }
            else if (e.CommandName == "mysave")
            {
                update(row);

            }
        }
        private void controlVisibility(GridViewRow row, bool b)
        {
            ((Label)row.FindControl("lblitemno")).Visible = b;
            ((Label)row.FindControl("lblkno")).Visible = b;
            ((Label)row.FindControl("lbllocation")).Visible = b;
            ((Label)row.FindControl("lblparts")).Visible = b;
            ((Label)row.FindControl("lblarticleno")).Visible = b;
            ((Label)row.FindControl("lbllength")).Visible = b;
            ((Label)row.FindControl("lblinside")).Visible = b;
            ((Label)row.FindControl("lbloutside")).Visible = b;
            ((Label)row.FindControl("lblqty")).Visible = b;

            ((TextBox)row.FindControl("tboxitemnoE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxknoE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxlocationE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxpartsE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxarticlenoE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxlengthE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxwidthinE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxwidthoutE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxqtyE")).Visible = b == true ? false : true;

        }
        private void update(GridViewRow row)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Update_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Id", ((Label)row.FindControl("lblid")).Text);
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        sqlcmd.Parameters.AddWithValue("@Item_No", ((TextBox)row.FindControl("tboxitemnoE")).Text);
                        sqlcmd.Parameters.AddWithValue("@K_No", ((TextBox)row.FindControl("tboxknoE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Location", ((TextBox)row.FindControl("tboxlocationE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Parts", ((TextBox)row.FindControl("tboxpartsE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Article_No", ((TextBox)row.FindControl("tboxarticlenoE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Profile_Length", ((TextBox)row.FindControl("tboxlengthE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_In", ((TextBox)row.FindControl("tboxwidthinE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_Out", ((TextBox)row.FindControl("tboxwidthoutE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Qty", ((TextBox)row.FindControl("tboxqtyE")).Text);
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
                controlVisibility(row, true);
                ((Panel)row.FindControl("btnpanel2")).Visible = false;
                ((Panel)row.FindControl("btnpanel1")).Visible = true;
                loaditem();
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
            foreach (GridViewRow row in GridView2.Rows)
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
                        string kno, itemno, location,parts,length, width, height;
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        itemno = mytb.Rows[i]["item_no"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        width = mytb.Rows[i]["width"].ToString();
                        height = mytb.Rows[i]["height"].ToString();
                        parts = "Frame width";
                        length = width;
                        for (int x = 0; x <= 1; x++)
                        {
                            add(itemno,kno,location,parts,"",length,"","","");
                            parts = "Frame height";
                            length = height;
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
                loaditem();
            }

            ViewState["listid"] = l;
        }
    }
}