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

        }

        protected void searcbtn_Click(object sender, EventArgs e)
        {
            getdata();
        }
        private void getdata()
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
                    sqlcmd.CommandText = "stpServicing";
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.Parameters.AddWithValue("@project", searchtbox.Text);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "tb");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception e)
            {
                Response.Write(e.ToString());
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "report")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                Session["SID"] = ((Label)row.Cells[0].FindControl("idlbl")).Text;
                Session["JO"] = ((Label)row.Cells[0].FindControl("jolbl")).Text;
                Session["PROJECT"] = ((LinkButton)row.Cells[0].FindControl("projectlbl")).Text;
                Session["ADDRESS"] = ((Label)row.Cells[0].FindControl("addresslbl")).Text;
                Session["COLOR"] = ((Label)row.Cells[0].FindControl("jolbl")).Text;
                Response.Write(Session["SID"]);
                Response.Write(Session["JO"]);
                Response.Write(Session["PROJECT"]);

            }
        }
    }
}