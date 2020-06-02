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
    public partial class quotationsummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                if (Session["useraccount"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        getdata();
                    }
                }
                else
                {
                    Response.Redirect("~/AFTERSALESPROJ/invalidaccessPage.aspx");
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
        private void getdata()
        {
            try
            {
                DataTable tb = new DataTable();
           
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "std_quotationsummary";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@searchkey", "%" + searchkey.Text + "%");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "showquotation")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                if (((GridView)row.FindControl("Gridview2")).Visible == true)
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = false;
                }
                else
                {
                    ((GridView)row.FindControl("Gridview2")).Visible = true;
                }
                showquotation(((Label)row.FindControl("lbljo")).Text, ((GridView)row.FindControl("Gridview2")));
            }
        }
        private void showquotation(string jo,GridView gv)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
                string str = " select * into #ctb from(select cin from callintb where jo = @jo) as tbll"+
                    " select [ID]   "+
    ",[CIN]                        "+
    ",[ASENO]                      "+
    ",case when isdate(qdate)=1 then format(cast([QDATE] as date),'MMM-dd-yyyy') else qdate end as  QDATE                    " +
    ",[PARTICULAR]                 "+
    ",[OTHERCHARGES]               "+
    ",[ACCEPTED]                   "+
    ",[UNITPRICE]                  "+
    ",'php '+format([NETPRICE],'n2') as  NETPRICE " +
    ",'php '+format([ACTUALPRICE],'n2') as ACTUALPRICE " +
    ",[SID]                        "+
    ",[PREPAREDBY]                 "+
    ",[APPROVEDBY]                 "+
    ",[ACCEPTEDBY] from quotationtb where cin in (select cin from #ctb) order by cast(qdate as date) asc";
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    using (SqlCommand sqlcmd=new SqlCommand(str,sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@jo", jo);
                        SqlDataAdapter da = new SqlDataAdapter();
                        DataTable tb = new DataTable();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        gv.DataSource = tb;
                        gv.DataBind();
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
    }
}