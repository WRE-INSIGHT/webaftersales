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
                string str = "SELECT * FROM [TBLassessment] WHERE ([REPORTID] = @REPORTID)";
                
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@REPORTID", reportid);
                        DataSet ds = new DataSet();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
            catch(Exception ex)
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
                ((Label)row.FindControl("descriptionlbl")).Visible=false;
                ((Label)row.FindControl("assessmentlbl")).Visible = false;

                ((LinkButton)row.FindControl("savebtn")).Visible = true;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = true;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = true;
                ((TextBox)row.FindControl("assessmenttbox")).Visible = true;
             
            }
            if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                updatefunction(((Label)row.FindControl("idlbl")).Text,
                        ((TextBox)row.FindControl("descriptiontbox")).Text,
                        ((TextBox)row.FindControl("assessmenttbox")).Text);
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

                ((LinkButton)row.FindControl("savebtn")).Visible = false;
                ((LinkButton)row.FindControl("cancelbtn")).Visible = false;
                ((TextBox)row.FindControl("descriptiontbox")).Visible = false;
                ((TextBox)row.FindControl("assessmenttbox")).Visible = false;
            }

        }
        private void updatefunction(string id, string description, string assessment)
        {
            try
            {
                string str = "update [TBLassessment] set assessment=@assessment,description=@description WHERE ([ID] = @ID)";
                
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@description", description);
                        sqlcmd.Parameters.AddWithValue("@assessment", assessment);
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
            try
            {
                string str = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from TBLassessment) insert into [TBLassessment] (id,reportid,assessment,description)values(@id,@reportid,@assessment,@description)";
                
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@reportid", reportid);
                        sqlcmd.Parameters.AddWithValue("@description", newdescriptiontbox.Text);
                        sqlcmd.Parameters.AddWithValue("@assessment", newassessmenttbox.Text);
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

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }
    }
}