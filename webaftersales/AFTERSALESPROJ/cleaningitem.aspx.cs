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
    public partial class cleaningitem : System.Web.UI.Page
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
                        loaddata();
                        getlocations();
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private string iid
        {
            get
            {
                return Session["cleaningid"].ToString();
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
        private void loaddata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    string str = "select * from cleaningitem where IID=@iid";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from cleaningitem) " +
                        " insert into cleaningitem (id,iid,location,area,unitprice,qty,totalamount)values(@id,@iid,@location,@area,@unitprice,@qty,cast(@unitprice as decimal(10,2))*cast(@qty as decimal(10,2)))";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);

                        sqlcmd.Parameters.AddWithValue("@area", tboxarea.Text);
                        sqlcmd.Parameters.AddWithValue("@location", tboxlocation.Text);
                        sqlcmd.Parameters.AddWithValue("@unitprice", tboxunitprice.Text);
                        sqlcmd.Parameters.AddWithValue("@qty", tboxqty.Text);
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
                loaddata();
            }
        }
        private void insertNew(string area, string location, string unitprice, string qty)
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from cleaningitem) " +
                        " insert into cleaningitem (id,iid,location,area,unitprice,qty,totalamount)values(@id,@iid,@location,@area,@unitprice,@qty,cast(@unitprice as decimal(10,2))*cast(@qty as decimal(10,2)))";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@iid", iid);

                        sqlcmd.Parameters.AddWithValue("@area", area);
                        sqlcmd.Parameters.AddWithValue("@location", location);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
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
                loaddata();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
                ((Label)row.FindControl("lbllocation")).Visible = false;
                ((Label)row.FindControl("lblarea")).Visible = false;
                ((Label)row.FindControl("lblunitprice")).Visible = false;
                ((Label)row.FindControl("lblqty")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((TextBox)row.FindControl("tboxlocationedit")).Visible = true;
                ((TextBox)row.FindControl("tboxareaedit")).Visible = true;
                ((TextBox)row.FindControl("tboxunitpriceedit")).Visible = true;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lbllocation")).Visible = true;
                ((Label)row.FindControl("lblarea")).Visible = true;
                ((Label)row.FindControl("lblunitprice")).Visible = true;
                ((Label)row.FindControl("lblqty")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((TextBox)row.FindControl("tboxlocationedit")).Visible = false;
                ((TextBox)row.FindControl("tboxareaedit")).Visible = false;
                ((TextBox)row.FindControl("tboxunitpriceedit")).Visible = false;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator3")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = false;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                updateme(((Label)row.FindControl("lblid")).Text, ((TextBox)row.FindControl("tboxlocationedit")).Text,
             ((TextBox)row.FindControl("tboxareaedit")).Text, ((TextBox)row.FindControl("tboxunitpriceedit")).Text, ((TextBox)row.FindControl("tboxqtyedit")).Text);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                deleteme(((Label)row.FindControl("lblid")).Text);
            }

        }

        private void deleteme(string id)
        {
            try
            {


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    string str = "delete from cleaningitem where id = @id";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {

                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }


            }
            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "valedit";
                err.IsValid = false;
                err.ErrorMessage = ex.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                if (IsValid)
                {
                    loaddata();
                }

            }
        }

        private void updateme(string id, string location, string area, string unitprice, string qty)
        {
            try
            {
                string str = "update cleaningitem set location=@location,area=@area,unitprice=@unitprice,qty=@qty,totalamount=cast(isnull(@qty,0) as decimal(10,2))*cast(isnull(@unitprice,0) as decimal(10,2))  where id = @id";

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@location", location);
                        sqlcmd.Parameters.AddWithValue("@area", area);
                        sqlcmd.Parameters.AddWithValue("@unitprice", unitprice);
                        sqlcmd.Parameters.AddWithValue("@qty", qty);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "valedit";
                err.IsValid = false;
                err.ErrorMessage = ex.ToString();
                Page.Validators.Add(err);
            }
            finally
            {
                if (IsValid)
                {
                    loaddata();
                }

            }
        }
        protected void locationdl_SelectedIndexChanged(object sender, EventArgs e)
        {
            tboxsearch.Text = locationdl.Text;
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
                        string joborder, kno, itemno, location, width, height;
                        joborder = mytb.Rows[i]["job_order_no"].ToString();
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        itemno = mytb.Rows[i]["item_no"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        width = mytb.Rows[i]["width"].ToString();
                        height = mytb.Rows[i]["height"].ToString();

                        double w = (Convert.ToDouble(width) * (0.001));
                        double h = (Convert.ToDouble(height) * (0.001));
                        double a = w * h;
                        double u = a * 250;
                        insertNew(a.ToString(), kno + " - " + location, u.ToString(), "1");
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                loaddata();
            }

            ViewState["listid"] = l;

        }
        protected void searchbtn_Click(object sender, EventArgs e)
        {
            getdata("filter");
        }

    }
}