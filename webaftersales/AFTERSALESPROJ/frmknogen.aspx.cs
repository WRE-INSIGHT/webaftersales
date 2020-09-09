using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using webaftersales.AFTERSALESPROJ.dal;

namespace webaftersales.AFTERSALESPROJ
{
    public partial class frmknogen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getdata();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void getdata()
        {
            DataSet ds = new DataSet();
            ds.Clear();
          
        using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                sqlcon.Open();
                SqlCommand cmd = new SqlCommand("select ID,KMDI_NO,ITEM_NO,LOCATION FROM KMDI_FABRICATION_TB WHERE ID < 100", sqlcon);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(ds, "KMDI_FABRICATION_TB");
                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<int> idlist = new List<int>();
            if (ViewState["id"] != null)
            {
                idlist = (List<int>)ViewState["id"];
            }

            foreach (GridViewRow row in GridView1.Rows)
            {
                var id = int.Parse(GridView1.DataKeys[row.RowIndex].Value.ToString());
                CheckBox cb = (CheckBox)row.FindControl("cb");
                if (cb.Checked)
                {
                    if (!idlist.Contains(id))
                    {
                        idlist.Add(id);
                    }
                }
                else
                {
                    if (idlist.Contains(id))
                    {
                        idlist.Remove(id);
                    }
                }
            }
            ViewState["id"] = idlist;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<int> idlist = ViewState["id"] as List<int>;
            if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            {
                var id = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
                if (idlist.Contains(id))
                {
                    CheckBox cb = (CheckBox)e.Row.FindControl("cb");
                    cb.Checked = true;
                }
            }
        }

        protected void btnaddtoreport_Click(object sender, EventArgs e)
        {
            List<int> idlist = new List<int>();
            if (ViewState["id"] == null)
            {
                idlist.Add(0);
            }
            else
            {
                idlist = (List<int>)ViewState["id"];
            }


            foreach (GridViewRow row in GridView1.Rows)
            {
                var id = int.Parse(GridView1.DataKeys[row.RowIndex].Value.ToString());
                CheckBox cb = (CheckBox)row.FindControl("cb");
                if (cb.Checked)
                {
                    if (!idlist.Contains(id))
                    {
                        idlist.Add(id);
                    }
                }
                else
                {
                    if (idlist.Contains(id))
                    {
                        idlist.Remove(id);
                    }
                }
            }

            foreach (int i in idlist)
            {
                Response.Write(i.ToString());
            }
        }
    }
}