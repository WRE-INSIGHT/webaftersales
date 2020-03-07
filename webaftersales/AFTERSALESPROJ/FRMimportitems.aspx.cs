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
        DataSet ds = new DataSet();
        DataTable tb;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lbl = (Label)this.Master.FindControl("lblheader") as Label;
                lbl.Text = "Import Item";
                WebForm1 P = new WebForm1();
                ViewState["jo"] = P.jo;
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
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private void getdata()
        {
            try
            {

                tb = new DataTable();
                string cs = ConfigurationManager.ConnectionStrings["sqlcon1"].ConnectionString.ToString();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();

                    SqlCommand sqlcmd = new SqlCommand("select  row_number() OVER (order by kno) ID, kmdi_no,item_no,location from kmdi_fabrication_tb where job_order_no = '" + jo + "'", sqlcon);
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = sqlcmd;
                    da.Fill(tb);
                    GridView1.DataSource = tb;
                    GridView1.DataBind();
                    ViewState["tb"] = tb;

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());

            }


        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<int> idlist = new List<int>();
            if (ViewState["listid"] != null)
            {
                idlist = (List<int>)ViewState["listid"];
            }

            foreach (GridViewRow row in this.GridView1.Rows)
            {
                CheckBox cbx = (CheckBox)row.FindControl("cboxselect");

                var selectedkey = int.Parse(GridView1.DataKeys[row.RowIndex].Value.ToString());

                if (cbx.Checked)
                {
                    if (!idlist.Contains(selectedkey))
                    {
                        idlist.Add(selectedkey);
                    }
                }
                else
                {
                    if (idlist.Contains(selectedkey))
                    {
                        idlist.Remove(selectedkey);
                    }
                }
            }

            ViewState["listid"] = idlist;
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            List<int> idlist = ViewState["listid"] as List<int>;
            if (e.Row.RowType == DataControlRowType.DataRow && idlist != null)
            {
                var autoid = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
                if (idlist.Contains(autoid))
                {
                    CheckBox cbx = (CheckBox)e.Row.FindControl("cboxselect");
                    cbx.Checked = true;
                }
            }
        }

        protected void btnimport_Click(object sender, EventArgs e)
        {
            List<int> l = new List<int>();
            if ((List<int>)ViewState["listid"] == null)
            {
                l.Add(0);
            }
            else
            {
                l = ViewState["listid"] as List<int>;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(row.Cells[1].Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(row.Cells[1].Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            try
            {
                WebForm1 P = new WebForm1();
                for (int i = 0; i <= mytb.Rows.Count - 1; i++)
                {
                    int id = Convert.ToInt32(mytb.Rows[i]["id"].ToString());
                    if (l.Contains(id))
                    {
                        string sid, kno, itemno, location;
                        sid = P.sid;
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        itemno = mytb.Rows[i]["item_no"].ToString();
                        location = mytb.Rows[i]["location"].ToString();
                        insertrecord(sid, kno, itemno, location);
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "successfulmessage();", true);
                Response.Redirect("~/AFTERSALESPROJ/FRMreport.aspx");
            }


            ViewState["listid"] = l;



        }
        private void insertrecord(string sid, string kno, string itemno, string location)
        {
            string cs = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString.ToString();
            using (SqlConnection sqlcon = new SqlConnection(cs))
            {
                sqlcon.Open();
                string qry = " declare @id as integer = (select max(id)+1 from reporttb) " +
                    "insert into reporttb (id,sid,kno,itemno,location,specification)values" +
                    "(@id,'" + sid + "','" + kno + "','" + itemno + "','" + location + "','Window')";

                SqlCommand sqlcmd = new SqlCommand(qry, sqlcon);
                sqlcmd.ExecuteNonQuery();
            }
        }
    }
}