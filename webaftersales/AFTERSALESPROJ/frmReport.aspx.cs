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
                Session["dataurlsignature"] = "";
                Session["inspectedby"] = "";
                Session["inspecteddate"] ="";

                Session["dataurlsignature1"] = "";
                Session["monitoredby"] ="";
                Session["monitoreddate"] = "";

                Label l = this.Master.FindControl("lblheader") as Label;
                l.Text = "Reporting";

                Page lastpage = Page.PreviousPage;
                if (lastpage is WebForm1)
                {
                    lblproject.Text = ((WebForm1)lastpage).project;
                    lbladdress.Text = ((WebForm1)lastpage).address;
                    lbljo.Text = ((WebForm1)lastpage).jo;
                    lblprofilefinish.Text = ((WebForm1)lastpage).profilefinish;
                }

            }


        }
        public string jo
        {
            get
            {
                return lbljo.Text;
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
            ReportViewer1.LocalReport.Refresh();
        }

        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {

            ReportParameter[] repparam = new ReportParameter[3];
            repparam[0] = new ReportParameter("project", lblproject.Text.ToString());
            repparam[1] = new ReportParameter("address", lbladdress.Text.ToString());
            repparam[2] = new ReportParameter("profilefinish", lblprofilefinish.Text.ToString());
            for (int i = 0; i < 3; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

            if (Session["dataurlsignature"] != null)
            {
                ReportParameter[] param = new ReportParameter[3];
                param[0] = new ReportParameter("imgparam", Session["dataurlsignature"].ToString().Replace("data:image/png;base64,", ""));
                param[1] = new ReportParameter("inspectedby", Session["inspectedby"].ToString());
                param[2] = new ReportParameter("inspecteddate", Session["inspecteddate"].ToString());
                for (int i = 0; i < 3; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }
            }
            if (Session["dataurlsignature1"] != null)
            {
                ReportParameter[] param = new ReportParameter[3];
                param[0] = new ReportParameter("imgparam1", Session["dataurlsignature1"].ToString().Replace("data:image/png;base64,", ""));
                param[1] = new ReportParameter("monitoredby", Session["monitoredby"].ToString());
                param[2] = new ReportParameter("monitoreddate", Session["monitoreddate"].ToString());
                for (int i = 0; i < 3; i++)
                {
                    ReportViewer1.LocalReport.SetParameters(param[i]);
                }

            }
        }

        protected void btnimportitem_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/AFTERSALESPROJ/FRMimportitems.aspx");
        }
    }
}