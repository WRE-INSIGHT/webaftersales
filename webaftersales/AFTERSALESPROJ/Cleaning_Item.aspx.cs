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
    public partial class Cleaning_Item : System.Web.UI.Page
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
                        getdefaultvalue();
                        loadReferences();
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
        private void getdefaultvalue()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("select property_value from default_property_tbl where property_name = 'Cleaning Unit Price'", sqlcon))
                    {
                        sqlcon.Open();
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                tboxCleaningUnitPrice.Text = rd[0].ToString();
                            }
                        }
                    }

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
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Cleaning_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Cleaning_Id", iid);
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
                        string _in_out = "1";
                        if (rdInOutimport.Checked == true)
                        {
                            _in_out = "2";
                        }
                        else if (rdOutsideimport.Checked == true)
                        {
                            _in_out = "1";
                        }
                        query("Create", "", kno + " - " + location, width, height, "1", _in_out);
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

        protected void btnSet_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("update default_property_tbl set property_value = @property_value where property_name = 'Cleaning Unit Price'", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@property_value", tboxCleaningUnitPrice.Text);
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
                getdefaultvalue();
            }
        }

        private void query(string _command,
                            string _id,
                            string _item_description,
                            string _width,
                            string _height,
                            string _qty,
                            string _in_out)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Cleaning_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", _command);
                        sqlcmd.Parameters.AddWithValue("@Id", _id);
                        sqlcmd.Parameters.AddWithValue("@Cleaning_Id", iid);
                        sqlcmd.Parameters.AddWithValue("@Item_Description", _item_description);
                        sqlcmd.Parameters.AddWithValue("@Width", _width);
                        sqlcmd.Parameters.AddWithValue("@Height", _height);
                        sqlcmd.Parameters.AddWithValue("@Qty", _qty);
                        sqlcmd.Parameters.AddWithValue("@In_Out", _in_out);
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

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string _in_out = "1";
            if (rdInOut.Checked == true)
            {
                _in_out = "2";
            }
            else if (rdOutside.Checked == true)
            {
                _in_out = "1";
            }
            query("Create", "", tboxdescription.Text, tboxwidth.Text, tboxheight.Text, tboxqty.Text, _in_out);
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = false;
                ((LinkButton)row.FindControl("btndelete")).Visible = false;
                ((Label)row.FindControl("lblDescription")).Visible = false;
                ((Label)row.FindControl("lblWidth")).Visible = false;
                ((Label)row.FindControl("lblHeight")).Visible = false;
                ((Label)row.FindControl("lblQty")).Visible = false;
                ((Label)row.FindControl("lblIn_Out")).Visible = false;

                ((LinkButton)row.FindControl("btnsave")).Visible = true;
                ((LinkButton)row.FindControl("btncancel")).Visible = true;
                ((TextBox)row.FindControl("tboxdescriptionedit")).Visible = true;
                ((TextBox)row.FindControl("tboxwidthedit")).Visible = true;
                ((TextBox)row.FindControl("tboxheightedit")).Visible = true;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = true;
                ((Panel)row.FindControl("Panel33")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator31")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator32")).Visible = true;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = true;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("btnedit")).Visible = true;
                ((LinkButton)row.FindControl("btndelete")).Visible = true;
                ((Label)row.FindControl("lblDescription")).Visible = true;
                ((Label)row.FindControl("lblWidth")).Visible = true;
                ((Label)row.FindControl("lblHeight")).Visible = true;
                ((Label)row.FindControl("lblQty")).Visible = true;
                ((Label)row.FindControl("lblIn_Out")).Visible = true;

                ((LinkButton)row.FindControl("btnsave")).Visible = false;
                ((LinkButton)row.FindControl("btncancel")).Visible = false;
                ((TextBox)row.FindControl("tboxdescriptionedit")).Visible = false;
                ((TextBox)row.FindControl("tboxwidthedit")).Visible = false;
                ((TextBox)row.FindControl("tboxheightedit")).Visible = false;
                ((TextBox)row.FindControl("tboxqtyedit")).Visible = false;
                ((Panel)row.FindControl("Panel33")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator31")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator32")).Visible = false;
                ((RequiredFieldValidator)row.FindControl("RequiredFieldValidator4")).Visible = false;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                string _in_out = "1";
                if (((RadioButton)row.FindControl("rdInOutedit")).Checked == true)
                {
                    _in_out = "2";
                }
                else if (((RadioButton)row.FindControl("rdOutsideedit")).Checked == true)
                {
                    _in_out = "1";
                }


                query("Edit",
                    ((Label)row.FindControl("lblid")).Text,
                    ((TextBox)row.FindControl("tboxdescriptionedit")).Text,
                    ((TextBox)row.FindControl("tboxwidthedit")).Text,
                    ((TextBox)row.FindControl("tboxheightedit")).Text,
                    ((TextBox)row.FindControl("tboxqtyedit")).Text,
                    _in_out);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                query("Delete", ((Label)row.FindControl("lblid")).Text, "", "", "", "", "");
            }

        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            tboxbody.Text = tboxbody.Text.Replace("'", "`");
            tboxbody.Text = tboxbody.Text.Replace("\"", "``");
            updateReferences();
        }
        private void updateReferences()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[Cleaning_Item_Stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Cleaning_Id", iid);
                        sqlcmd.Parameters.AddWithValue("@Reference", tboxreference.Text);
                        sqlcmd.Parameters.AddWithValue("@Salutation", tboxsalutation.Text);
                        sqlcmd.Parameters.AddWithValue("@Body", tboxbody.Text);
                        sqlcmd.Parameters.AddWithValue("@Mobilization_Cost", tboxMobilization.Text);
                        sqlcmd.Parameters.AddWithValue("@Scaffolding_Cost", tboxScaffolding.Text);
                        sqlcmd.Parameters.AddWithValue("@Command", "Update_reference");
                        sqlcmd.ExecuteNonQuery();
                    }
                }

            }
            catch (Exception ex)
            {
                //errorrmessage(ex.Message.ToString());
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "SUCCESSVAL";
                err.IsValid = false;
                err.ErrorMessage = ex.Message.ToString();
                err.CssClass = "alert alert-danger";
                Page.Validators.Add(err);
            }
            finally
            {
                loadReferences();
                CustomValidator err = new CustomValidator();
                err.ValidationGroup = "SUCCESSVAL";
                err.IsValid = false;
                err.ErrorMessage = "saved successfully!";
                err.CssClass = "alert alert-success";
                Page.Validators.Add(err);
            }
        }
        private void loadReferences()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[Cleaning_Item_Stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Cleaning_Id", iid);
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_reference");
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                tboxreference.Text = rd[0].ToString();
                                tboxsalutation.Text = rd[1].ToString();
                                tboxbody.Text = rd[2].ToString();
                                tboxMobilization.Text = rd[3].ToString();
                                tboxScaffolding.Text = rd[4].ToString();
                            }
                        }
                        if (tboxbody.Text == "")
                        {
                            tboxbody.Text = "Thank you for letting us serve you. Please find herewith our quotation for the _____ for your requirements on your residence.";
                        }
                        if (tboxsalutation.Text == "")
                        {
                            tboxsalutation.Text = "Dear Mr/Mrs";
                        }
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