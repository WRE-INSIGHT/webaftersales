using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace webaftersales.AFTERSALESPROJ
{
    public partial class frmReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
            }

        }

        protected void GridView2_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblerror.Text = "not updated (row has been updated by another user)";
                lblerror.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblerror.Visible = false;        
            }
        }

        protected void lbtninsert_click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["SID"].DefaultValue = Session["SID"].ToString();
            SqlDataSource1.InsertParameters["kno"].DefaultValue =
               ((TextBox)GridView2.FooterRow.FindControl("tboxkno")).Text;
            SqlDataSource1.InsertParameters["itemno"].DefaultValue =
               ((TextBox)GridView2.FooterRow.FindControl("tboxitemno")).Text;
            SqlDataSource1.InsertParameters["location"].DefaultValue =
               ((TextBox)GridView2.FooterRow.FindControl("tboxlocation")).Text;
            SqlDataSource1.InsertParameters["specification"].DefaultValue =
             ((DropDownList)GridView2.FooterRow.FindControl("dlspecification")).Text;
            SqlDataSource1.InsertParameters["mobilizationcost"].DefaultValue =
             ((TextBox)GridView2.FooterRow.FindControl("tboxmobilizationcost")).Text;
            SqlDataSource1.Insert();
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                Control control = e.Row.Cells[0].Controls[2];
                if(control is LinkButton && ((LinkButton)control).Text=="Delete")
                {
                    ((LinkButton)control).OnClientClick = "return confirm('Are you sure you want to delete this record?');";
                }
            }
        }

        protected void GridView2_DataBound(object sender, EventArgs e)
        {
            if (GridView2.Rows.Count == 0)
            {
                btnaddnewreport.Visible = true;
            }
            else
            {
                btnaddnewreport.Visible = false;
            }
        }

        protected void addbtn_Click(object sender, EventArgs e)
        {
            try
            { 
            string constr = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(constr))
            {
                string qry = "declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from reporttb)"+
                    "insert into reporttb ([ID],[SID],[KNO],[ITEMNO],[LOCATION],[SPECIFICATION],[MOBILIZATIONCOST])"+
                    "values(@id,'" + Session["SID"] + "','" + tboxkno.Text + "','" + tboxitemno.Text + "','" + tboxlocation.Text + "','" + dlistspecification.Text + "','" + tboxmobilizationcost.Text + "')";
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand(qry, sqlcon);
                sqlcmd.ExecuteNonQuery();
            }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                GridView2.DataBind();
            }
        }

        protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lblerror.Visible = false;
        }
    }
}