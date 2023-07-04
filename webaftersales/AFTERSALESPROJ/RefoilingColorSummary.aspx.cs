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
    public partial class RefoilingColorSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    loadColorList();
                    loadProject();
                    loadColor();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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
        private void loadProject()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_Area_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "loadProject");
                        sqlcmd.Parameters.AddWithValue("@Project", tboxProject.Text);
                        sqlcmd.Parameters.AddWithValue("@Color", ddlColor.Text);
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        DataSet ds = new DataSet();
                        ds.Clear();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "Project_Tbl");
                        gvProject.DataSource = ds;
                        gvProject.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void loadColor()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_Area_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "loadColor");
                        sqlcmd.Parameters.AddWithValue("@Project", tboxProject.Text);
                        sqlcmd.Parameters.AddWithValue("@Color", ddlColor.Text);
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        DataSet ds = new DataSet();
                        ds.Clear();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds, "Color_Tbl");
                        gvColor.DataSource = ds;
                        gvColor.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void loadColorList()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Refoiling_Area_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "ColorList");
                        ddlColor.DataSource = sqlcmd.ExecuteReader();
                        ddlColor.DataValueField = "Color";
                        ddlColor.DataTextField = "Color";
                        ddlColor.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void gvProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProject.PageIndex = e.NewPageIndex;
            loadProject();
        }

        protected void gvColor_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvColor.PageIndex = e.NewPageIndex;
            loadColor();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loadProject();
            loadColor();
        }
    }
}