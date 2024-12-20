﻿using System;
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
    public partial class assessmentmade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {

                if (!IsPostBack)
                {
                    lblkno.Text = kno;
                    lbllocation.Text = location;
                    getdata();
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
        private string reportid
        {
            get
            {
                return Session["reportID"].ToString();
            }
        }
        private string fullname
        {
            get
            {
                return Session["userfullname"].ToString();
            }
        }
        private string location
        {
            get
            {
                return Session["LOCATION"].ToString();
            }
        }
        private string jo
        {
            get
            {
                return Session["JOBORDERNO"].ToString();
            }
        }
        private string kno
        {
            get
            {
                return Session["KNO"].ToString();
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
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "TBLassessment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "GetData");
                        sqlcmd.Parameters.AddWithValue("@reportid", reportid);
                        DataSet ds = new DataSet();
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = rowindex;

                ((LinkButton)row.FindControl("editbtn")).Visible = false;
                ((LinkButton)row.FindControl("deletebtn")).Visible = false;
                ((Label)row.FindControl("descriptionlbl")).Visible = false;
                ((Label)row.FindControl("assessmentlbl")).Visible = false;
                ((Label)row.FindControl("progresslbl")).Visible = false;
                ((Label)row.FindControl("lblStockUsed")).Visible = false;
                ((Label)row.FindControl("lblMeasurement")).Visible = false;
                ((Label)row.FindControl("lblQuantity")).Visible = false;
                ((Label)row.FindControl("lblBreakage")).Visible = false;
                ((Label)row.FindControl("lblTyphoon")).Visible = false;
                ((Label)row.FindControl("lblTyphoonName")).Visible = false;

                ((LinkButton)row.FindControl("savebtn")).Visible = true;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = true;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = true;
                ((TextBox)row.FindControl("assessmenttbox")).Visible = true;
                ((DropDownList)row.FindControl("progressddl")).Visible = true;
                ((TextBox)row.FindControl("tboxQuantityEdit")).Visible = true;
                ((TextBox)row.FindControl("tboxMeasurementEdit")).Visible = true;
                ((DropDownList)row.FindControl("ddlStockUsedEdit")).Visible = true;
                ((CheckBox)row.FindControl("cboxBreakageEdit")).Visible = true;
                ((CheckBox)row.FindControl("cboxTyphoonEdit")).Visible = true;
                if (((CheckBox)row.FindControl("cboxTyphoonEdit")).Checked)
                {
                    ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Visible = true;
                }
             
            }
                if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                if (((CheckBox)row.FindControl("cboxTyphoonEdit")).Checked && ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Text == "")
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "editVal" + ((Label)row.FindControl("idlbl")).Text;
                    err.IsValid = false;
                    err.ErrorMessage = "Please fill the typhoon name.";
                    Page.Validators.Add(err);
                }
                else
                {
                    updatefunction(((Label)row.FindControl("idlbl")).Text,
                      ((TextBox)row.FindControl("descriptiontbox")).Text,
                      ((TextBox)row.FindControl("assessmenttbox")).Text,
                      ((DropDownList)row.FindControl("progressddl")).Text,
                      ((DropDownList)row.FindControl("ddlStockUsedEdit")).Text,
                      ((TextBox)row.FindControl("tboxMeasurementEdit")).Text,
                      ((TextBox)row.FindControl("tboxQuantityEdit")).Text,
                       ((CheckBox)row.FindControl("cboxBreakageEdit")).Checked,
                   ((CheckBox)row.FindControl("cboxTyphoonEdit")).Checked,
                   ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Text);
                }

              
            }
            if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deletefunction(((Label)row.FindControl("idlbl")).Text);
            }
            if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                GridView1.SelectedIndex = -1;

                ((LinkButton)row.FindControl("editbtn")).Visible = true;
                ((LinkButton)row.FindControl("deletebtn")).Visible = true;
                ((Label)row.FindControl("descriptionlbl")).Visible = true;
                ((Label)row.FindControl("assessmentlbl")).Visible = true;
                ((Label)row.FindControl("progresslbl")).Visible = true;
                ((Label)row.FindControl("lblStockUsed")).Visible = true;
                ((Label)row.FindControl("lblMeasurement")).Visible = true;
                ((Label)row.FindControl("lblQuantity")).Visible = true;
                ((Label)row.FindControl("lblBreakage")).Visible = true;
                ((Label)row.FindControl("lblTyphoon")).Visible = true;
                ((Label)row.FindControl("lblTyphoonName")).Visible = true;

                ((LinkButton)row.FindControl("savebtn")).Visible = false;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = false;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = false;
                ((TextBox)row.FindControl("assessmenttbox")).Visible = false;
                ((DropDownList)row.FindControl("progressddl")).Visible = false;
                ((TextBox)row.FindControl("tboxQuantityEdit")).Visible = false;
                ((TextBox)row.FindControl("tboxMeasurementEdit")).Visible = false;
                ((DropDownList)row.FindControl("ddlStockUsedEdit")).Visible = false;
                ((CheckBox)row.FindControl("cboxBreakageEdit")).Visible = false;
                ((CheckBox)row.FindControl("cboxTyphoonEdit")).Visible = false;
                ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Visible = false;
            }

        }
        private void updatefunction(string id, string description, string assessment,
                                    string progressddl, string stock_used, string measurement, string quantity,
                                    bool breakage, bool typhoon,string typhoon_name)
        {
            if (cboxTyphoon.Checked)
            {
                if (tboxTyphoonName.Text == "")
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "inputVal";
                    err.IsValid = false;
                    err.ErrorMessage = "Please fill the typhoon name.";
                    Page.Validators.Add(err);
                }
                else
                {
                    UpdateQuery(id, description, assessment, progressddl, stock_used, measurement, quantity, breakage, typhoon, typhoon_name);
                }
            }
            else
            {
                UpdateQuery(id, description, assessment, progressddl, stock_used, measurement, quantity, breakage, typhoon, typhoon_name);
            }

        }
        private void UpdateQuery(string id, string description, string assessment,
                                    string progressddl, string stock_used, string measurement, string quantity, bool breakage, bool typhoon,string typhoon_name)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    try
                    {
                        string date_modified = "updatted by " + fullname + " ";
                        sqlcmd.CommandText = "TBLassessment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@assessment", assessment);
                        sqlcmd.Parameters.AddWithValue("@progress", progressddl);
                        sqlcmd.Parameters.AddWithValue("@date_modified", date_modified);
                        sqlcmd.Parameters.AddWithValue("@Stock_Used", stock_used);
                        sqlcmd.Parameters.AddWithValue("@Measurement", measurement);
                        sqlcmd.Parameters.AddWithValue("@Quantity", quantity);
                        sqlcmd.Parameters.AddWithValue("@Breakage", (breakage == true) ? 1 : 0);
                        sqlcmd.Parameters.AddWithValue("@Typhoon", (typhoon == true) ? 1 : 0);
                        sqlcmd.Parameters.AddWithValue("@Typhoon_Name", typhoon_name);
                        sqlcmd.ExecuteNonQuery();
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
            }
        }
        private void deletefunction(string id)
        {
            try
            {
                string str = "delete from [TBLassessment] WHERE ([ID] = @ID)";

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                getdata();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void newbtn_Click(object sender, EventArgs e)
        {
            if (cboxTyphoon.Checked)
            {
                if (tboxTyphoonName.Text == "")
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "inputVal";
                    err.IsValid = false;
                    err.ErrorMessage = "Please fill the typhoon name.";
                    Page.Validators.Add(err);
                }
                else
                {
                    InsertQuery();
                }
            }
            else
            {
                InsertQuery();
            }

        }
        private void InsertQuery()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    try
                    {
                        string date_modified = "inputted by " + fullname + " ";
                        sqlcmd.CommandText = "TBLassessment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@reportid", reportid);
                        sqlcmd.Parameters.AddWithValue("@description", newdescriptiontbox.Text);
                        sqlcmd.Parameters.AddWithValue("@assessment", newassessmenttbox.Text);
                        sqlcmd.Parameters.AddWithValue("@progress", newprogressddl.Text);
                        sqlcmd.Parameters.AddWithValue("@date_modified", date_modified);
                        sqlcmd.Parameters.AddWithValue("@Stock_Used", ddlStockUse.Text);
                        sqlcmd.Parameters.AddWithValue("@Measurement", tboxMeasurement.Text);
                        sqlcmd.Parameters.AddWithValue("@Quantity", tboxQuantity.Text);
                        sqlcmd.Parameters.AddWithValue("@Breakage", (cboxBreakage.Checked) ? 1 : 0);
                        sqlcmd.Parameters.AddWithValue("@Typhoon", (cboxTyphoon.Checked) ? 1 : 0);
                        sqlcmd.Parameters.AddWithValue("@Typhoon_Name", (cboxTyphoon.Checked) ? tboxTyphoonName.Text : "");
                        sqlcmd.ExecuteNonQuery();
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
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    GridView1.Columns[4].Visible = true;
                }
                else
                {
                    GridView1.Columns[4].Visible = false;
                }

            }
        }

        protected void cboxTyphoon_CheckedChanged(object sender, EventArgs e)
        {
            if (cboxTyphoon.Checked)
            {
                tboxTyphoonName.Visible = true;
            }
            else
            {
                tboxTyphoonName.Visible = false;
            }
        }
        protected void cboxTyphoonEdit_CheckedChanged(object sender, EventArgs e)
        {
            if (((CheckBox)sender).Checked)
            {
                int rowindex = ((GridViewRow)((CheckBox)sender).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Visible = true;
            }
            else
            {
                int rowindex = ((GridViewRow)((CheckBox)sender).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ((TextBox)row.FindControl("tboxTyphoon_NameEdit")).Visible = false;
            }
        }
    }
}