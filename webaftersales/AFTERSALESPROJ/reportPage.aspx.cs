using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class reportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    lblproject.Text = Session["PROJECT"].ToString();
                    lbladdress.Text = Session["ADDRESS"].ToString();
                    lbljo.Text = Session["JO"].ToString();
                    lblcolor.Text = Session["COLOR"].ToString();
                    lbldate.Text = "  " + Session["DATE"].ToString();
                    getteam();
                }

            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }
        private string sid
        {
            get
            {
                return Session["SID"].ToString();
            }
        }
        private string teamid
        {
            get
            {
                return Session["TEAMID"].ToString();
            }
        }
        private void getteam()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = sqlcon.CreateCommand();
                    sqlcmd.Parameters.AddWithValue("@TID", teamid);
                    sqlcmd.Parameters.AddWithValue("@sid", sid);
                    sqlcmd.CommandText = "stpgetteam";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    string teamname = "", personnel = "", servicing = "";
                    while (rd.Read())
                    {
                        teamname = rd[0].ToString();
                        personnel += rd[1].ToString() + "<br />";
                        servicing = rd[2].ToString();
                    }
                    lblteamname.Text = teamname;
                    lblpersonnel.Text = personnel;
                    lblservicing.Text = servicing;
                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
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


    }
}