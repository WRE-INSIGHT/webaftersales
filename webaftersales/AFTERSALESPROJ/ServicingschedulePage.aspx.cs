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
    public partial class ServicingschedulePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
            if (Session["username"] != null)
            {
                if (!IsPostBack)
                {
                    getdata();
                }
            }
            else
            {
                Response.Redirect("~/AFTERSALESPROJ/LoginPage.aspx");
            }
        }

        protected void searcbtn_Click(object sender, EventArgs e)
        {
            getdata();
        }
        private void getdata()
        {
            GridView1.DataSource = dal.servicedataaccesslayer.GetService();
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VIEWSCHEDULE")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
              
             
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}