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
                Session["SID"] = 12;
            }

        }

        protected void GridView2_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            //if (e.AffectedRows < 1)
            //{
            //    e.KeepInEditMode = true;
            //    lblerror.Text = "not updated";
            //    lblerror.ForeColor = System.Drawing.Color.Red;
            //}
            //else
            //{
            //    lblerror.Text = "updated successfully";
            //    lblerror.ForeColor = System.Drawing.Color.Green;
            //}
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

    }
}