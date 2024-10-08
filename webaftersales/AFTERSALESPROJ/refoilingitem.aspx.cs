﻿using System;
using System.Collections;
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
                        get_refoiling();
                        getlocations();
                        loaditem();
                        displayvalue();
                        loadArticleno();
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
        private string refoilingqno
        {
            get
            {
                return Session["refoilingqno"].ToString();
            }
        }
        private string cin
        {
            get
            {
                return Session["CIN"].ToString();
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
        private DataTable itemtb
        {
            get
            {
                return (DataTable)ViewState["itemtb"];
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
        private string getdefaultvalue(string propertyname)
        {
            string d = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("select property_value from default_property_tbl where property_name = '" + propertyname + "'", sqlcon))
                    {
                        sqlcon.Open();
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                d = rd[0].ToString();
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            return d;
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
                        sqlcmd.CommandText = "[Refoiling_Id_Stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@QNO", refoilingqno);
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_reference");
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                tboxreference.Text = rd[0].ToString();
                                tboxsalutation.Text = rd[1].ToString();
                                tboxbody.Text = rd[2].ToString();
                                tboxMiscellaneous.Text = rd[3].ToString();
                            }
                        }
                        if (tboxbody.Text == "")
                        {
                            tboxbody.Text = "Thank you for letting us serve you. Please find herewith our quotation for the Golden Oak Sticker Foil Cost corresponding to our world-class PVC-u windows and doors from Germany for your requirements on your residence.";
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
        private void updateReferences()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[Refoiling_Id_Stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@QNO", refoilingqno);
                        sqlcmd.Parameters.AddWithValue("@Reference", tboxreference.Text);
                        sqlcmd.Parameters.AddWithValue("@Salutation", tboxsalutation.Text);
                        sqlcmd.Parameters.AddWithValue("@Body", tboxbody.Text);
                        sqlcmd.Parameters.AddWithValue("@Miscellaneous", tboxMiscellaneous.Text);
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
        private void updateProperty(string propertyname, string propertyvalue)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("update default_property_tbl set property_value = @property_value where property_name = '" + propertyname + "'", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@property_value", propertyvalue);
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
                displayvalue();
            }
        }
        protected void btnSet_Click(object sender, EventArgs e)
        {
            updateProperty("Refoiling Price per sqm", tboxRefoilingPerSqm.Text);
        }
        private void displayvalue()
        {
            tboxRefoilingPerSqm.Text = getdefaultvalue("Refoiling Price per sqm");
            tboxCleaningPerSqm.Text = getdefaultvalue("Refoiling Cleaning per sqm");
            tboxWastage.Text = getdefaultvalue("Refoiling landed cost per sql");
            lblwastage.Text = tboxWastage.Text;
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
            add(tboxitemno.Text, tboxkno.Text, tboxlocation.Text, tboxparts.Text, tboxdescription.Text, ddlarticleno.Text, tboxlength.Text, tboxwidthin.Text, tboxwidthout.Text, tboxqty.Text);
            loaditem();
        }
        ArrayList _AL_itemno = new ArrayList();
        ArrayList _AL_kno = new ArrayList();
        ArrayList _AL_location = new ArrayList();
        ArrayList _AL_parts = new ArrayList();
        ArrayList _AL_description = new ArrayList();
        ArrayList _AL_articleno = new ArrayList();
        ArrayList _AL_length = new ArrayList();
        ArrayList _AL_widthin = new ArrayList();
        ArrayList _AL_widthout = new ArrayList();
        ArrayList _AL_qty = new ArrayList();
        private void add(string itemno, string kno, string location, string parts, string description, string articleno, string length, string widthin, string widthout, string qty)
        {
            try
                {
                 using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                 {
                     sqlcon.Open();
                     using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                     {
                         sqlcmd.CommandText = "Refoiling_Method2_Stp";
                         sqlcmd.CommandType = CommandType.StoredProcedure;
                         sqlcmd.Parameters.AddWithValue("@Command", "Create");
                         sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                         sqlcmd.Parameters.AddWithValue("@Item_No", itemno);
                         sqlcmd.Parameters.AddWithValue("@K_No", kno);
                         sqlcmd.Parameters.AddWithValue("@Location", location);
                         sqlcmd.Parameters.AddWithValue("@Parts", parts);
                         sqlcmd.Parameters.AddWithValue("@Item_Description", description);
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
                        sqlcmd.CommandText = "Refoiling_Method2_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);

                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        ViewState["itemtb"] = tb;
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
                        sqlcmd.CommandText = "Refoiling_Method2_Stp";
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
            ((Label)row.FindControl("lbldescription")).Visible = b;
            ((Label)row.FindControl("lblarticleno")).Visible = b;
            ((Label)row.FindControl("lbllength")).Visible = b;
            ((Label)row.FindControl("lblinside")).Visible = b;
            ((Label)row.FindControl("lbloutside")).Visible = b;
            ((Label)row.FindControl("lblqty")).Visible = b;

            ((TextBox)row.FindControl("tboxitemnoE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxknoE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxlocationE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxpartsE")).Visible = b == true ? false : true;
            ((TextBox)row.FindControl("tboxdescriptionE")).Visible = b == true ? false : true;
            ((DropDownList)row.FindControl("cboxarticlenoE")).Visible = b == true ? false : true;
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
                        sqlcmd.Parameters.AddWithValue("@Item_Description", ((TextBox)row.FindControl("tboxdescriptionE")).Text);
                        sqlcmd.Parameters.AddWithValue("@Article_No", ((DropDownList)row.FindControl("cboxarticlenoE")).Text);
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
                        string kno, itemno, location, parts, description, length, width, height;
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        itemno = mytb.Rows[i]["item_no"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        width = mytb.Rows[i]["width"].ToString();
                        height = mytb.Rows[i]["height"].ToString();
                        parts = "Frame width";
                        description = mytb.Rows[i]["description"].ToString();
                        length = width;
                        for (int x = 0; x <= 1; x++)
                        {
                            add(itemno, kno, location, parts, description, "", length, "", "", "");
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

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            updateProperty("Refoiling Cleaning per sqm", tboxCleaningPerSqm.Text);
        }

        protected void ddlarticleno_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Select");
                        sqlcmd.Parameters.AddWithValue("@Article_No", ddlarticleno.Text);
                        using (SqlDataReader dr = sqlcmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                tboxwidthin.Text = dr[0].ToString();
                                tboxwidthout.Text = dr[1].ToString();
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
        private void loadArticleno()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Profile_Width_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "GetArticle");
                        ddlarticleno.DataSource = sqlcmd.ExecuteReader();
                        ddlarticleno.DataTextField = "Article_No";
                        ddlarticleno.DataBind();
                        ddlarticleno.SelectedIndex = -1;
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            tboxbody.Text = tboxbody.Text.Replace("'", "`");
            tboxbody.Text = tboxbody.Text.Replace("\"", "``");
            updateReferences();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //List<int> idlist = ViewState["listidg1"] as List<int>;
            //if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            //{
            //    var autoid = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
            //    if (idlist.Contains(autoid))
            //    {
            //        CheckBox cbx = (CheckBox)e.Row.FindControl("cboxg1");
            //        cbx.Checked = true;
            //    }
            //}
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "confimmessage();", true);

            List<int> idl = new List<int>();
            if ((List<int>)ViewState["listidg1"] == null)
            {
                idl.Add(0);
            }
            else
            {
                idl = ViewState["listidg1"] as List<int>;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxg1");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (!idl.Contains(x))
                    {
                        idl.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (idl.Contains(x))
                    {
                        idl.Remove(x);
                    }
                }
            }
            try
            {
                resetselection();
                foreach (int id in idl)
                {
                    forcutting(id.ToString());
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/RefoilingCuttingList.aspx");
            }

            ViewState["listidg1"] = idl;
        }
        private void resetselection()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_For_Cutting_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Reset");
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }
        private void selectall(string command)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_For_Cutting_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }
        private void forcutting(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_For_Cutting_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "For_cutting");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.Message.ToString());
            }
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            updateProperty("Refoiling landed cost per sql", tboxWastage.Text);
        }

        protected void LinkButton8_Click(object sender, EventArgs e)
        {
            for (int i = 0; i <= itemtb.Rows.Count - 1; i++)
            {
                updateall(itemtb.Rows[i]["Id"].ToString(),
                    itemtb.Rows[i]["Item_No"].ToString(),
                    itemtb.Rows[i]["K_No"].ToString(),
                    itemtb.Rows[i]["Location"].ToString(),
                    itemtb.Rows[i]["Parts"].ToString(),
                    itemtb.Rows[i]["Item_Description"].ToString(),
                    itemtb.Rows[i]["Article_No"].ToString(),
                    itemtb.Rows[i]["Profile_Length"].ToString(),
                    itemtb.Rows[i]["Profile_Width_In"].ToString(),
                    itemtb.Rows[i]["Profile_Width_Out"].ToString(),
                    itemtb.Rows[i]["Qty"].ToString());
            }
            loaditem();
        }
        private void updateall(string Id,
            string Item_No,
            string K_No,
            string Location,
            string Parts,
            string Item_Description,
            string Article_No,
            string Profile_Length,
            string Profile_Width_In,
            string Profile_Width_Out,
            string Qty)
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
                        sqlcmd.Parameters.AddWithValue("@Id", Id);
                        sqlcmd.Parameters.AddWithValue("@Refoiling_Id", refoilingqno);
                        sqlcmd.Parameters.AddWithValue("@Item_No", Item_No);
                        sqlcmd.Parameters.AddWithValue("@K_No", K_No);
                        sqlcmd.Parameters.AddWithValue("@Location", Location);
                        sqlcmd.Parameters.AddWithValue("@Parts", Parts);
                        sqlcmd.Parameters.AddWithValue("@Item_Description", Item_Description);
                        sqlcmd.Parameters.AddWithValue("@Article_No", Article_No);
                        sqlcmd.Parameters.AddWithValue("@Profile_Length", Profile_Length);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_In", Profile_Width_In);
                        sqlcmd.Parameters.AddWithValue("@Profile_Width_Out", Profile_Width_Out);
                        sqlcmd.Parameters.AddWithValue("@Qty", Qty);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void get_refoiling()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Id_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Refoiling");
                        sqlcmd.Parameters.AddWithValue("@CIN", cin);
                        sqlcmd.Parameters.AddWithValue("@SID", sid);
                        sqlcmd.Parameters.AddWithValue("@QNO", refoilingqno);
                        ddlFoilQuotation.DataSource = sqlcmd.ExecuteReader();
                        ddlFoilQuotation.DataValueField = "QNO";
                        ddlFoilQuotation.DataTextField = "QNO";
                        ddlFoilQuotation.DataBind();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        private void get_refoiling_item(string refqu)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Refoiling_Method2_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@refoiling_id", refqu);
                        _AL_itemno = new ArrayList();
                        _AL_kno = new ArrayList();
                        _AL_location = new ArrayList();
                        _AL_parts = new ArrayList();
                        _AL_description = new ArrayList();
                        _AL_articleno = new ArrayList();
                        _AL_length = new ArrayList();
                        _AL_widthin = new ArrayList();
                        _AL_widthout = new ArrayList();
                        _AL_qty = new ArrayList();
                        SqlDataReader rd = sqlcmd.ExecuteReader();
                        while (rd.Read())
                        {
                            _AL_itemno.Add(rd[2].ToString());
                            _AL_kno.Add(rd[3].ToString());
                            _AL_location.Add(rd[4].ToString());
                            _AL_parts.Add(rd[5].ToString());
                            _AL_description.Add(rd[6].ToString());
                            _AL_articleno.Add(rd[7].ToString());
                            _AL_length.Add(rd[8].ToString());
                            _AL_widthin.Add(rd[9].ToString());
                            _AL_widthout.Add(rd[10].ToString());
                            _AL_qty.Add(rd[11].ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void LinkButton9_Click(object sender, EventArgs e)
        {
            get_refoiling_item(ddlFoilQuotation.Text);
            for (int i = 0; i <= _AL_itemno.Count - 1; i++)
            {
                var x = _AL_itemno[i].ToString();
                Console.WriteLine(x);
                add(_AL_itemno[i].ToString(),
                    _AL_kno[i].ToString(),
                    _AL_location[i].ToString(),
                    _AL_parts[i].ToString(),
                    _AL_description[i].ToString(),
                    _AL_articleno[i].ToString(),
                    _AL_length[i].ToString(),
                    _AL_widthin[i].ToString(),
                    _AL_widthout[i].ToString(),
                    _AL_qty[i].ToString());
            }
            loaditem();
        }

        protected void LinkButton10_Click(object sender, EventArgs e)
        {
            try
            {
                selectall("SelectAll");
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/AFTERSALESPROJ/RefoilingCuttingList.aspx");
            }
        }

        protected void LinkButton11_Click(object sender, EventArgs e)
        {
            try
            {
                selectall("UnselectAll");
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
    }
}