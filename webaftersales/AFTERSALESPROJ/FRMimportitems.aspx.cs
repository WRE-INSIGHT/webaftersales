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
    public partial class FRMimportitems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lbl = (Label)this.Master.FindControl("lblheader") as Label;
                lbl.Text = "Import Item";
                Page previouspage = Page.PreviousPage;
                if (previouspage is frmReport)
                {
                    ViewState["jo"] = ((frmReport)previouspage).jo;
                }
                getdata();
            }

        }
        private string jo
        {
            get
            {
                return ViewState["jo"].ToString();
            }
        }
        private void getdata()
        {
            try
            {
                DataSet ds = new DataSet();
                ds.Clear();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon1"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    SqlCommand sqlcmd = new SqlCommand("select  row_number() OVER (order by kno) ID, kmdi_no,item_no,location from kmdi_fabrication_tb where job_order_no = '" + jo + "'", sqlcon);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(ds, "kmdi_fabrication_tb");
                    GridView1.DataSource = ds;
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());

            }


        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<int> rowlist = new List<int>();
            if (ViewState["rowlist"] != null)
            {
                rowlist = (List<int>)ViewState["rowlist"];
            }

            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbx = (CheckBox)row.FindControl("cboxselect");

                var selectedkey = row.RowIndex;

                if (cbx.Checked)
                {
                    if (!rowlist.Contains(selectedkey))
                    {
                        rowlist.Add(selectedkey);
                    }
                }
                else
                {
                    if (rowlist.Contains(selectedkey))
                    {
                        rowlist.Remove(selectedkey);
                    }
                }
            }

            ViewState["rowlist"] = rowlist;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            {
                List<int> rowlist = ViewState["rowlist"] as List<int>;
                if (e.Row.RowType == DataControlRowType.DataRow && rowlist != null)
                {
                    var autoid = e.Row.RowIndex;
                    if (rowlist.Contains(autoid))
                    {
                        CheckBox cbx = (CheckBox)e.Row.FindControl("cboxselect");
                        cbx.Checked = true;
                    }
                }
            }
        }

        protected void btnimport_Click(object sender, EventArgs e)
        {
            List<int> l = new List<int>();
            if ((List<int>)ViewState["rowlist"] == null)
            {
                l.Add(0);
            }
            else
            {
                l = ViewState["rowlist"] as List<int>;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = row.RowIndex;
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = row.RowIndex;
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            ViewState["rowlist"] = l;
            foreach (int i in l)
            {
           
                string x = GridView1.Rows[i].Cells[2].Text.ToString();
                TextBox1.Text += x;
            }

        }
    }
}