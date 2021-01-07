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
    public partial class projectList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        loaddata();
                        loadAEIC("ACCT_EXEC_INCHARGE", ddlAEIC);
                        loadAEIC("PROJECT_ENGR_INCHARGE", ddlEngr);
                        loadColor();
                    }
                }
                else
                {
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
                }
            }


        }
        private string sqlconstr1
        {
            get
            {
                return ConnectionString.sqlconstr1();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void loadAEIC(string column, DropDownList x)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
            {
                using (SqlCommand sqlcmd = new SqlCommand("select distinct " + column + " from addendum_to_contract_tb order by " + column + " asc", sqlcon))
                {
                    sqlcon.Open();
                    x.DataSource = sqlcmd.ExecuteReader();
                    x.DataTextField = column;
                    x.DataValueField = column;
                    x.DataBind();
                    x.Text = "";
                }
            }
        }
        private void loadColor()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
            {
                using (SqlCommand sqlcmd = new SqlCommand("select * from kmdi_addinfo_tb where type = 'PROFILE_FINISH' order by value asc", sqlcon))
                {
                    sqlcon.Open();
                    ddlColor.DataSource = sqlcmd.ExecuteReader();
                    ddlColor.DataTextField = "value";
                    ddlColor.DataValueField = "value";
                    ddlColor.DataBind();
                    ddlColor.Text = "";
                }
            }
        }
        private void loaddata()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "project_list_stp";
                    sqlcmd.Parameters.AddWithValue("@searchkey", tboxSearch.Text);
                    DataTable tb = new DataTable();
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                }
            }
        }
        private bool checkjo()
        {
            bool x = false;
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
            {
                sqlcon.Open();
                using (SqlCommand sqlcmd = new SqlCommand("select JOB_ORDER_NO from addendum_to_contract_tb where job_order_no = '" + tboxJO.Text + "'", sqlcon))
                {
                    using (SqlDataReader rd = sqlcmd.ExecuteReader())
                    {
                        if (rd.HasRows)
                        {
                            x = true;
                        }
                    }
                }
            }
            return x;
        }
        private void insertproject()
        {

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "project_list_insert__stp";
                    sqlcmd.Parameters.AddWithValue("@CLIENTS_NAME", tboxClientsName.Text);
                    sqlcmd.Parameters.AddWithValue("@COMPANY_NAME", tboxCompanyName.Text);
                    sqlcmd.Parameters.AddWithValue("@FILE_LABEL_AS", ddlFileLabel.Text);
                    sqlcmd.Parameters.AddWithValue("@UNITNO", tboxUnitno.Text);
                    sqlcmd.Parameters.AddWithValue("@ESTABLISHMENT", tboxEstablishment.Text);
                    sqlcmd.Parameters.AddWithValue("@NO", tboxNo.Text);
                    sqlcmd.Parameters.AddWithValue("@STREET", tboxStreet.Text);
                    sqlcmd.Parameters.AddWithValue("@VILLAGE", tboxVillage.Text);
                    sqlcmd.Parameters.AddWithValue("@BRGY_MUNICIPALITY", tboxBrgy.Text);
                    sqlcmd.Parameters.AddWithValue("@TOWN_DISTRICT", tboxTown.Text);
                    sqlcmd.Parameters.AddWithValue("@PROVINCE", tboxProvince.Text);
                    sqlcmd.Parameters.AddWithValue("@AREA", tboxArea.Text);
                    sqlcmd.Parameters.AddWithValue("@ACCT_EXEC_INCHARGE", ddlAEIC.Text);
                    sqlcmd.Parameters.AddWithValue("@PROJECT_ENGR_INCHARGE", ddlEngr.Text);
                    sqlcmd.Parameters.AddWithValue("@JOB_ORDER_NO_DATE", tboxJODate.Text);
                    sqlcmd.Parameters.AddWithValue("@QUOTE_REF_NO", tboxQuotationRefNo.Text);
                    sqlcmd.Parameters.AddWithValue("@QUOTATION_DATE", tboxQuotationDate.Text);
                    sqlcmd.Parameters.AddWithValue("@JOB_ORDER_NO", tboxJO.Text);
                    sqlcmd.Parameters.AddWithValue("@INPUTTED", "Aftersales/" + Session["userid"].ToString());
                    sqlcmd.Parameters.AddWithValue("@PROFILE_FINISH", tboxColor.Text);
                    sqlcmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (checkjo())
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "inputVal";
                    err.IsValid = false;
                    err.ErrorMessage = "Error, Job Order Number already exist!";
                    Page.Validators.Add(err);
                }
                else
                {
                    insertproject();
                    loaddata();
                }
            }
        }

        protected void btnSelectColor_Click(object sender, EventArgs e)
        {
            tboxColor.Text = tboxColor.Text == "" ? ddlColor.Text : tboxColor.Text + ", " + ddlColor.Text;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editCommand")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                GridView1.SelectedIndex = rowindex;
                tboxClientsName.Text = ((Label)row.FindControl("lblClientsName")).Text;
                tboxCompanyName.Text = ((Label)row.FindControl("lblCompanyName")).Text;
                ddlFileLabel.Text = ((Label)row.FindControl("lblFileLabel")).Text;
                tboxUnitno.Text = ((Label)row.FindControl("lblUnitno")).Text;
                tboxEstablishment.Text = ((Label)row.FindControl("lblEstablishment")).Text;
                tboxNo.Text = ((Label)row.FindControl("lblNo")).Text;
                tboxStreet.Text = ((Label)row.FindControl("lblStreet")).Text;
                tboxVillage.Text = ((Label)row.FindControl("lblVillage")).Text;
                tboxBrgy.Text = ((Label)row.FindControl("lblBrgy")).Text;
                tboxTown.Text = ((Label)row.FindControl("lblTown")).Text;
                tboxProvince.Text = ((Label)row.FindControl("lblProvince")).Text;
                tboxArea.Text = ((Label)row.FindControl("lblArea")).Text;
                ddlAEIC.Text = ((Label)row.FindControl("lblAEIC")).Text;
                ddlEngr.Text = ((Label)row.FindControl("lblEngr")).Text;
                tboxJODate.Text = ((Label)row.FindControl("lblJODate")).Text;
                tboxQuotationRefNo.Text = ((Label)row.FindControl("lblQuotationRefNo")).Text;
                tboxQuotationDate.Text = ((Label)row.FindControl("lblQuotationDate")).Text;
                tboxJO.Text = ((Label)row.FindControl("lblJO")).Text;
                tboxColor.Text = ((Label)row.FindControl("lblProfileColor")).Text;

                lblEditMode.Visible = true;
                tboxJO.Enabled = false;
                btnSave.Visible = false;
                btnUpdate.Visible = true;
                btnCancel.Visible = true;
                Panel1.Enabled = false;
                Panel1.Enabled = true;
                tboxClientsName.Focus();
            }
            else if (e.CommandName == "selectCommand")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["callinProject"] = ((Label)row.FindControl("lblProjectLabel")).Text;
                Session["callinAddress"] = ((Label)row.FindControl("lblFulladd")).Text;
                Session["callinJo"] = ((Label)row.FindControl("lblJO")).Text;
                Response.Redirect("~/AFTERSALESPROJ/newcallin.aspx");
            }
            else if (e.CommandName == "deleteCommand")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                deleteInput(((Label)row.FindControl("lblJO")).Text);
            }
        }

        private void deleteInput(string jo)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr1))
            {
                using (SqlCommand sqlcmd = new SqlCommand("delete from addendum_to_contract_tb where job_order_no = '" + jo + "'", sqlcon))
                {
                    sqlcon.Open();
                    sqlcmd.ExecuteNonQuery();
                    loaddata();
                }
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            cancelMethod();
        }
        private void cancelMethod()
        {
            lblEditMode.Visible = false;
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            Panel1.Enabled = true;
            tboxJO.Enabled = true;
            lblEditMode.Visible = false;
            GridView1.SelectedIndex = -1;
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "project_list_update_stp";
                    sqlcmd.Parameters.AddWithValue("@CLIENTS_NAME", tboxClientsName.Text);
                    sqlcmd.Parameters.AddWithValue("@COMPANY_NAME", tboxCompanyName.Text);
                    sqlcmd.Parameters.AddWithValue("@FILE_LABEL_AS", ddlFileLabel.Text);
                    sqlcmd.Parameters.AddWithValue("@UNITNO", tboxUnitno.Text);
                    sqlcmd.Parameters.AddWithValue("@ESTABLISHMENT", tboxEstablishment.Text);
                    sqlcmd.Parameters.AddWithValue("@NO", tboxNo.Text);
                    sqlcmd.Parameters.AddWithValue("@STREET", tboxStreet.Text);
                    sqlcmd.Parameters.AddWithValue("@VILLAGE", tboxVillage.Text);
                    sqlcmd.Parameters.AddWithValue("@BRGY_MUNICIPALITY", tboxBrgy.Text);
                    sqlcmd.Parameters.AddWithValue("@TOWN_DISTRICT", tboxTown.Text);
                    sqlcmd.Parameters.AddWithValue("@PROVINCE", tboxProvince.Text);
                    sqlcmd.Parameters.AddWithValue("@AREA", tboxArea.Text);
                    sqlcmd.Parameters.AddWithValue("@ACCT_EXEC_INCHARGE", ddlAEIC.Text);
                    sqlcmd.Parameters.AddWithValue("@PROJECT_ENGR_INCHARGE", ddlEngr.Text);
                    sqlcmd.Parameters.AddWithValue("@JOB_ORDER_NO_DATE", tboxJODate.Text);
                    sqlcmd.Parameters.AddWithValue("@QUOTE_REF_NO", tboxQuotationRefNo.Text);
                    sqlcmd.Parameters.AddWithValue("@QUOTATION_DATE", tboxQuotationDate.Text);
                    sqlcmd.Parameters.AddWithValue("@JOB_ORDER_NO", tboxJO.Text);
                    sqlcmd.Parameters.AddWithValue("@UPDATED", "Aftersales/" + Session["userid"].ToString() + " " + DateTime.Now.ToString());
                    sqlcmd.Parameters.AddWithValue("@PROFILE_FINISH", tboxColor.Text);
                    sqlcmd.ExecuteNonQuery();
                    cancelMethod();
                    loaddata();
                }
            }
        }
    }
}