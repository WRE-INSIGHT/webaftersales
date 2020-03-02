using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class frmReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
              
                Label l = this.Master.FindControl("lblheader") as Label;
                l.Text = "Reporting";

                Page lastpage = Page.PreviousPage;
                if (lastpage is WebForm1)
                {
                    lblproject.Text = ((WebForm1)lastpage).project;
                    lbladdress.Text = ((WebForm1)lastpage).address;
                }
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
            string _kno, _itemno, _location, _specification, _mobilizationcost;
            _kno = ((TextBox)GridView2.FooterRow.FindControl("tboxkno")).Text;
            _itemno = ((TextBox)GridView2.FooterRow.FindControl("tboxitemno")).Text;
            _location = ((TextBox)GridView2.FooterRow.FindControl("tboxlocation")).Text;
            _specification = ((DropDownList)GridView2.FooterRow.FindControl("dlspecification")).Text;
            _mobilizationcost = ((TextBox)GridView2.FooterRow.FindControl("tboxmobilizationcost")).Text;
            if (_mobilizationcost == "")
            {
                _mobilizationcost = "0";
            }
            insertdata(_kno, _itemno, _location, _specification, _mobilizationcost);
        }
        private void insertdata(string _kno, string _itemno, string _location, string _specification, string _mobilizationcost)
        {
            SqlDataSource1.InsertParameters["SID"].DefaultValue = Session["SID"].ToString();
            SqlDataSource1.InsertParameters["kno"].DefaultValue = _kno;
            SqlDataSource1.InsertParameters["itemno"].DefaultValue = _itemno;
            SqlDataSource1.InsertParameters["location"].DefaultValue = _location;
            SqlDataSource1.InsertParameters["specification"].DefaultValue = _specification;
            SqlDataSource1.InsertParameters["mobilizationcost"].DefaultValue = _mobilizationcost;
            SqlDataSource1.Insert();
        }
        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Control control = e.Row.Cells[0].Controls[2];
                if (control is LinkButton && ((LinkButton)control).Text == "Delete")
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
            string _kno, _itemno, _location, _specification, _mobilizationcost;
            _kno = tboxkno.Text;
            _itemno = tboxitemno.Text;
            _location = tboxlocation.Text;
            _specification = dlistspecification.Text;
            _mobilizationcost = tboxmobilizationcost.Text;
            if (_mobilizationcost == "")
            {
                _mobilizationcost = "0";
            }
            insertdata(_kno, _itemno, _location, _specification, _mobilizationcost);
        }

        protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lblerror.Visible = false;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ReportParameter param1 = new ReportParameter("imgparam", Session["TestSession"].ToString().Replace("data:image/png;base64,", ""));
            ReportViewer1.LocalReport.SetParameters(param1);
        }
    }
}